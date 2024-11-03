extends Node3D
class_name ItemSlot

@export var item: ItemBase = null

func _on_area_3d_mouse_entered() -> void:
	if is_stocked():
		get_parent().point_item(self)

func _on_area_3d_mouse_exited() -> void:
	get_parent().unpoint_item(self)

func is_stocked() -> bool:
	return item != null

func stock(with: ItemBase):
	if is_stocked():
		push_error("Slot already stocked!")
		return
	item = with
	add_child(with)

func unstock() -> ItemBase:
	if not is_stocked():
		push_error("Slot has no stock!")
		return
	var old_item := item
	remove_child(item)
	item = null
	return old_item
	
func _process(delta: float) -> void:
	rotate_y(delta * 0.5)
