extends Area3D
class_name SnapPoint

@export var parent: BaseModule

var target_module: DraggableComponent


func _on_area_entered(area: Area3D) -> void:
	var parent_is_draggable = parent.is_in_group("draggable_module")
	if ((parent_is_draggable and \
			area.is_in_group("draggable") and \
			area != parent.draggable_component) or 
			(!parent_is_draggable)) and \
			area.parent.index == -1 and \
			parent.index > -1 and \
			area.dragging:
		area.snap_points.append(self)
	
