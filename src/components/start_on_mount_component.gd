extends Node
class_name StartOnMountComponent

@export var timers: Array[Timer]
@export var draggable_component: DraggableComponent
# TODO: Make this listen to events from BaseModule

func _ready() -> void:
	for timer in timers:
		draggable_component.mounted.connect(func ():
			if timer.paused:
				timer.paused = false
			else:
				timer.start()
		)
		draggable_component.unmounted.connect(func ():
			timer.paused = true
		)
