extends Node

@onready var pause_menu = $PauseMenu
@onready var end_menu = $EndMenu
var paused = false
var dead = false

func _ready() -> void:
	pause_menu.hide()
	end_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
	if Input.is_action_just_pressed("death"):
		endMenu()

func pauseMenu():
	if !paused and dead == false:
		pause_menu.show()
		pause_menu.pause()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1
		
		
	paused = !paused

func alive():
	dead = false
	print("Dead is false")

func endMenu():
	dead = true
	end_menu.show()
	end_menu._ready()
	
	
	
