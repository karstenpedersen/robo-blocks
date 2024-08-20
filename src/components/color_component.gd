extends Node
class_name ColorComponent

@export var parts: Array[MeshInstance3D]


func set_color(material: StandardMaterial3D):
	for part in parts:
		for i in range(part.mesh.get_surface_count()):
			print(i, ": ", part, ", ", material)
			part.set_surface_override_material(i, material)


func clear_color():
	set_color(null)
