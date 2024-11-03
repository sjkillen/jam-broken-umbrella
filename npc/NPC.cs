using Godot;
using System;

public partial class NPC : Node
{
	[Export] Area3D collisionArea;
	[Export] string npc_name;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		collisionArea.InputEvent += OnInputEventSignal;
	}

    private void OnInputEventSignal(Node camera, InputEvent @event, Vector3 eventPosition, Vector3 normal, long shapeIdx)
    {
        // Check if the input event is a left mouse button click
		// And then start dialogue
        if (@event is InputEventMouseButton mouseEvent && mouseEvent.Pressed && mouseEvent.ButtonIndex == MouseButton.Left)
        {
            this.StartDialogue(npc_name);
        }
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
	}

	private void StartDialogue(string name)
	{
		GD.Print($"Starting dialogue for {name}");
		switch (name)
		{
			case "Assassin":
				break;
			case "Chef":
				break;
		}
			

	}
}
