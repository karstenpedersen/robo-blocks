extends Path3D
class_name PathComponent

@export var speed: int = 5

@onready var path_follow_component: PathFollow3D = $PathFollowComponent


func _process(delta: float) -> void:
	path_follow_component.progress += speed * delta
