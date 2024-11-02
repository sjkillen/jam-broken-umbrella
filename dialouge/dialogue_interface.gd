extends Panel

const CHARS_PER_SECOND = 80

@onready var text_label: RichTextLabel = $HBoxContatiner/RichTextLabel

var display_time: float = 0

func _ready():
	display_text("Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti consectetur ligula enim malesuada turpis maximus ipsum. Libero ad semper dignissim tincidunt pretium urna elit orci. In mollis donec, vel inceptos donec volutpat ultricies efficitur. Felis tincidunt taciti lectus hac accumsan. Fusce leo curae sociosqu parturient faucibus donec torquent convallis placerat. Tortor ridiculus potenti eget ullamcorper per vel lacus posuere natoque. Curabitur curae conubia suspendisse ligula fusce dictum.");

func _process(delta):
	display_time += delta
	text_label.visible_characters = floori(display_time * CHARS_PER_SECOND)

func display_text(text: String):
	text_label.text = text
	display_time = 0
