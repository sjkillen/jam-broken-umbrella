extends Node

signal interface_set

var interface: DialogueInterface = null
var story: InkStory

# displays a string
func display_text(text: String):
	await await_interface()
	interface.display_text(text)

# display the dialogue for when an npc returns an item
func yelp_item_text(item: String, npc: String):
	await await_interface()
	story.ChoosePathString("yelp_%s.%s" % [item, npc])
	interface.display_text(story.ContinueMaximally())

func set_interface(value: DialogueInterface):
	interface = value
	if interface == null: return
	
	story = interface.story
	interface_set.emit()

func await_interface():
	if interface == null:
		await interface_set
