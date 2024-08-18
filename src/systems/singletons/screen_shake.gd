extends Node

var shake_strength = 0.0
var shake_remain = 0.0
var shake_length = 0.0
var rng = RandomNumberGenerator.new()


func _process(_delta):
	shake_remain = max(0, shake_remain - ((1 / shake_length) * shake_strength))


func apply_shake(strength: float, length: float):
	if strength >= shake_strength and length > 0:
		shake_strength = strength
		shake_remain = strength
		shake_length = length


func get_shake_offset() -> Vector3:
	return Vector3(
		rng.randf_range(-shake_remain, shake_remain),
		0,
		rng.randf_range(-shake_remain, shake_remain)
	)
