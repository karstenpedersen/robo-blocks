extends Area3D
class_name SnapPoint

@export var parent: BaseModule

var target_module: BaseModule


func add_neighbour():
	parent.add_neighbour_module(target_module, self)
	target_module.add_neighbour_module(parent, self)
	target_module.draggable_component.snap_point = null


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("draggable_module") and body.draggable_component.dragging:
		body.draggable_component.snap_point = self
		target_module = body


func _on_body_exited(body: Node3D) -> void:
	if body == target_module:
		parent.remove_neighbour_module(target_module)
		target_module.draggable_component.snap_point = null
