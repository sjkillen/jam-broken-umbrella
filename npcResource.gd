extends Resource
class_name NpcResource

@export var npc_name: String = ""
@export_multiline var npc_request_dialogue: String = ""
@export var content_with_item: bool = false

@export var npc_end_dialogue: Array = []
@export var npc_item_response: Array = []
@export var npc_yelp: Array = []

@export var art: Texture2D
