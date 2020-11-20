extends Popup

func _on_ResumeButton_pressed():
	# Resume
	get_tree().paused = false
	hide()
	
func _on_RestartButton_pressed():
	# Restart
	get_tree().change_scene("res://Scenes/First_Level/First_Level.tscn")
	get_tree().paused = false
	
func _on_OptionsButton_pressed():
	# Options
	pass
	
func _on_MainMenuButton_pressed():
	# Main Menu
	get_tree().change_scene("res://Scenes/MainScene/MainScene.tscn")

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("pause_button"):
			# Pause Game
			get_tree().paused = true
			# Show popup
			popup()
	elif visible:
		if Input.is_action_just_pressed("pause_button"):
			# Unpause Game
			get_tree().paused = false
			# hide popup
			hide()
