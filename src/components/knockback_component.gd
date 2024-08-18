extends Node
class_name KnockbackComponent

@export var actor: RigidBody3D
@export var knockback_force: float = 2


func apply_knockback(knockback: Vector3):
	actor.apply_impulse(knockback * knockback_force)
