extends Node3D

func _ready() -> void:
	stock_items()

func stock_items():
	var count := %Shelf.get_child_count()
	var indices := []
	for i in range(count):
		indices.append(i)
	indices.shuffle()
	
	for i in indices:
		if not %AllItems.items_left():
			return
		var slot: ItemSlot = %Shelf.get_child(i)
		if slot.is_stocked():
			continue
		slot.stock(%AllItems.pop_item())
		
