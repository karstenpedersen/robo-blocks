extends BaseModule
class_name HeadModule

@export var speed = 4
@export var rotation_speed = 2
@export var acceleration = 6000
@export var color_material: StandardMaterial3D

@export var modules: Array[DraggableModule]

var collisions: Dictionary = {}


func _ready() -> void:
	index = 0
	parent = self


func parent_add_module(module: DraggableModule, point: SnapPoint):
	print("ADD MODULE TO PARENT: ", module, ", ", point)
	var collision = CollisionShape3D.new()
	var shape = BoxShape3D.new() # Size defaults to Vector3(1, 1, 1)
	collision.shape = shape
	collisions[module] = collision
	
	# Convert point to position relative to parent
	var point_local_transform = parent.to_local(point.global_transform.origin)
	collision.position = point_local_transform
	
	parent.add_child(collision)
	
	# Visualize collisions
	#var mesh_instance = MeshInstance3D.new()
	#var mesh = BoxMesh.new()# Size defaults to Vector3(1, 1, 1)
	#mesh_instance.mesh = mesh
	#mesh_instance.transform = collision.transform
	#parent.add_child(mesh_instance)
	
	module.destroyed.connect(_on_module_destroyed)
	module.unmounted.connect(_on_module_unmounted)


func parent_remove_module(module: DraggableModule):
	pass


func _on_module_unmounted(module: BaseModule, parent: HeadModule):
	collisions[module].queue_free()
	module.unmounted.disconnect(_on_module_unmounted)


func _on_module_destroyed(module: BaseModule):
	collisions[module].queue_free()
	module.destroyed.disconnect(_on_module_destroyed)
