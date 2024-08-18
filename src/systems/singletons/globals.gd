extends Node

var camera: Camera3D
#var is_paused = false
#var pause_list = []

#signal paused
#signal unpaused


#func pause(caller):
	#var index = pause_list.find(caller)
	#if index == -1:
		#is_paused = true
		#get_tree().paused = true
		#paused.emit()
		#pause_list.append(caller)
#
#
#func unpause(caller):
	#var index = pause_list.find(caller)
	#if index != -1:
		#pause_list.remove_at(index)
		#if pause_list.size() == 0:
			#is_paused = false
			#get_tree().paused = false
			#unpaused.emit()
