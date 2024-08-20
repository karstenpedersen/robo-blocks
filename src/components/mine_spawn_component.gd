extends Node
class_name MineSpawnComponent

@export var actor: BaseModule
@export var spawner_component: SpawnerComponent
@export var min_moved_distance: float = 10

var previous_position
var distance_moved: float = 0


func _ready() -> void:
	previous_position = actor.global_position


func _process(delta: float) -> void:
	distance_moved += previous_position.distance_to(actor.global_position)
	previous_position = actor.global_position
	if actor.is_mounted() and distance_moved >= min_moved_distance:
		spawner_component.spawn()
		distance_moved -= min_moved_distance
