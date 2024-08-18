extends RigidBody3D
class_name BaseModule

signal destroyed
signal added_neighbour_model(module)
signal removed_neighbour_module(module)

@export var stats: ModuleStats

# Components
@onready var health_component: HealthComponent = $Components/HealthComponent

@onready var snap_points: Node3D = $SnapPoints
@onready var show_snap_area: Area3D = $ShowSnapArea

var index: int = -1
var neighbours: Array[BaseModule]
var parent: BaseModule
var connection_point: Node3D


func add_neighbour_module(module: BaseModule, point: Node3D):
	if index == -1:
		connection_point = point
	if index == -1 or module.index + 1 < index:
		index = module.index + 1 
	neighbours.append(module)
	added_neighbour_model.emit(module)


func remove_neighbour_module(module: BaseModule):
	neighbours.erase(module)
	removed_neighbour_module.emit(module)
	
	var found_smaller_index = false
	for neighbour in neighbours:
		if neighbour.index < index:
			found_smaller_index = true
	if !found_smaller_index:
		destroy()


func destroy():
	remove_from_neighbours()
	queue_free()
	destroyed.emit()


func remove_from_neighbours():
	for neighbour in neighbours:
		neighbour.remove_neighbour(self)
	


func _on_health_component_eliminated() -> void:
	destroy()
