extends Control

@onready var main = $"../"

func pause() -> void:
	$CenterContainer/VBoxContainer/Resume.grab_focus()

func _on_resume_pressed():
	main.pauseMenu()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_restart_run_pressed() -> void:
	pass # Replace with function body.

func _on_quit_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://src/scenes/menus/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
