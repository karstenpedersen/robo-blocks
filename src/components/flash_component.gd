extends Timer
class_name FlashComponent

@export var node: Node3D
@export var number_of_times: int = 10

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if number_of_times % 2 == 1:
		number_of_times += 1
	timeout.connect(func():
		if node.visible:
			node.hide()
		else:
			node.show()
		
		count += 1
		if count == number_of_times:
			count = 0
			stop()
	)
