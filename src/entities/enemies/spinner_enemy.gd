extends RigidBody3D

enum EnemyMode {
	IDLE,
	WANDER,
	FOLLOW_TARGET,
}

@export var forward_accel = 4000
@export var strafe_accel = 4000
@export var max_speed = 4

# Distance at which the enemy tries to keep the player
@export var follow_distance = 5
# Tolerance for follow distance
@export var follow_distance_tolerance = 1

# Difference in radians where enemy will follow player
@export var follow_angle_threshold = 0.2

@export var target: Node3D

var mode: EnemyMode
var turret: TargetingTurret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true
	turret = $TargetingTurret
	turret.set_target(target)
	turret.set_actor(self)
	if randi() % 2 == 0:
		turret.set_mode_spin_clockwise()
	else:
		turret.set_mode_spin_counterclockwise()
	set_mode(EnemyMode.IDLE)


func _physics_process(delta):
	#var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	movement(delta)
	#move_and_slide()

func movement(delta):
	match mode:
		EnemyMode.IDLE:
			pass
		EnemyMode.WANDER:
			apply_force(transform.basis.z.normalized() * forward_accel * delta)
		EnemyMode.FOLLOW_TARGET:
			var target_dir = position.direction_to(target.position)
			var distance = position.distance_to(target.position)
			var angle_diff = turret.get_angle_diff()
			var distance_diff = abs(distance - follow_distance)
			#if angle_diff < follow_angle_threshold:
			# Turret is pointing at player
			if distance_diff > follow_distance_tolerance:
				# Adjust distance to player
				if distance > follow_distance:
					# Follow player
					apply_force(target_dir.normalized() * forward_accel * delta)
				elif distance < follow_distance:
					# Move away from player
					apply_force(-target_dir.normalized() * forward_accel * delta)
			else:
				# Strafe around player
				var strafe_dir = -target_dir.cross(transform.basis.y).normalized()
				apply_force(strafe_dir * strafe_accel * delta)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var velocity = state.get_linear_velocity()
	
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
		
		# Apply the limited velocity back to the rigidbody
		state.set_linear_velocity(velocity)

func _on_detect_player_group_entered(player: Node3D) -> void:
	print("Detected player entered")
	set_mode(EnemyMode.FOLLOW_TARGET)

func _on_detect_player_group_exited(player: Node3D) -> void:
	print("Detected player exited")
	set_mode(EnemyMode.IDLE)

func _on_idle_timer_timeout() -> void:
	if mode == EnemyMode.IDLE:
		set_mode(EnemyMode.WANDER)

func _on_wander_timer_timeout() -> void:
	if mode == EnemyMode.WANDER:
		set_mode(EnemyMode.IDLE)

func set_mode(m: EnemyMode):
	if m == EnemyMode.IDLE:
		$IdleTimer.start(randf_range(0.5, 2))
		#if randi() % 2 == 0:
			#turret.set_mode_spin_clockwise()
		#else:
			#turret.set_mode_spin_counterclockwise()
	elif m == EnemyMode.WANDER:
		$WanderTimer.start(randf_range(0.5, 2))
		#turret.set_mode_idle()
	#elif m == EnemyMode.FOLLOW_TARGET:
		#turret.set_mode_targeting()
	mode = m


func _on_health_component_eliminated() -> void:
	queue_free()
