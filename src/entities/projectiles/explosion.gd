extends Node3D

@export var scale_amount = 12
@export var scaleables: Array[Node3D]


func _process(delta: float) -> void:
	var s = Vector3(1, 1, 1).normalized() * scale_amount * delta
	for scaleable in scaleables:
		scaleable.scale += s


func _on_timer_timeout() -> void:
	ScreenShake.apply_shake(8, 1)
	queue_free()
