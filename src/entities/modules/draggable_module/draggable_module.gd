extends BaseModule
class_name DraggableModule

@export var rotation_speed: float = 0.125

@onready var draggable_component: DraggableComponent = $Components/DraggableComponent

var rotation_tween


func _process(delta: float) -> void:
	if parent and connection_point and index != 0:
		#global_transform = connection_point.global_transform
		#rotation_degrees.y += y_rotation_offset
		var y_rotation_offset = draggable_component.target_rotation.y - \
				connection_point.rotation_degrees.y
		print("Rotation offset: ", y_rotation_offset)
		position = connection_point.global_position
		rotation = connection_point.global_rotation
		rotation_degrees.y += y_rotation_offset


func _on_draggable_component_drag_started(node: DraggableComponent) -> void:
	disable_rigidbody()
	
	if is_mounted():
		unmount()
	
	# Reset rotation
	#if rotation_degrees == node.target_rotation:
	#	return
	rotation_tween = get_tree().create_tween().bind_node(self)
	rotation_tween.tween_property(self, "rotation_degrees", \
			node.target_rotation, rotation_speed)


func _on_draggable_component_drag_ended(node: Variant) -> void:
	enable_rigidbody()
	
	# Kill tween
	if rotation_tween:
		rotation_tween.kill()


func _on_draggable_component_drag_rotated(node: DraggableComponent, amount: float) -> void:
	#rotation_tween = get_tree().create_tween().bind_node(self)
	#rotation_tween.tween_property(self, "rotation_degrees", node.target_rotation, 0.1)
	rotation_degrees.y = node.target_rotation.y


func _on_draggable_component_drag_moved(node: DraggableComponent) -> void:
	position = node.target_position


func _on_draggable_component_mounted(module: BaseModule, point: SnapPoint) -> void:
	create_module_connection(module, point)
