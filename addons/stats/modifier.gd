class_name Modifier
extends Resource


enum Type {ADD, MULTIPLY}


@export var value : float
@export var type : Type


func _init(value: float = 0.0, type: Type = Type.ADD) -> void:
    self.value = value
    self.type = type