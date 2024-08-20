extends Path3D
class_name FollowPathComponent

@export var actor: Node3D
@export var path: Array[Node3D]

var path_index = 0
var target: Node3D:
	get:
		if len(path) == 0:
			return null
		return path[path_index]


func _process(delta: float) -> void:
	if !target:
		return
	if actor.global_position.distance_to(target.global_position) <= 2:
		path_index += 1
		if path_index == len(path):
			path_index = 0
