extends Node3D

@export var modules: Array[PackedScene] = []
@export var module_slots: Array[ModuleSlot] = []


func _ready() -> void:
	for slot in module_slots:
		var instance = slot.module_scene.instantiate()
		instance.position = position + Vector3(slot.offset.x, 0, slot.offset.y)
		self.add_child(instance)
		instance.owner = self
