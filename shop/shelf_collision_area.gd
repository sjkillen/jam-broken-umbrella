extends Area3D


func _on_shelf_shelf_active_change(v: bool) -> void:
	# Disable collision so contained areas can detect mouse
	visible = not v
