extends Node

#Item Characterists
var item_name: String = ""
var item_real_description: String = ""
var item_initial_description: String = ""
var item_is_cursed: bool = false
var item_available: bool = true
var item_description_reveal: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Use the node's name as the item_name
	load_item_data(self.name)


# Method to load item data from the database
func load_item_data(item_name: String) -> void:
	var item_data = ItemDatabase.get_item_data(item_name)  # Access the global ItemDatabase
	if item_data:
		item_real_description = item_data.get("real_description", "")
		item_initial_description = item_data.get("initial_description", "")
		item_is_cursed = item_data.get("is_cursed", false)
		item_available = item_data.get("available", true)
