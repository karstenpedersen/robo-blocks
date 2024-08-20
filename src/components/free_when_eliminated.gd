extends Node
class_name FreeWhenEliminated

@export var actor: Node3D
@export var health_component: HealthComponent
@export var spawner_components: Array[SpawnerComponent]


func _ready() -> void:
	health_component.eliminated.connect(func():
		print("FREE")
		for spawner_component in spawner_components:
			spawner_component.spawn()
		actor.queue_free()
	)
