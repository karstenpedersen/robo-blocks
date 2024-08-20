extends BaseModule
class_name WeaponModule

@export var weapon_stats: WeaponModuleStats

@onready var barrel = $Barrel as Node3D
@onready var muzzle = $Barrel/Muzzle as Node3D

signal fired


func _on_timer_timeout() -> void:
	var projectile = weapon_stats.projectile.instantiate()
	projectile.global_transform = muzzle.global_transform
	owner.owner.add_sibling(projectile)
	fired.emit()
