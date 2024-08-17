extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Startbutton.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
	
func _on_startbutton_pressed():
	get_tree().change_scene_to_file("res://src/scenes/game-scenes/test_scene.tscn")

func _on_quitbutton_pressed() -> void:
	get_tree().quit()
