extends Area3D

signal collided
signal destroyed


@export var speed = 15

@onready var life_timer = $LifeTimer as Timer

var velocity = Vector3.ZERO
var g = Vector3.FORWARD

func _ready() -> void:
	life_timer.start()


func _physics_process(delta):
	velocity += g * delta * speed
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta


func _on_area_entered(area: Area3D) -> void:
	collided.emit(transform.origin, area)
	destroyed.emit(transform.origin)
	print("Collided")
	queue_free()


func _on_life_timer_timeout() -> void:
	destroyed.emit(transform.origin)
	queue_free()
