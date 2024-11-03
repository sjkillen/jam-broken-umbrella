using Godot;
using System;
using System.Collections.Generic;

public partial class NPC : Node
{
	[Export] Area3D collisionArea;
	[Export] Node npc_node;
	[Export] Node shelf_node;
	[Export] Node dialogueInterface;
	Node dialogueManager;

	string lastNPC = "";
	bool interactedWithSameNPCBefore = false;

	Dictionary<string, string> NPCAltNames = new Dictionary<string, string> 
	{
		{"Sad Child", "sad_child"},
		{"Cultist", "cultist"},
		{"Dinosaur Fan", "dinosaur_fan"},
		{"Lawyer", "lawyer"},
		{"Assassin", "assassin"}
	};

	
	[Signal]
	public delegate void NPCClickedEventHandler(string npc_name);

	[Signal]
	public delegate void NPCGivenItemEventHandler(string npc_name);

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		collisionArea.InputEvent += OnInputEventSignal;
		dialogueManager = GetNode("/root/DialogueManager");
		dialogueManager.Connect("dialogue_ended", new Callable(this, nameof(OnDialogueEnded)));
	}

	/// <summary>
	/// Called when the NPC is clicked.
	/// </summary>
	private void OnInputEventSignal(Node camera, InputEvent @event, Vector3 eventPosition, Vector3 normal, long shapeIdx)
	{
		// Check if the input event is a left mouse button click
		// And then start dialogue
        if (@event is InputEventMouseButton mouseEvent && mouseEvent.Pressed && mouseEvent.ButtonIndex == MouseButton.Left)
        {
			if (lastNPC != GetNPCName())
			{
				interactedWithSameNPCBefore = false;
			}

			lastNPC = GetNPCName();
			if (!interactedWithSameNPCBefore)
			{
				this.StartIntroDialogue(GetNPCName());
			}
			else
			{
				dialogueManager.Call("display_text", $"Thanks for the {GetSelectedItemName()}!");
				EmitSignal(SignalName.NPCGivenItem);
			}
				
        }

		EmitSignal(SignalName.NPCClicked);
    }

	/// <summary>
	/// Gets the name of the current NPC from its NpcResource.
	/// </summary>
	/// <returns>A string containing the name of the current NPC.</returns>
	private string GetNPCName()
	{
		Resource npcResource = npc_node.Get("current_character").As<Resource>();
		return (string)npcResource.Get("npc_name");
	}

	/// <summary>
	/// Getts the name of the current item selected.
	/// </summary>
	/// <returns>A string containing the name of the current item selected.</returns>
	private string GetSelectedItemName()
	{
		try
		{
			Node itemSpot = GetNode<Node>("%GiveItemSpot");
			Node itemBase = itemSpot.Get("item").As<Node>();
			Resource itemData = itemBase.Get("data").As<Resource>();
			return (string)itemData.Get("item_name");
		}
		catch
		{
			return "";
		}
	}

	/// <summary>
	/// Tells the DialogueManager to start the intro dialogue for a given NPC.
	/// </summary>
	/// <param name="name">The name of the NPC (as definied in the NpcResource).</param>
	private void StartIntroDialogue(string name)
	{
		GD.Print($"Starting dialogue for {name}");
		string alt_name = NPCAltNames[name];

		alt_name = "assassin"; // TEMP FOR DEBUG

		if (alt_name != "")
			dialogueManager.Call("start_npc_dialouge", alt_name);
		else
			GD.PrintErr($"Invalid NPC name: {name}");
		
		
	}

	private void OnDialogueEnded()
	{
		GD.Print("ENDED");

		interactedWithSameNPCBefore = true;
	}





	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
