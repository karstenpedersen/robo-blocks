extends StaticBody3D

enum EnemyMode {
	IDLE,
	FOLLOW_TARGET,
}

#@export var forward_accel = 4000
#@export var strafe_accel = 4000
#@export var max_speed = 4

## Distance at which the enemy tries to keep the player
#@export var follow_distance = 5
## Tolerance for follow distance
#@export var follow_distance_tolerance = 1
#
## Difference in radians where enemy will follow player
#@export var follow_angle_threshold = 0.2

@export var target: Node3D

var mode: EnemyMode
var turret: TargetingTurret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#lock_rotation = true
	#$TurretBlock.set_target(target)
	turret = $TargetingTurret
	turret.set_target(target)
	#turret.set_actor($TurretWeapon)
	set_mode(EnemyMode.IDLE)


func _physics_process(delta):
	#var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	movement(delta)
	#move_and_slide()

func movement(delta):
	match mode:
		EnemyMode.IDLE:
			pass
		EnemyMode.FOLLOW_TARGET:
			pass


func _on_detect_player_group_entered(player: Node3D) -> void:
	print("Detected player entered")
	set_mode(EnemyMode.FOLLOW_TARGET)

func _on_detect_player_group_exited(player: Node3D) -> void:
	print("Detected player exited")
	set_mode(EnemyMode.IDLE)

func set_mode(m: EnemyMode):
	if m == EnemyMode.IDLE:
		#$TurretBlock.set_mode_idle()
		turret.set_mode_idle()
	elif m == EnemyMode.FOLLOW_TARGET:
		turret.set_mode_targeting()
		#$TurretBlock.set_mode_targeting()
	mode = m
