extends Control

signal pause_game
signal resume_game
const FULLSCREEN_MODE = 3




func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		trigger_pause(true)

func trigger_pause(new_pause_state):
	get_tree().paused = new_pause_state
	visible = new_pause_state
	if new_pause_state:
		$Buttons/Resume.grab_focus()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		emit_signal("pause_game")
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		emit_signal("resume_game")

func _on_resume_pressed():
	trigger_pause(false)

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/MainScreen.tscn")

func _on_player_pause_game():
	trigger_pause(true)


