extends Node3D

@export var scale_amount = 12
@onready var hitbox_collision: CollisionShape3D = $Components/HitboxComponent/HitboxCollision
@onready var mesh_sphere: MeshInstance3D = $Visuals/MeshSphere


func _process(delta: float) -> void:
	var s = Vector3(1, 1, 1).normalized() * scale_amount * delta
	hitbox_collision.scale += s
	mesh_sphere.scale += s


func _on_timer_timeout() -> void:
	queue_free()
