using Godot;
using System;

public partial class NPC : Node
{
	[Export] Area3D collisionArea;
	[Export] Node npc_node;
	Node dialogueManager;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		collisionArea.InputEvent += OnInputEventSignal;

		dialogueManager = GetNode("/root/DialogueManager");
	}

    private void OnInputEventSignal(Node camera, InputEvent @event, Vector3 eventPosition, Vector3 normal, long shapeIdx)
    {
        // Check if the input event is a left mouse button click
		// And then start dialogue
        if (@event is InputEventMouseButton mouseEvent && mouseEvent.Pressed && mouseEvent.ButtonIndex == MouseButton.Left)
        {
            this.StartDialogue(GetNPCName());
        }
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
	}

	private string GetNPCName()
	{
		Resource npcResource = npc_node.Get("current_character").As<Resource>();
		return (string)npcResource.Get("npc_name");
	}

	private void StartDialogue(string name)
	{
		GD.Print($"Starting dialogue for {name}");
		string alt_name = "";
		switch (name)
		{
			case "Sad Child":
				alt_name = "sad_child";
				break;
			case "Cultist":
				alt_name = "cultist";
				break;
			case "Dinosaur Fan":
				alt_name = "dinosaur_fan";
				break;
			case "Lawyer":
				alt_name = "lawyer";
				break;
			case "Assassin":
				alt_name = "assassin";
				break;
		}

		if (alt_name != "")
			dialogueManager.Call("start_npc_dialouge", alt_name);
		else
			GD.PrintErr($"Invalid NPC name: {name}");
	}
}
