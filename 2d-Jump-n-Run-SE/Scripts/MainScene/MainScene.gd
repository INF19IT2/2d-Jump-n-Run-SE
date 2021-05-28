extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_StartLevelButton_pressed():
	get_tree().change_scene("res://Scenes/LevelSelection/LevelSelection.tscn")


func _on_OptionsButton_pressed():
	get_node("Options").popup_centered()
