extends Timer
class_name TimerComponent

signal looped_around
signal cooled_down

@export var cooldowns: Array[float] = [1]

var cooldown_index = 0
var has_executed = false


func _ready() -> void:
	one_shot = true
	timeout.connect(_on_timeout)


func _on_timeout():
	if has_executed:
		cooled_down.emit()
		cooldown_index += 1
		if cooldown_index == len(cooldowns):
			cooldown_index = 0
			looped_around.emit()
	wait_time = cooldowns[cooldown_index]
	has_executed = true
	start()
