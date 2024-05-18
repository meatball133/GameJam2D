using Godot;
using System;

public partial class Larv : CharacterBody2D
{
    [Export(PropertyHint.Range, "1, 100, 1")] public float Speed = 10;
    [Export] public Path2D Path;
    [Export] public NavigationAgent2D NavigationAgent;
    [Export] public Area2D HurtBox;

    public int pointIndex = 1;
    public Vector2 destination;

    public override void _Ready()
    {
        destination = Path.Curve.GetPointPosition(pointIndex) + Path.GlobalPosition;
        NavigationAgent.TargetPosition = destination;
        NavigationAgent.NavigationFinished += HandleNavigationFinished;
    }

    private void HandleNavigationFinished()
    {
        pointIndex = Mathf.Wrap(pointIndex + 1, 0 , Path.Curve.PointCount);
        destination = Path.Curve.GetPointPosition(pointIndex) + Path.GlobalPosition;
        NavigationAgent.TargetPosition = destination;
    }


    public override void _PhysicsProcess(double delta)
    {
        NavigationAgent.GetNextPathPosition();
        Velocity = GlobalPosition.DirectionTo(destination) * Speed;
        MoveAndSlide();
    }
}
