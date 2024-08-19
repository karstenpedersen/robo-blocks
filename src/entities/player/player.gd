extends RigidBody3D

@export var max_speed = 10
@export var accel = 8000
@export var friction = 100

var velocity_1d = 0.0

@export var rotation_speed = 4

func _ready() -> void:
	lock_rotation = true


func get_input():
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input


func player_movement(input, delta):
	# NOTE: We don't want the input to be normalized
	# as that will slow us down while turning
	
	# Turning
	rotation.y = rotation.y - input.x * delta * rotation_speed
	# Moving
	apply_force(transform.basis.z.normalized() * input.y * accel * delta)
	
	#print(linear_velocity.length())
	
	#if input.y != 0:
		# Forward and backwards movement
		#velocity_1d = lerp(velocity_1d, input.y * speed, delta * accel)
		
	#else: 
		#velocity = velocity.move_toward(Vector3.ZERO, delta * friction)
		#velocity_1d = lerp(velocity_1d, 0.0, delta * friction)
		#apply_force(-transform.basis.z.normalized() * friction * delta)
	
	
	#var direction = transform.basis.z.normalized()
	#velocity = direction * velocity_1d
	#rotation.y = lerp(rotation.y, rotation.y - input.x, delta * rotation_speed)


func _physics_process(delta):
	#var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var input = get_input()
	player_movement(input, delta)
	#move_and_slide()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var velocity = state.get_linear_velocity()

	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
		
		# Apply the limited velocity back to the rigidbody
		state.set_linear_velocity(velocity)
