using Godot;
using System;

public partial class Larv : CharacterBody2D
{
    [Export(PropertyHint.Range, "1, 100, 1")] public float Speed = 10;
    [Export] public Path2D Path;
    [Export] public Sprite2D Sprite;
    [Export] public NavigationAgent2D NavigationAgent;
    [Export] public Area2D HurtBox;
    [Export] public AnimationPlayer AnimationPlayer;

    public int pointIndex = 1;
    public Vector2 destination;

    public override void _Ready()
    {
        destination = Path.Curve.GetPointPosition(pointIndex) + Path.GlobalPosition;
        NavigationAgent.TargetPosition = destination;
        NavigationAgent.NavigationFinished += HandleNavigationFinished;
        HurtBox.AreaEntered  += HandleHurtBoxOverlap;
        AnimationPlayer.AnimationFinished += HandleAnimationFinished;
    }

    private void HandleAnimationFinished(StringName animName)
    {
        if (animName == "Death")
        {
            QueueFree();
        }
    }


    private void HandleHurtBoxOverlap(Area2D area)
    {
        GD.Print("Larv hit by " + area.Name);
        SetPhysicsProcess(false);
        
        AnimationPlayer.Play("Death");
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
        Flip();
        Velocity = GlobalPosition.DirectionTo(destination) * Speed;
        MoveAndSlide();
    }

    public void Flip()
    {
        if (Velocity.X == 0) { return; }
        
        bool isMovingLeft = Velocity.X < 0;
        Sprite.FlipH = isMovingLeft;
    }
}
