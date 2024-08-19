extends Area3D
class_name DetectGroupComponent

signal group_entered(node: Node3D)
signal group_exited(node: Node3D)

@export var group: StringName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body: Node3D):
		if body.is_in_group(group):
			group_entered.emit(body)
	)
	body_exited.connect(func(body: Node3D):
		if body.is_in_group(group):
			group_exited.emit(body)
	)
