extends MeshInstance3D

@export var speed = 800


func _process(delta: float) -> void:
	rotation.y -= speed * delta
