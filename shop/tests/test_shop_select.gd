extends Node3D

func _on_shelf_shelf_active_change(v: bool) -> void:
	print("Change shelf active: ", v)


func _on_shelf_active_item_change(v: ItemSlot) -> void:
	if v:
		print("Change active item: ", v.name)
	else:
		print("Active item cleared")
