extends Node

@export var scene_node: Node3D

@onready var pause_menu = $PauseMenu
@onready var end_menu = $EndMenu
var paused = false
var dead = false

func _ready() -> void:
	pause_menu.hide()
	end_menu.hide()
	
	Globals.player_died.connect(endMenu)
	
	if scene_node:
		Globals.scene_node = scene_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
	if Input.is_action_just_pressed("increase_points"):
		Scores.current_score += 100

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
	if Scores.current_score >= Scores.highscore:
		Scores.highscore = Scores.current_score
	end_menu.show()
	end_menu.get_focus()
