extends Node

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	# Play the move animation when the NPC is ready
	animation_player.play("WalkInside")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):  # Replace with your specific action
		animation_player.play("NpcEnter")
		
func _process(delta: float) -> void:
	# Additional logic can be added here if needed
	pass
