extends Camera3D

@onready var fsm: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _on_shelf_shelf_active_change(v: bool) -> void:
	if v:
		fsm.travel("LookShelf")
	else:
		fsm.travel("Counter")
