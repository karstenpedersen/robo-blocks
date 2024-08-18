extends Area3D
class_name SnapPoint

@export var parent: BaseModule

var target_module: DraggableComponent


func _on_area_entered(area: Area3D) -> void:
	if area != parent.draggable_component and \
			area.is_in_group("draggable") and \
			area.dragging:
		area.snap_points.append(self)
