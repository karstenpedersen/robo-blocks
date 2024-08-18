extends Node3D
class_name SpawnerComponent

signal spawned(node: Node3D)

@export var object: PackedScene


func spawn():
	spawned.emit()
