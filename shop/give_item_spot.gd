extends Marker3D

var item: ItemBase = null

func set_item(v: ItemBase):
	if item:
		push_error("Already an item!")
		return
	item = v
	add_child(v)

func clear_item() -> ItemBase:
	var old_item := item
	item = null
	remove_child(old_item)
	return old_item
	
	
func _on_shelf_item_taken(item: ItemBase) -> void:
	set_item(item)

func _process(delta: float) -> void:
	rotate_y(delta * 0.5)
