extends Node
class_name SpawnerTimerComponent

@export var timer_component: TimerComponent
@export var spawner_components: Array[SpawnerComponent]


func _ready() -> void:
	for spawner_component in spawner_components:
		timer_component.cooled_down.connect(spawner_component.spawn)
