extends Node3D
class_name SpawnerComponent

signal spawned(node: Node3D)

@export var scene: PackedScene


func spawn():
	var instance = scene.instantiate()
	instance.global_transform = global_transform
	owner.owner.add_sibling(instance)
	spawned.emit(instance)
