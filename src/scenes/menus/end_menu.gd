extends Control

@onready var main = $"../"


func get_focus():
	$CenterContainer/VBoxContainer/NewRun.grab_focus()


func _on_new_run_pressed() -> void:
	main.alive()
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/test_scene.tscn")
	pass # Replace with function body.


func _on_quit_to_main_menu_pressed() -> void:
	main.alive()
	get_tree().change_scene_to_file("res://src/scenes/menus/main_menu.tscn")
	


func _on_quit_pressed() -> void:
	get_tree().quit()
