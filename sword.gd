class_name Sword
extends Node

@export var modifiers : Array[ItemModifierData]


func equip(stats: Stats) -> void:
	for mod_data in modifiers:
		for mod in mod_data.modifiers:
			stats.add_modifier(mod_data.type.get_id(), mod)


func unequip(stats: Stats) -> void:
	for mod_data in modifiers:
		for mod in mod_data.modifiers:
			stats.remove_modifier(mod_data.type.get_id(), mod)
