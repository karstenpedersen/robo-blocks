extends CharacterBody3D

@export var speed = 10
@export var accel = 70
const FRICTION = 70

var target_velocity = Vector3.ZERO


func player_movement(input, delta):
	if input: 
		velocity = velocity.move_toward(input * speed, delta * accel)
	else: 
		velocity = velocity.move_toward(Vector3(0,0,0), delta * FRICTION)

func _physics_process(delta):
	var input = Input.get_vector("move_left","move_right","move_up","move_down")
	input = Vector3(input.x, 0, input.y)
	player_movement(input, delta)
	move_and_slide()

#func _physics_process(delta: float) -> void:
	#var direction = Vector3.ZERO
	#
#
	#
	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
	#
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed
	#
	#velocity = target_velocity
	#move_and_slide()
