extends MeshInstance3D

var target: Node3D

var turret: TargetingTurret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turret = $TargetingTurret
	print("target_set")
	turret.set_target(target)
	# NOTE: target must be set in main actor

func set_mode_idle():
	if randi() % 2 == 0:
		turret.set_mode_spin_clockwise()
	else:
		turret.set_mode_spin_counterclockwise()

func set_mode_targeting():
	turret.set_mode_targeting()

func set_target(t: Node3D):
	target = t
