# ItemDatabase.gd
extends Node
# Define a dictionary to store item data
var items = {
	"sword": {
		"real_description": "A sharp blade, forged for battle.",
		"initial_description": "An old sword.",
		"is_cursed": false,
		"available": true,
		"description_reveal": false
	},
	"mysterious_amulet": {
		"real_description": "An amulet that hums with unknown power.",
		"initial_description": "A strange amulet.",
		"is_cursed": true,
		"available": true,
		"description_reveal": false
	}
	# Add more items as needed
}

# Method to get item data by name
func get_item_data(item_name: String) -> Dictionary:
	return items.get(item_name, {})  # Returns empty dictionary if item not found
