using Godot;
using System;

public partial class Apple : StaticBody2D
{
    [Export] public Area2D Area;
    [Signal] public delegate void HealthDepletedEventHandler();

    public override void _Input(InputEvent @event)
    {
        if (Input.IsActionJustPressed("Interact") && Area.GetOverlappingBodies().Count > 0)
        {
            EmitSignal(SignalName.HealthDepleted);
            QueueFree();
        }
    }
}
