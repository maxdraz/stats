extends Node


@export var stats : Stats
@export var sword : Sword


func _ready() -> void:
	stats.init()
	print_stats()
	sword.equip(stats)
	print_stats()
	sword.unequip(stats)
	print_stats()


func print_stats() -> void:
	for stat_id in stats.base_stats:
		print(stat_id + ": " + str(stats.get_stat(stat_id)))
