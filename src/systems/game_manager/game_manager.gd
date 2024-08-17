extends Node

@onready var pause_menu = $PauseMenu
var paused = false

func _ready() -> void:
	pause_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		pause_menu.pause()
		Engine.time_scale = 0
		
	paused = !paused
