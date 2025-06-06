extends Area3D
class_name HitboxComponent

signal hit_hurtbox(hurtbox: HurtboxComponent)

@export var damage: int = 1
@export var knockback_force: float = 1
@export var destroy_on_hit = false

var start_position: Vector3


func _ready() -> void:
	start_position = global_position
	area_entered.connect(_on_hurtbox_entered)


func _on_hurtbox_entered(hurtbox):
	if hurtbox.is_in_group("wall"):
		queue_free()
	if not hurtbox is HurtboxComponent:
		return
	if hurtbox.is_invincible:
		return
	
	hit_hurtbox.emit(hurtbox)
	hurtbox.hurtbox_entered.emit(self)
	
	if destroy_on_hit:
		queue_free()
