extends Area3D
class_name HurtboxComponent

signal hurtbox_entered(hitbox: HitboxComponent)

@export var disable_invincible_collisions = true

var is_invincible = false :
	set(value):
		is_invincible = value
		if not disable_invincible_collisions:
			return
		for child in get_children():
			if child is CollisionShape3D or child is CollisionPolygon3D:
				child.set_deferred("disabled", is_invincible)
