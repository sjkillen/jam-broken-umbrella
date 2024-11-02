extends Panel
class_name DialogueInterface

const CHARS_PER_SECOND = 80

@export var story: InkStory

@onready var text_label: RichTextLabel = $HBoxContatiner/RichTextLabel

var display_time: float = 0

func _ready():
	DialogueManager.set_interface(self)

func _process(delta):
	display_time += delta
	text_label.visible_characters = floori(display_time * CHARS_PER_SECOND)
	visible = text_label.text.length() > 0

func display_text(text: String):
	text_label.text = text
	display_time = 0
