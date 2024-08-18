extends Node
class_name MoveStraightComponent

@export var actor: Node3D
@export var speed: float = 10
@export var gravity: Vector3 = Vector3.FORWARD


func _physics_process(delta):
	actor.transform.origin += (-actor.transform.basis.z).normalized() * speed * delta
