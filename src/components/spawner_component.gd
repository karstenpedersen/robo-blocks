extends Node3D
class_name SpawnerComponent

signal spawned(node: Node3D)

@export var actor: Node3D
@export var scene: PackedScene


func spawn():
	if !scene:
		return
	var instance = scene.instantiate()
	instance.global_transform = global_transform
	Globals.scene_node.add_sibling(instance)
	if "creator" in instance:
		instance.creator = actor
	spawned.emit(instance)
