extends Node

signal interface_set

var interface: DialogueInterface = null
var story: InkStory

# displays a string
func display_text(text: String):
	await await_interface()
	interface.display_text(text)

func start_npc_dialouge(npc: String):
	await await_interface()
	story.ChoosePathString("intro_%s" % [npc])
	
	if !story.GetCanContinue(): 
		interface.close_dialogue()
		return
	
	var npc_name =  npc.replace("_", " ").capitalize()
	interface.display_text(story.ContinueMaximally(), npc_name)
	display_choices(continue_npc_dialouge)

func continue_npc_dialouge():
	print("continue")
	await await_interface()
	
	if !story.GetCanContinue(): 
		interface.close_dialogue()
		return
	
	interface.display_next_text(story.ContinueMaximally())
	display_choices(continue_npc_dialouge)

func display_choices(callback: Callable):
	await await_interface()
	var choices = story.GetCurrentChoices()
	
	if choices.size() == 0: 
		interface.add_close_choice()
		return
	
	for choice in choices:
		interface.add_choice(choice).connect(callback)

# display the dialogue for when an npc returns an item
func yelp_item_text(item: String, npc: String):
	await await_interface()
	story.ChoosePathString("yelp_%s.%s" % [item, npc])
	
	var npc_name =  npc.replace("_", " ").capitalize()
	interface.display_text(story.ContinueMaximally(), npc_name)

func set_interface(value: DialogueInterface):
	interface = value
	if interface == null: return
	
	story = interface.story
	interface_set.emit()

func await_interface():
	if interface == null:
		await interface_set
