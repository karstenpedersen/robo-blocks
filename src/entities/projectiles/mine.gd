extends Node3D
class_name Mine

@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var activation_timer: Timer = $ActivationTimer

var creator
var can_explode = false


func _on_activation_timer_timeout() -> void:
	spawner_component.spawn()
	queue_free()


func _on_detect_group_component_group_entered(node: Node3D) -> void:
	if can_explode:
		activation_timer.start()


func _on_grace_period_timer_timeout() -> void:
	can_explode = true
