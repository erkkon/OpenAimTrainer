extends Node


func string_to_vector3d(string_vector: String) -> Vector3:
	var components_str = string_vector.substr(1, string_vector.length() - 2)
	var components = components_str.split(",")

	# Convert each component from string to float
	var x = components[0].to_float()
	var y = components[1].to_float()
	var z = components[2].to_float()

	# Create the Vector3D object
	return Vector3(x, y, z)

func string_to_color(string_vector: String) -> Color:

	var components_str = string_vector.substr(1, string_vector.length() - 2)
	var components = components_str.split(",")

	# Convert each component from string to float
	var r = components[0].to_float()
	var g = components[1].to_float()
	var b = components[2].to_float()
	var a = components[3].to_float()

	# Create the Vector3D object
	return Color(r, g, b, a)

#4k
var games_sensitivities: Dictionary = {
	"Valorant": 0.0707589285714285,
	"CounterStrike": 0.0222372497081799,
	"Fortnite": 0.00561534231977053
	}

var models3d: Dictionary = {
	"3D_HEAD_LEVEL_V1": {
		"spawn_location_x_0": 24,
		"spawn_location_x_1": -24,
		"spawn_location_y_0": 4,
		"spawn_location_y_1": 4,
		"movment": false,
		"size": 0.5,
		"number_of_initial_targets": 1
	},
	"3D_MULTIPLE_BASIC_TARGETS_MOVEMENT_V1": {
		"spawn_location_x_0": 12,
		"spawn_location_x_1": -12,
		"spawn_location_y_0": 4,
		"spawn_location_y_1": 20,
		"movment": true,
		"size": 0.5,
		"number_of_initial_targets": 6
	},
	"3D_MULTIPLE_BASIC_TARGETS_V1": {
		"spawn_location_x_0": 12,
		"spawn_location_x_1": -12,
		"spawn_location_y_0": 4,
		"spawn_location_y_1": 20,
		"movment": false,
		"size": 0.5,
		"number_of_initial_targets": 6
	},
	"3D_MULTIPLE_MEDIUM_TARGETS_V1": {
		"spawn_location_x_0": 11,
		"spawn_location_x_1": -11,
		"spawn_location_y_0": 4,
		"spawn_location_y_1": 15,
		"movment": false,
		"size": 3,
		"number_of_initial_targets": 3
	}
}


var game_type = ""
