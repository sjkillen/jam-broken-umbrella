extends Node3D

var reviews = []

func add_review(item: ItemResource, npc: NpcResource):
	reviews.append([item, npc])

func display_reviews():
	$Control.visible = true
	display_next_review()
	
func display_next_review():
	if reviews.size() == 0:
		$Control.visible = false
		get_tree().quit()
		return
	var review = reviews.pop_back()
	DialogueManager.yelp_item_text(review[0].item_yelp_name, review[1].npc_yelp_field)


func _on_button_pressed() -> void:
	display_next_review()
