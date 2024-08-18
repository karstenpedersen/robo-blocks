extends Node3D
class_name BaseModule

signal destroyed

@export var stats: ModuleStats

var index: int = 0
var neighbours: Array[BaseModule]
var parent: BaseModule


func destroy():
	notify_neighbours()
	queue_free()
	destroyed.emit()


func remove_neighbour(caller: BaseModule):
	neighbours.erase(caller)
	
	var found_smaller_index = false
	for neighbour in neighbours:
		if neighbour.index < index:
			found_smaller_index = true
	if !found_smaller_index:
		destroy()


func notify_neighbours():
	for neighbour in neighbours:
		neighbour.remove_neighbour(self)
