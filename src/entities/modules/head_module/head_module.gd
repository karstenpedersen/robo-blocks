extends BaseModule
class_name HeadModule

@export var speed = 4
@export var rotation_speed = 2
@export var acceleration = 6000


func _ready() -> void:
	index = 0
	parent = self
