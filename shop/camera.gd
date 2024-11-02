extends Camera3D

@onready var fsm: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

var manual_anim: Tween = null
var start_transform: Transform3D
var end_transform: Transform3D

@export var zoom_in_offset: Vector3

func manual_anim_interpolate(w: float):
	global_transform = start_transform.interpolate_with(end_transform, w)

func _on_shelf_shelf_active_change(v: bool) -> void:
	if manual_anim:
		await manual_anim.finished
	$AnimationTree.active = true
	if v:
		fsm.travel("LookShelf")
	else:
		fsm.travel("Counter")


func _on_shelf_active_item_change(v: ItemSlot) -> void:
	if not v:
		if manual_anim:
			manual_anim.kill()
		manual_anim = create_tween()
		end_transform = start_transform
		start_transform = global_transform
		manual_anim.set_trans(Tween.TRANS_CUBIC).tween_method(manual_anim_interpolate, 0.0, 1.0, .5)
		await manual_anim.finished
		manual_anim = null
		$AnimationTree.active = true
		fsm.start("LookShelf")
		return
	$AnimationTree.active = false
	if manual_anim:
		manual_anim.kill()
	manual_anim = create_tween()
	start_transform = global_transform
	end_transform = v.global_transform
	end_transform.origin += zoom_in_offset
	end_transform = end_transform.looking_at(v.global_transform.origin)
	manual_anim.set_trans(Tween.TRANS_CUBIC).tween_method(manual_anim_interpolate, 0.0, 1.0, .5)
	await manual_anim.finished
	manual_anim = null
	
