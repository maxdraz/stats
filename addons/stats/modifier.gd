@tool
class_name Modifier
extends Resource


enum Type {ADD, MULTIPLY}


@export var value : float
@export var type : Type
var guid : String:
    set(value):
        guid = value


func _init(value: float = 0.0, type: Type = Type.ADD) -> void:
    self.value = value
    self.type = type
    if Engine.is_editor_hint() and (guid == "" or guid == null):
        generate_guid()


func generate_guid() -> void:
    guid = str(ResourceUID.create_id())
    print("Generated new GUID: ", guid)


func _get_property_list() -> Array[Dictionary]:
    var properties : Array[Dictionary] = []
    properties.append({
        "name":"guid",
        "type": TYPE_STRING,
        "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY
    })
    return properties