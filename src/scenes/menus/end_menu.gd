extends Control

@onready var main = $"../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/NewRun.grab_focus()

	


func _on_new_run_pressed() -> void:
	main.alive()
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/test_scene.tscn")
	Scores.current_score = 0
	pass # Replace with function body.


func _on_quit_to_main_menu_pressed() -> void:
	main.alive()
	Scores.current_score = 0
	get_tree().change_scene_to_file("res://src/scenes/menus/main_menu.tscn")
	


func _on_quit_pressed() -> void:
	get_tree().quit()
