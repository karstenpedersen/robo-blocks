extends Node
class_name LinkHurtboxHealthComponent

@export var actor: Node3D
@export var health_component: HealthComponent
@export var hurtbox_component: HurtboxComponent
@export var knockback_component: KnockbackComponent


func _ready() -> void:
	hurtbox_component.hurtbox_entered.connect(func(hitbox: HitboxComponent):
		if health_component:
			health_component.hurt(hitbox.damage)
		if !knockback_component:
			return
		knockback_component.apply_knockback((actor.global_position \
				- hitbox.start_position).normalized() * hitbox.knockback_force)
	)
