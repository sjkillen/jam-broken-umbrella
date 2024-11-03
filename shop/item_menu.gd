extends Control

signal item_taken(slot: ItemSlot)

var slot: ItemSlot = null

func _ready() -> void:
	clear_item()

func set_item(v: ItemSlot):
	slot = v
	var item := slot.item.data
	%Name.text = item.item_name
	%Description.text = item.item_initial_description	
	%Curse.text = "Curse: " + "Unknown"
	visible = true

func clear_item():
	visible = false
	slot = null

func _on_shelf_active_item_change(v: ItemSlot) -> void:
	if v and v.item:
		set_item(v)
	else:
		clear_item()


func _on_take_pressed() -> void:
	item_taken.emit(slot)	
