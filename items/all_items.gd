extends Node3D

func items_left():
	return get_child_count()

func pop_item() -> ItemBase:
	if items_left() == 0:
		return null
	var i := randi_range(0, items_left()-1)
	var child: ItemBase = get_children()[i]
	remove_child(child)
	return child

func return_item(item: ItemBase):
	add_child(item)
	
