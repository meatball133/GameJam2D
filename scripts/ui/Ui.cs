using Godot;
using System;

public partial class Ui : Control
{

    [Export] Button StartButton;
    [Export] Container startPanel;

    public override void _Ready()
    {
        GD.Print("Ui Ready");
        GetTree().Paused = true;
        StartButton.Pressed += HandleStartButtonPressed;
    }

    private void HandleStartButtonPressed()
    {
        GD.Print("Start Button Pressed");
        GetTree().Paused = false;
        startPanel.Visible = false;
        GetParent().QueueFree();
    }

}
