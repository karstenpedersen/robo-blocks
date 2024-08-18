extends CharacterBody3D

@export var speed = 10
@export var accel = 20
@export var friction = 10

var velocity_1d = 0.0

@export var rotation_speed = 4


func get_input():
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input


func player_movement(input, delta):
	# NOTE: We don't want the input to be normalized
	# as that will slow us down while turning
	if input.y != 0:
		# Forward and backwards movement
		velocity_1d = lerp(velocity_1d, input.y * speed, delta * accel)
		#velocity = velocity.move_toward(direction * speed, delta * accel)
	else: 
		#velocity = velocity.move_toward(Vector3.ZERO, delta * friction)
		velocity_1d = lerp(velocity_1d, 0.0, delta * friction)
		
	var direction = transform.basis.z.normalized()
	velocity = direction * velocity_1d
	#rotation.y = lerp(rotation.y, rotation.y - input.x, delta * rotation_speed)
	rotation.y = rotation.y - input.x * delta * rotation_speed


func _physics_process(delta):
	#var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var input = get_input()
	player_movement(input, delta)
	move_and_slide()
