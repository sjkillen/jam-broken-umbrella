extends Node3D

@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

signal door_anim_opened_finished
signal door_anim_closed_finished

func on_closed_anim_finished():
	door_anim_opened_finished.emit()

func on_open_anim_finished():
	door_anim_closed_finished.emit()

func open_door():
	if playback.get_current_node() == "Opened":
		return
	playback.travel("Opening")
	await door_anim_opened_finished
	
func close_door():
	if playback.get_current_node() == "Closed":
		return
	playback.travel("Closing")
	await door_anim_closed_finished
	
