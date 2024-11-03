extends Panel
class_name DialogueInterface

const CHARS_PER_SECOND = 80

@export var story: InkStory

@onready var name_label: RichTextLabel = $HBoxContatiner/NameLabel
@onready var text_label: RichTextLabel = $HBoxContatiner/RichTextLabe

var display_time: float = 0

func _ready():
	DialogueManager.set_interface(self)

func _process(delta):
	display_time += delta
	text_label.visible_characters = floori(display_time * CHARS_PER_SECOND)
	visible = text_label.text.length() > 0

func display_text(text: String, name: String = ""):
	name_label.text = name
	text_label.text = text
	display_time = 0
