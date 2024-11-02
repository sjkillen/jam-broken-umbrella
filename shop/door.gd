extends Node3D

@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

# Private
signal door_anim_opened_finished
signal door_anim_closed_finished


# Private
func on_closed_anim_finished():
	door_anim_closed_finished.emit()

# Private
func on_open_anim_finished():
	door_anim_opened_finished.emit()


# Public
func open_door():
	if playback.get_current_node() == "Opened":
		return
	playback.travel("Opening")
	await door_anim_opened_finished
	
# Public
func close_door():
	if playback.get_current_node() == "Closed":
		return
	playback.travel("Closing")
	await door_anim_closed_finished
	
