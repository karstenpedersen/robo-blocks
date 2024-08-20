extends Area3D
class_name SnapPoint

@export var parent: BaseModule
@export var snappable = true

var target_module: DraggableComponent


func _on_area_entered(area: Area3D) -> void:
	if !snappable:
		return
	
	var parent_is_draggable = parent.is_in_group("draggable_module")
	var parent_is_module = parent.is_in_group("module")
	var area_is_draggable = area.is_in_group("draggable")
	
	# Check if colliding area is draggable
	var draggable_to_draggable = parent_is_draggable and \
			area != parent.draggable_component
	
	var draggable_to_head = parent_is_module and parent.index == 0
	
	if snappable and area_is_draggable and area.dragging and \
			(draggable_to_draggable or draggable_to_head) and \
			parent.is_mounted() and \
			area.parent.is_unmounted():
		area.snap_points.append(self)
	
