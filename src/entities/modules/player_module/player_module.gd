extends HeadModule
class_name PlayerModule


func _ready() -> void:
	super()
	lock_rotation = true


func _physics_process(delta):
	var input = get_input()
	player_movement(input, delta)


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var velocity = state.get_linear_velocity()

	if velocity.length() > speed:
		velocity = velocity.normalized() * speed
		
		# Apply the limited velocity back to the rigidbody
		state.set_linear_velocity(velocity)


#func _physics_process(delta: float) -> void:
	#var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#input = Vector3(input.x, 0, input.y).normalized()
	#apply_force(input * speed * delta)


func get_input():
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input


func player_movement(input, delta):
	# NOTE: We don't want the input to be normalized
	# as that will slow us down while turning
	
	rotation.y -= input.x * delta * rotation_speed
	apply_force(transform.basis.z.normalized() * input.y * acceleration * delta)


func _on_destroyed() -> void:
	Globals.player_died.emit()
