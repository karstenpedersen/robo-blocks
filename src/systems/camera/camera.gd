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
@export var target_cursor_values = Vector2(4, 1)
@export var free_cam_speed = 200
@export var free_cam_sprint_scale = 2.5
@export var camera_height = 20

# Used for screen shake
var offset = Vector3.ZERO

@export_category("Smoothing")
@export var smoothing_enabled = true
@export_range(0.0, 1.0) var locking_strength = 0.05
#@export_range(1, 10) var smoothing_distance = 10


func _ready():
	Globals.camera = self


func _process(delta):
	var new_position: Vector3
	
	# Default is follow target position.
	# For resetting camera to player when cursor goes out of screen.
	new_position = target.position + Vector3(0, camera_height, 0)
	
	
	match camera_mode:
		CameraMode.FOLLOW_TARGET_AND_CURSOR:
			#var cursor_position = get_global_mouse_position()
			#var viewport_size = get_viewport_rect().size
			var viewport_size = get_viewport().size
			var mouse_pos = get_viewport().get_mouse_position()
			var ray_length = 100
			var from = project_ray_origin(mouse_pos)
			var to = from + project_ray_normal(mouse_pos) * ray_length
			var space = get_world_3d().direct_space_state
			var ray_query = PhysicsRayQueryParameters3D.new()
			ray_query.from = from
			ray_query.to = to
			ray_query.collide_with_areas = true
			var raycast_result = space.intersect_ray(ray_query)
			if not raycast_result.is_empty():
				var cursor_position = raycast_result.position
				
				var clamped = Vector2(
					clamp(cursor_position.x, position.x - viewport_size.x, position.x + viewport_size.x),
					clamp(cursor_position.z, position.z - viewport_size.y, position.z + viewport_size.y)
				)
				var k = target_cursor_values.x + target_cursor_values.y
				new_position = Vector3(
					(target.position.x * target_cursor_values.x + clamped.x * target_cursor_values.y) / k,
					camera_height,
					(target.position.z * target_cursor_values.x + clamped.y * target_cursor_values.y) / k
				)
		CameraMode.FOLLOW_TARGET:
			# Target is a point directly above the player
			new_position = target.position + Vector3(0, camera_height, 0)
		CameraMode.FREE_CAM:
			var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			input_direction = Vector3(input_direction.x, 0, input_direction.y)
			var should_sprint = Input.is_action_pressed("sprint")
			var speed = free_cam_speed * max(1, int(should_sprint) * free_cam_sprint_scale)
			new_position = position + input_direction * speed * delta
		CameraMode.NONE:
			new_position = position
	
	# Smoothing
	if smoothing_enabled:
		new_position = lerp(position, new_position, locking_strength)
	
	# Screen shake
	offset = ScreenShake.get_shake_offset()
	
	position = new_position + offset
