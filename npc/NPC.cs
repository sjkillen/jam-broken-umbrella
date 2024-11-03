using Godot;
using System;
using System.Collections.Generic;

public partial class NPC : Node
{
	[Export] Area3D collisionArea;
	[Export] Node npc_node;
	[Export] Node shelf_node;
	Node dialogueManager;

	Dictionary<string, string> NPCAltNames = new Dictionary<string, string> 
	{
		{"Sad Child", "sad_child"},
		{"Cultist", "cultist"},
		{"Dinosaur Fan", "dinosaur_fan"},
		{"Lawyer", "lawyer"},
		{"Assassin", "assassin"}
	};

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		collisionArea.InputEvent += OnInputEventSignal;
		dialogueManager = GetNode("/root/DialogueManager");
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
            this.StartIntroDialogue(GetNPCName());
        }
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
		Node ItemSlot = shelf_node.Get("active_item").As<Node>();
		Node ItemBase = ItemSlot.Get("item").As<Node>();
		// Resource ItemData = ItemBase.Get("data").As<Resource>();
		// return (string)ItemData.Get("item_name");
		return "";
	}

	/// <summary>
	/// Tells the DialogueManager to start the intro dialogue for a given NPC.
	/// </summary>
	/// <param name="name">The name of the NPC (as definied in the NpcResource).</param>
	private void StartIntroDialogue(string name)
	{
		GD.Print($"Starting dialogue for {name}");
		string alt_name = NPCAltNames[name];

		if (alt_name != "")
			dialogueManager.Call("start_npc_dialouge", alt_name);
		else
			GD.PrintErr($"Invalid NPC name: {name}");
		
		GD.Print(GetSelectedItemName());
	}





	// Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
	}
}
