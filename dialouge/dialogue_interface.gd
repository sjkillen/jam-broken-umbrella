extends Panel
class_name DialogueInterface

const DIALOGUE_BUTTON_SCENE = preload("res://dialouge/dialogue_button.tscn")
const CHARS_PER_SECOND = 80

@export var story: InkStory

@onready var name_label: Label = $HBoxContatiner/NameLabel
@onready var text_label: RichTextLabel = $HBoxContatiner/RichTextLabel
@onready var buttons: GridContainer = $HBoxContatiner/GridContainer

var display_time: float = 0

func _ready():
	visible = false
	DialogueManager.set_interface(self)

func _process(delta):
	display_time += delta
	text_label.visible_characters = floori(display_time * CHARS_PER_SECOND)

func display_text(text: String, npc_name: String = ""):
	visible = true
	name_label.text = npc_name
	text_label.text = text
	display_time = 0

func display_next_text(text: String):
	visible = true
	text_label.text = text
	display_time = 0

func close_dialogue():
	text_label.text = ""
	visible = false 

func add_choice(choice: InkChoice):
	visible = true
	
	var button = DIALOGUE_BUTTON_SCENE.instantiate()
	button.text = choice.GetText()
	buttons.add_child(button)
	button.pressed.connect(make_choice.bind(choice.GetIndex()))
	
	return button.pressed

func add_close_choice():
	visible = true
	
	var button = DIALOGUE_BUTTON_SCENE.instantiate()
	button.text = "[Close Dialogue]"
	buttons.add_child(button)
	
	await button.pressed
	
	close_dialogue()
	button.queue_free()
	

func make_choice(index: int):
	print("choice")
	story.ChooseChoiceIndex(index)
	
	for button in buttons.get_children():
		button.queue_free()
