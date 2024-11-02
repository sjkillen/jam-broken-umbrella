extends Node3D

# Shelf is selected
var shelf_active := false
signal shelf_active_change(v: bool)

var item_active := false

# Whether the shelf is pointed to (but not selected
var shelf_point := false

# Item cursor is pointed to (only selected if item_active is true)
var pointed_item: ItemSlot = null


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		click_shelf()
		return

func click_shelf():
	if shelf_active:
		return
	shelf_active = true
	shelf_active_change.emit(true)

func _on_shelf_mouse_entered() -> void:
	shelf_point = true

func _on_shelf_mouse_exited() -> void:
	shelf_point = false

func point_item(slot: ItemSlot):
	if not item_active:
		pointed_item = slot

func unpoint_item(slot: ItemSlot):
	if not item_active and pointed_item == slot:
		pointed_item = null

func set_cursor():
	if not shelf_active and shelf_point:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		return
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _process(_delta: float) -> void:
	set_cursor()
