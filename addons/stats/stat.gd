class_name Stat
extends Resource


@export var type: StatType
@export var value: StatValue


func get_id() -> String:
    return type.get_id()


func get_value() -> Variant:
    return value.get_value()