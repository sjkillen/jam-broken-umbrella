extends Panel

const CHARS_PER_SECOND = 80

@onready var text_label: RichTextLabel = $HBoxContatiner/RichTextLabel

var display_time: float = 0

func _process(delta):
	display_time += delta
	text_label.visible_characters = floori(display_time * CHARS_PER_SECOND)
	visible = text_label.text.length() > 0

func display_text(text: String):
	text_label.text = text
	display_time = 0
