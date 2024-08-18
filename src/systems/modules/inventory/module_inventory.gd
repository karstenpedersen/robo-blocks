extends Node
class_name ModuleInventory

signal module_added(module)
signal module_removed(module)

const DEFAULT_SIZE: Vector2i = Vector2i(9, 9)
@export var size: Vector2i = DEFAULT_SIZE

var _free_slots: Array[Vector2i]
var _modules: Array[Dictionary]


func _ready() -> void:
	for x in size.x:
		for y in size.y:
			_free_slots.append(Vector2i(x, y))


func add_module(module: BaseModule, position: Vector2i) -> bool:
	if !module_fits(module, position):
		return false
	
	# Add module
	_modules.append({
		"module": module,
		"position": position
	})
	
	# Remove slots
	for x in module.stats.size.x:
		for y in module.stats.size.y:
			_free_slots.erase(Vector2i(
				x + position.x,
				y + position.y))
	
	module_added.emit(module)
	return true


func remove_module(module: BaseModule) -> bool:
	for module_slot in _modules:
		if module_slot["module"] == module:
			# Readd slots
			for x in module.stats.size.x:
				for y in module.stats.size.y:
					_free_slots.append(Vector2i(
						x + module_slot["position"].x,
						y + module_slot["position"].y))
			
			# Remove module
			_modules.erase(module_slot)
			module_removed.emit(module)
			return true
	return false


func get_modules() -> Array[Dictionary]:
	return _modules


func has_module(module: BaseModule) -> bool:
	for module_slot in _modules:
		if module_slot["module"] == module:
			return true
	return false

#
#func get_neighbours(module: BaseModule, position: Vector2i) -> bool:
	#for module_slot in _modules:
		#for x in module_slot["position"].x:
			#for y in module_slot["position"].x:
				#pass

func module_fits(module: BaseModule, position: Vector2i) -> bool:
	for x in module.stats.size.x:
		for y in module.stats.size.y:
			if !_free_slots.has(Vector2i(x + position.x, y + position.y)):
				return false
	return true
