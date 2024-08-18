extends Area3D
class_name DraggableComponent

signal drag_started(node)
signal drag_ended(node)
signal drag_moved(node)
signal drag_rotated(node)

@export var parent: Node3D
@export var snap_distance: float = 3

var dragging = false
var drag_offset = Vector3()
var target_position: Vector3
var target_rotation: Vector3
var snap_point: Node3D


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


func drag_move(pos: Vector3):
	print(snap_point)
	if snap_point and pos.distance_to(snap_point.position) < snap_distance:
		print("Snap: ", snap_point.position)
		target_position = snap_point.position
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


func _on_show_snap_area_body_entered(body: Node3D) -> void:
	if dragging and body != self and body.is_in_group("draggable"):
		pass


func _on_show_snap_area_body_exited(body: Node3D) -> void:
	if dragging and body != self and body.is_in_group("draggable"):
		pass
