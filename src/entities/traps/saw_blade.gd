extends Node3D
class_name SawBlade

@export var speed: int = 1
@export var path: Path3D

@onready var follow_path_component: FollowPathComponent = $Components/FollowPathComponent
