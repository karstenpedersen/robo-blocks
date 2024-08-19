extends Area3D
class_name DraggableComponent

signal drag_started(node)
signal drag_ended(node)
signal drag_moved(node)
signal drag_rotated(node)
signal mounted(module, point)

@export var parent: Node3D
@export var snap_distance: float = 1

var dragging = false
var drag_offset = Vector3()
var target_position: Vector3
var target_rotation: Vector3
var snap_points: Array[SnapPoint]
var snap_point: SnapPoint:
	get:
		if len(snap_points) == 0:
			return null
		return snap_points[0]


func _ready() -> void:
	target_position = parent.position


func drag_start(pos: Vector3):
	# Reset rotation
	target_rotation = get_reset_rotation()
	dragging = true
	drag_started.emit(self)


func drag_end():
	dragging = false
	drag_ended.emit(self)
	
	for point in snap_points:
		mounted.emit(point.parent, point)


func drag_move(pos: Vector3):
	if snap_point:
		if pos.distance_to(target_position) <= snap_distance:
			target_position = snap_point.global_position
		else:
			snap_points.clear()
	else:
		target_position = Vector3(pos.x, 1, pos.z)
	drag_moved.emit(self)


func drag_rotate(angle: float):
	target_rotation = Vector3(0, target_rotation.y + angle, 0)
	drag_rotated.emit(self)


func get_reset_rotation() -> Vector3:
	var y = target_rotation.y
	y = round(y / 90) * 90
	return Vector3(0, y, 0)
