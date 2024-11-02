extends Node3D

# Shelf is selected
var shelf_active := false
signal shelf_active_change(v: bool)

var active_item: ItemSlot = null
signal active_item_change(v: ItemSlot)


# Whether the shelf is pointed to (but not selected
var shelf_point := false

# Item cursor is pointed to (not selected)
var pointed_item: ItemSlot = null


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		click_item_slot()
		click_shelf()
		return
	if event.is_action_pressed("ui_cancel"):
		unclick_shelf()
		unclick_item_slot()

func click_shelf():
	if shelf_active or not shelf_point:
		return
	shelf_active = true
	shelf_active_change.emit(true)

func unclick_shelf():
	if not shelf_active or active_item:
		return
	shelf_active = false
	shelf_active_change.emit(false)

func click_item_slot():
	if not shelf_active or active_item or not pointed_item:
		return
	active_item = pointed_item
	active_item_change.emit(active_item)

func unclick_item_slot():
	if not active_item:
		return
	active_item = null
	active_item_change.emit(null)

func _on_shelf_mouse_entered() -> void:
	shelf_point = true

func _on_shelf_mouse_exited() -> void:
	shelf_point = false

func point_item(slot: ItemSlot):
	pointed_item = slot

func unpoint_item(slot: ItemSlot):
	if pointed_item == slot:
		pointed_item = null

func set_cursor():
	if not shelf_active and shelf_point:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		return
	if not active_item and pointed_item:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		return
		
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _process(_delta: float) -> void:
	set_cursor()
