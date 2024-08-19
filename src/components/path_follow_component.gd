extends Path3D
class_name PathComponent

@export var speed: int = 5
@export var path_follow: PathFollow3D


func _process(delta: float) -> void:
	path_follow.progress += speed * delta
