extends RigidBody3D
class_name Draggable

signal drag_started(node)
signal drag_ended(node)
signal drag_moved(node)
signal module_connected(node)
signal module_disconnected(node)
signal destroyed(node)

@onready var snap_points: Node3D = $SnapPoints
@onready var show_snap_area: Area3D = $ShowSnapArea

var dragging = false
var drag_offset = Vector3()
var target_position: Vector3
var tween


func _ready() -> void:
	target_position = position
	# TODO: snap_points.hide()


func _process(delta: float) -> void:
	if dragging:
		position = target_position


func drag_start(pos: Vector3):
	# Disable rigidbody behavior
	lock_rotation = true
	freeze = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	# Reset position
	tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "rotation_degrees", get_reset_rotation(), 0.125)
	
	dragging = true
	drag_started.emit(self)


func drag_end():
	# Kill tween
	if tween:
		tween.kill()
	
	# Enable rigidbody behavior
	lock_rotation = false
	freeze = false
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	
	dragging = false
	drag_ended.emit(self)


func drag_move(pos: Vector3):
	target_position = Vector3(pos.x, 1, pos.z)
	drag_moved.emit(self)


func drag_rotate(angle: float):
	tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "rotation_degrees", Vector3(0, rotation_degrees.y + angle, 0), 0.1)


func get_reset_rotation() -> Vector3:
	var y = rotation_degrees.y
	y = round(y / 90) * 90
	return Vector3(0, y, 0)


func _on_show_snap_area_body_entered(body: Node3D) -> void:
	if dragging and body != self and body.is_in_group("draggable"):
		pass


func _on_show_snap_area_body_exited(body: Node3D) -> void:
	if dragging and body != self and body.is_in_group("draggable"):
		pass
