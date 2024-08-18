extends RigidBody3D
class_name BaseModule

signal destroyed
signal added_neighbour_module(module)
signal removed_neighbour_module(module)

@export var stats: ModuleStats

# Components
@onready var health_component: HealthComponent = $Components/HealthComponent

@onready var snap_points: Node3D = $SnapPoints

var index: int = -1
var neighbours: Array[Dictionary]
var parent: BaseModule
var connection_point: Node3D:
	get:
		if len(neighbours) == 0:
			return null
		return neighbours[0]["point"]


func _physics_process(delta: float) -> void:
	if connection_point and index != 0:
		position = connection_point.global_position


func create_module_connection(module: BaseModule, point: SnapPoint):
	# TODO: How to do this in correct order if multiple connections are made
	add_neighbour_module(module, point)
	module.add_neighbour_module(self, point)


func add_neighbour_module(module: BaseModule, point: SnapPoint):
	if index == -1:
		connection_point = point
		disable_rigidbody()
	if index == -1 or module.index + 1 < index:
		index = module.index + 1
	neighbours.append({
		"module": module,
		"point": point
	})
	added_neighbour_module.emit(module)
	print(self, ", index: ", index, ", #neighbours: ", len(neighbours), ", ", neighbours)

func remove_neighbour_module(module: BaseModule):
	for neighbour in neighbours:
		if neighbour["module"] == module:
			neighbours.erase(neighbour)
	removed_neighbour_module.emit(module)
	
	# Check if there are any neighbours with smaller indecies
	if len(neighbours) == 0:
		return
	var found_smaller_index = false
	for neighbour in neighbours:
		if neighbour["module"].index < index:
			found_smaller_index = true
	if !found_smaller_index and index != 0: # Skip parent
		remove_from_neighbours()


func destroy():
	remove_from_neighbours()
	queue_free()
	destroyed.emit()


func remove_from_neighbours():
	for neighbour in neighbours:
		neighbour["module"].remove_neighbour_module(self)
	neighbours.clear()
	index = -1
	enable_rigidbody()


func disable_rigidbody():
	print("DISABLE")
	lock_rotation = true
	freeze = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)


func enable_rigidbody():
	lock_rotation = false
	freeze = false
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)


func _on_health_component_eliminated() -> void:
	destroy()
