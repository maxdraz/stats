class_name Stats
extends Node


@export var config : Array[Stat]

var base_stats : Dictionary[String, Stat] = {}
# Format: {"StatName", [Modifier, Modifier...]}
var modifiers : Dictionary = {}
# Format: {"StatName", value]}
var modified_stat_cache : Dictionary = {}
var is_initialized : bool

signal stat_changed(stat_id: String, value: Variant)


func _ready():
	if !is_initialized:
		init()	


func init() -> void:
	for stat in config:
		base_stats[stat.get_id()] = stat
	is_initialized = true

func get_stat(stat_id : String) -> Variant:
	if modified_stat_cache.has(stat_id):
		return modified_stat_cache[stat_id]	

	var base = base_stats.get(stat_id, null)
	if !base: return null

	var modified_value = apply_modifiers(stat_id, base.get_value())	
	modified_stat_cache[stat_id] = modified_value
	stat_changed.emit(stat_id, modified_value)
	return modified_value


func apply_modifiers(stat_id: String, base_value: Variant) -> Variant:
	var mods := modifiers.get_or_add(stat_id, []) as Array
	if mods.size() <= 0:
		return base_value
	
	var total_add := 0.0
	var total_mult := 0.0

	for mod in mods:
		match mod.type:
			Modifier.Type.ADD:
				total_add += mod.value
			Modifier.Type.MULTIPLY:
				total_mult += mod.value

	return (base_value + total_add) * (1 + total_mult)


func add_modifier(stat_id: String, modifier: Modifier) -> void:
	var base = base_stats.get(stat_id, null)
	if !base: return
	var mods := modifiers.get_or_add(stat_id, []) as Array
	for mod in mods:
		if mod.guid == modifier.guid:
			return
	modifiers[stat_id].append(modifier)
	var modified_value = apply_modifiers(stat_id, base.get_value())	
	modified_stat_cache[stat_id] = modified_value
	stat_changed.emit(stat_id, modified_value)


func remove_modifier(stat_id: String, modifier: Modifier) -> void:
	var base = base_stats.get(stat_id, null)
	if !base: return
	var mods := modifiers.get(stat_id, []) as Array
	for i in range(mods.size() - 1, -1, -1):
		if mods[i] == modifier:
			modifiers[stat_id].remove_at(i)
	var modified_value = apply_modifiers(stat_id, base.get_value())	
	modified_stat_cache[stat_id] = modified_value
	stat_changed.emit(stat_id, modified_value)
