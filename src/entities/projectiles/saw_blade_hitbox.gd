extends Node3D

var creator: Node3D


func _process(delta: float) -> void:
	if creator:
		global_transform = creator.global_transform


func _on_life_time_component_timeout() -> void:
	queue_free()
