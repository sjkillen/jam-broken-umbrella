@tool
extends EditorScenePostImport


func _post_import(scene: Node) -> Object:
	var shelf: Node3D = scene.get_node("Shelf")
	var i := 0
	for child in shelf.get_children():
		shelf.remove_child(child)
		var new_child := preload("res://shop/item_slot.tscn").instantiate()
		new_child.name = "Slot " + str(i)
		i += 1
		new_child.transform = child.transform
		shelf.add_child(new_child)
		new_child.owner = scene
	return scene
