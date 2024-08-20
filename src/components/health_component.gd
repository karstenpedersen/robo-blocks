extends Node
class_name HealthComponent

@export_range(1, 999) var max_health: int = 5

var health: int = max_health

signal eliminated
signal damaged
signal healed
signal fully_healed
signal already_full_health


func hurt(amount: int):
	var new_health = max(0, health - amount)
	if new_health == 0 and health != 0:
		eliminated.emit()
	health = new_health
	damaged.emit()


func heal(amount: int):
	var prev_health = health
	health = min(health + amount, max_health)
	
	if prev_health == health and amount > 0:
		already_full_health.emit()
	elif health == max_health:
		fully_healed.emit()
	healed.emit()


func reset():
	health = max_health
