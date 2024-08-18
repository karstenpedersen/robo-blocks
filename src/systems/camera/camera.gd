class_name Camera
extends Camera3D

enum CameraMode {
	NONE,
	FOLLOW_TARGET,
	FOLLOW_TARGET_AND_CURSOR,
	FREE_CAM
}


@export_category("Camera Modes")
@export var camera_mode: CameraMode
@export var target: Node3D
@export var target_cursor_values = Vector3(8, 1, 0)
@export var free_cam_speed = 5
@export var free_cam_sprint_scale = 2.5
@export var camera_height = 20

# Used for screen shake
var offset = Vector3.ZERO

@export_category("Smoothing")
@export var smoothing_enabled = true
@export_range(0, 1.0) var lock_strength = 0.2
#@export_range(1, 10) var smoothing_distance = 10


func _ready():
	Globals.camera = self


func _process(delta):
	var new_position: Vector3
	
	# Target is a point directly above the player
	new_position = target.position + Vector3(0, camera_height, 0)
	
	#match camera_mode:
		#CameraMode.FOLLOW_TARGET_AND_CURSOR:
			#var cursor_position = get_global_mouse_position()
			#var viewport_size = get_viewport_rect().size
			#var clamped = Vector2(
				#clamp(cursor_position.x, position.x - viewport_size.x, position.x + viewport_size.x),
				#clamp(cursor_position.y, position.y - viewport_size.y, position.y + viewport_size.y)
			#)
			#var k = target_cursor_values.x + target_cursor_values.y
			#new_position = Vector2(
				#(target.position.x * target_cursor_values.x + clamped.x * target_cursor_values.y) / k,
				#(target.position.y * target_cursor_values.x + clamped.y * target_cursor_values.y) / k
			#)
		#CameraMode.FOLLOW_TARGET:
			#new_position = target.position
		#CameraMode.FREE_CAM:
			#var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			#var should_sprint = Input.is_action_pressed("sprint")
			#var speed = free_cam_speed * max(1, int(should_sprint) * free_cam_sprint_scale)
			#new_position = position + input_direction * speed * delta
	
	# Smoothing
	if smoothing_enabled:
		new_position = lerp(position, new_position, lock_strength)
	
	# Screen shake
	offset = ScreenShake.get_shake_offset()
	
	position = new_position + offset
