extends Node3D
class_name ItemSlot

func _on_area_3d_mouse_entered() -> void:
	get_parent().point_item(self)

func _on_area_3d_mouse_exited() -> void:
	get_parent().unpoint_item(self)
