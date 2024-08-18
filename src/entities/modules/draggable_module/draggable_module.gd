extends BaseModule
class_name DraggableModule

@export var rotation_speed: float = 0.125

@onready var draggable_component: DraggableComponent = $Components/DraggableComponent

var rotation_tween

func _on_draggable_component_drag_started(node: DraggableComponent) -> void:
	# Disable rigidbody behavior
	lock_rotation = true
	freeze = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	# Reset rotation
	rotation_tween = get_tree().create_tween().bind_node(self)
	var rot = node.target_rotation
	rotation_tween.tween_property(self, "rotation_degrees", rot, rotation_speed)


func _on_draggable_component_drag_ended(node: Variant) -> void:
	# Enable rigidbody behavior
	lock_rotation = false
	freeze = false
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	
	# Kill tween
	if rotation_tween:
		rotation_tween.kill()


func _on_draggable_component_drag_rotated(node: DraggableComponent) -> void:
	rotation_tween = get_tree().create_tween().bind_node(self)
	rotation_tween.tween_property(self, "rotation_degrees", node.target_rotation, 0.1)


func _on_draggable_component_drag_moved(node: DraggableComponent) -> void:
	position = node.target_position
