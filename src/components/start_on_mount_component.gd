extends Node
class_name StartOnMountComponent

@export var actor: BaseModule
@export var timers: Array[Timer]


func _ready() -> void:
	for timer in timers:
		actor.mounted.connect(func(module: BaseModule, parent: HeadModule):
			if timer.paused:
				timer.paused = false
			else:
				timer.start()
		)
		actor.unmounted.connect(func(module: BaseModule, parent: HeadModule):
			timer.paused = true
		)
