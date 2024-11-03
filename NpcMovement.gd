extends Node

@onready var animation_player = $AnimationPlayer

@export var current_character: NpcResource

var all_resources = [
	preload("res://resources/npcs/child.tres"),
	preload("res://resources/npcs/cultist.tres"),
	preload("res://resources/npcs/dinosaur.tres"),
	preload("res://resources/npcs/lawyer.tres"),
	preload("res://resources/npcs/assassin.tres"),
]

func _ready() -> void:
	all_resources.shuffle()
	next_npc()

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#leave()

func next_npc():
	if all_resources.size() == 0:
		%YelpReviews.display_reviews()
		return
	set_character(all_resources.pop_back())
	animation_player.play("WalkInside")

func leave():
	animation_player.play("WalkOutside")
	
func set_character(who: NpcResource):
	var mat: StandardMaterial3D = $NPC/MeshInstance3D.get_active_material(0)
	mat.albedo_texture = who.art
	mat.emission_texture = who.art
	current_character = who
