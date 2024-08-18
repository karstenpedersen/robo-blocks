extends HeadModule


var speed: float = 1250


func _ready() -> void:
	super()
	lock_rotation = true


func _physics_process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input = Vector3(input.x, 0, input.y).normalized()
	apply_force(input * speed * delta)


func _on_destroyed() -> void:
	Globals.player_died.emit()
