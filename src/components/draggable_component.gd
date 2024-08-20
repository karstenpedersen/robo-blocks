extends Area3D
class_name DraggableComponent

signal drag_started(node)
signal drag_ended(node)
signal drag_moved(node)
signal drag_rotated(node: DraggableComponent, amount: float)
signal drag_mounted(module, point)

@export var parent: Node3D
@export var snap_distance: float = 1

var dragging = false
var drag_offset = Vector3()
var target_position: Vector3
var target_rotation: Vector3
var snap_points: Array[SnapPoint]
var snap_point: SnapPoint:
	get:
		if len(snap_points) == 0 or !is_instance_valid(snap_points[0]):
			return null
		return snap_points[0]
var y_rotation_offset = 0
var parent_is_module = false


func _ready() -> void:
	target_position = parent.global_position
	target_rotation = parent.global_rotation
	parent_is_module = parent.is_in_group("module")


func drag_start(pos: Vector3):
	# Reset rotation
	target_position = parent.global_position
	target_rotation = Vector3(0, parent.global_rotation.y, 0)
	dragging = true
	drag_started.emit(self)


func drag_end():
	dragging = false
	drag_ended.emit(self)
	
	if !parent_is_module:
		return
	for point in parent.colliding_points:
		for possible_point in point.parent.colliding_points:
			if possible_point.parent == parent:
				drag_mounted.emit(point.parent, point)


func drag_move(pos: Vector3):
	if snap_point and is_instance_valid(snap_point):
		if pos.distance_to(target_position) <= snap_distance:
			target_position = snap_point.global_position
			target_rotation = snap_point.global_rotation
			#target_rotation.y += y_rotation_offset
		else:
			snap_points.clear()
	else:
		target_position = Vector3(pos.x, 1, pos.z)
	drag_moved.emit(self)


func drag_rotate(amount: float):
	if snap_point:
		snap_point.rotation_degrees.y += amount
	#y_rotation_offset += amount
	#target_rotation = Vector3(0, target_rotation.y + amount, 0)
	drag_rotated.emit(self, amount)


func get_reset_rotation() -> Vector3:
	var y = target_rotation.y
	y = round(y / 90) * 90
	return Vector3(0, y, 0)
