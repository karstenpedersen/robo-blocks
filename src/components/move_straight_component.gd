extends Node
class_name MoveStraightComponent

@export var actor: Node3D
@export var speed: float = 200
@export var gravity: Vector3 = Vector3.FORWARD

var velocity = Vector3.ZERO


func _physics_process(delta):
	velocity += gravity.normalized() * delta * speed
	actor.look_at(actor.transform.origin + velocity.normalized(), Vector3.UP)
	actor.transform.origin += velocity * delta
