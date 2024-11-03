extends Node

@onready var animation_player = $AnimationPlayer

var current_character: NpcResource

var all_resources = [
	preload("res://resources/npcs/child.tres"),
	preload("res://resources/npcs/cultist.tres"),
	preload("res://resources/npcs/dinosaur.tres"),
	preload("res://resources/npcs/lawyer.tres"),
	preload("res://resources/npcs/assassin.tres"),
]

func _ready() -> void:
	# Play the move animation when the NPC is ready
	animation_player.play("WalkInside")
	var i := randi_range(0, all_resources.size()-1)
	set_character(all_resources[i])
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):  # Replace with your specific action
		animation_player.play("NpcEnter")
		
func _process(delta: float) -> void:
	# Additional logic can be added here if needed
	pass

func set_character(who: NpcResource):
	var mat: StandardMaterial3D = $NPC/MeshInstance3D.get_active_material(0)
	mat.albedo_texture = who.art
	current_character = who
