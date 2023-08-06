using Godot;
using System;
using System.Collections.Generic;

public partial class MainScreen : Control
{
	Dictionary<string, double> gamesSensitivities = new(){
		{"valorant", 0.0707589285714285},
		{"counterStrike", 0.0222372497081799},
		{"fortnite", 0.00561534231977053}
	};

	public class ModelData
	{
		public int spawn_location_x_0;
		public int spawn_location_x_1;
		public int spawn_location_y_0;
		public int spawn_location_y_1;
		public bool movment;
		public double size;
		public int number_of_initial_targets;
	}

	public Dictionary<string, ModelData> models3d = new Dictionary<string, ModelData>()
	{
		{ "3d_head_level_v1", new ModelData
			{
				spawn_location_x_0 = 24,
				spawn_location_x_1 = -24,
				spawn_location_y_0 = 4,
				spawn_location_y_1 = 4,
				movment = false,
				size = 0.5,
				number_of_initial_targets = 1
			}
		},
		{ "3d_multiple_basic_targets_movement_v1", new ModelData
			{
				spawn_location_x_0 = 12,
				spawn_location_x_1 = -12,
				spawn_location_y_0 = 4,
				spawn_location_y_1 = 20,
				movment = true,
				size = 0.5,
				number_of_initial_targets = 6
			}
		},
		{ "3d_multiple_basic_targets_v1", new ModelData
			{
				spawn_location_x_0 = 12,
				spawn_location_x_1 = -12,
				spawn_location_y_0 = 4,
				spawn_location_y_1 = 20,
				movment = false,
				size = 0.5,
				number_of_initial_targets = 6
			}
		},
		{ "3d_multiple_medium_targets_v1", new ModelData
			{
				spawn_location_x_0 = 11,
				spawn_location_x_1 = -11,
				spawn_location_y_0 = 4,
				spawn_location_y_1 = 15,
				movment = false,
				size = 3,
				number_of_initial_targets = 3
			}
		}
	};

// Called when the node enters the scene tree for the first time.
public override void _Ready()
	{
		if (OS.HasFeature("web")) {
			
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
