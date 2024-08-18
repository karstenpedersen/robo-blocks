extends Timer
class_name TimerComponent

signal looped_around

@export var cooldowns: Array[float] = [1]

var cooldown_index = 0


func _ready() -> void:
	one_shot = true
	timeout.connect(_on_timeout)
	start()


func _on_timeout():
	cooldown_index += 1
	if cooldown_index == len(cooldowns):
		cooldown_index = 0
		looped_around.emit()
	wait_time = cooldowns[cooldown_index]
	start()
