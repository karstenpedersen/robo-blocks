extends Control

@onready var main = $"../"


func get_focus():
	$CenterContainer/VBoxContainer/NewRun.grab_focus()


func _on_new_run_pressed() -> void:
	main.alive()
	get_tree().change_scene_to_file("res://game_scene.tscn")
	Scores.current_score = 0
	pass # Replace with functi"res://src/scenes/game-scenes/game_scene.tscn"on body.


func _on_quit_to_main_menu_pressed() -> void:
	main.alive()
	Scores.current_score = 0
	get_tree().change_scene_to_file("res://src/scenes/menus/main_menu.tscn")
	

func _on_quit_pressed() -> void:
	get_tree().quit()
