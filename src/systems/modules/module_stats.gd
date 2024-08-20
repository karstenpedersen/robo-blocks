extends Resource
class_name ModuleStats

@export_category("Stats")
@export var health: int
@export var size: Vector2i = Vector2i(1, 1)

@export_category("Parent Stats")
@export var parent_stats: EntityStat
