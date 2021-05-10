extends TextureRect

var level_folder = "res://Scenes/Levels/"

func _ready():
	pass # Replace with function body.




func _on_ExitButton_pressed():
	get_tree().change_scene("res://Scenes/MainScene/MainScene.tscn")


func _on_Level1Button_pressed():
	get_tree().change_scene(level_folder +  "First_Level/First_Level.tscn")


func _on_Level2Button_pressed():
	get_tree().change_scene(level_folder + "Second_Level/Second_Level.tscn")


func _on_Level3Button_pressed():
	get_tree().change_scene(level_folder + "32x32_Level/32x32_Level.tscn")
