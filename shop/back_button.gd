extends Button

func _ready() -> void:
	visible = false

func _on_shelf_shelf_active_change(v: bool) -> void:
	visible = v
