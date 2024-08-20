extends RigidBody3D
class_name BaseModule

signal destroyed(module: BaseModule)
signal added_neighbour_module(module: BaseModule)
signal removed_neighbour_module(module: BaseModule)
signal mounted(module: BaseModule, parent: HeadModule)
signal unmounted(module: BaseModule, parent: HeadModule)

@export var stats: ModuleStats
@export var color_components: Array[ColorComponent]

# Components
@onready var health_component: HealthComponent = $Components/HealthComponent
@onready var hurtbox_component: HurtboxComponent = $Components/HurtboxComponent
@onready var knockback_component: KnockbackComponent = $Components/KnockbackComponent

@onready var snap_points: Node3D = $SnapPoints

var index: int = -1
var neighbours: Array[Dictionary]
var parent: HeadModule
var connection_point: Node3D:
	get:
		if len(neighbours) == 0:
			return null
		return neighbours[0]["point"]
var y_rotation_offset = 0

var colliding_points: Array[SnapPoint]


func _ready() -> void:
	snap_points.hide()


func create_module_connection(module: BaseModule, point: SnapPoint):
	_add_neighbour_module(module, point)
	module._add_neighbour_module(self, point)


func destroy_module_connection(module: BaseModule):
	_remove_neighbour_module(module)
	module._remove_neighbour_module(self)


func _add_neighbour_module(module: BaseModule, point: SnapPoint):
	if index == -1:
		mount(module, point)
	elif module.index + 1 < index:
		index = module.index + 1
	
	# Add neighbour dict
	neighbours.append({
		"module": module,
		"point": point
	})
	added_neighbour_module.emit(module)


func _remove_neighbour_module(module: BaseModule):
	# Remove neighbour module
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
		unmount()


func destroy():
	if parent and is_instance_valid(parent):
		parent.parent_remove_module(self)
	unmount()
	queue_free()
	destroyed.emit()


func freeze_rigidbody():
	freeze_mode = FREEZE_MODE_KINEMATIC
	lock_rotation = true
	# freeze = true
	#set_collision_layer_value(1, false)
	#set_collision_mask_value(1, false)


func unfreeze_rigidbody():
	freeze_mode = FREEZE_MODE_STATIC
	lock_rotation = false
	freeze = false
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)


func disable_rigidbody():
	lock_rotation = true
	freeze = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)


func enable_rigidbody():
	lock_rotation = false
	freeze = false
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)


func is_mounted() -> bool:
	return index != -1


func is_unmounted() -> bool:
	return index == -1


func mount(module: BaseModule, point: SnapPoint):
	disable_rigidbody()
	parent = module.parent
	parent.parent_add_module(self, point)
	mounted.emit(self, parent)
	index = module.index + 1
	for color_component in color_components:
		color_component.set_color(parent.color_material)


func unmount():
	enable_rigidbody()
	index = -1
	for neighbour in neighbours:
		neighbour["module"]._remove_neighbour_module(self)
		# destroy_module_connection(neighbour["module"])
	neighbours.clear()
	unmounted.emit(self, parent)
	parent = null
	for color_component in color_components:
		color_component.clear_color()


func _on_health_component_eliminated() -> void:
	destroy()


func _on_hurtbox_component_hurtbox_entered(hitbox: HitboxComponent) -> void:
	health_component.hurt(hitbox.damage)
	knockback_component.apply_knockback((global_position \
			- hitbox.start_position).normalized() * hitbox.knockback_force)


func _on_snap_point_area_area_entered(area: Area3D) -> void:
	print(self, ", snap point area, ", area, ", for module: ", self, ", groups: ", area.get_groups())
	var is_point = area.is_in_group("snap_point")
	if is_point and area.snappable:
		print("ADD POINT: ", area)
		colliding_points.append(area)


func _on_snap_point_area_area_exited(area: Area3D) -> void:
	if area.is_in_group("snap_point"):
		colliding_points.erase(area)
