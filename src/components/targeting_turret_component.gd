extends Node3D
class_name TargetingTurret

enum TurretMode {
	IDLE,
	SPIN_CLOCKWISE,
	SPIN_COUNTERCLOCKWISE,
	TARGETING,
}

@export var actor: Node3D
@export var target: Node3D
@export var turn_speed = 2

var mode = TurretMode.IDLE

func set_target(t: Node3D):
	target = t

func set_actor(a: Node3D):
	actor = a

func set_mode_targeting():
	mode = TurretMode.TARGETING

func set_mode_idle():
	mode = TurretMode.IDLE

func set_mode_spin_clockwise():
	mode = TurretMode.SPIN_CLOCKWISE

func set_mode_spin_counterclockwise():
	mode = TurretMode.SPIN_COUNTERCLOCKWISE

# Returns abseloute angle diff between target and turret
func get_angle_diff():
	var direction = actor.position.direction_to(target.position)
	var target_angle = atan2(direction.x, direction.z)
	return abs(actor.rotation.y - target_angle)

func _physics_process(delta: float) -> void:
	match mode:
		TurretMode.IDLE:
			pass
		TurretMode.SPIN_CLOCKWISE:
			actor.rotation.y -= delta * turn_speed
		TurretMode.SPIN_COUNTERCLOCKWISE:
			actor.rotation.y += delta * turn_speed
		TurretMode.TARGETING:
			var direction = actor.position.direction_to(target.position)
			var target_angle = atan2(direction.x, direction.z)
			actor.rotation.y = rotate_toward(actor.rotation.y, target_angle, turn_speed * delta)
