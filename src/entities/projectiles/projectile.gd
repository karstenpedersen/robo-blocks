extends Node3D

signal collided(node: Node3D)
signal destroyed(pos: Vector3)


func destroy():
	destroyed.emit(global_position)
	queue_free()


func _on_life_time_component_timeout() -> void:
	destroy()


func _on_hitbox_component_hit_hurtbox(hurtbox: HurtboxComponent) -> void:
	collided.emit(hurtbox)
	destroy()


func _on_lol_area_entered(area: Area3D) -> void:
	queue_free()
