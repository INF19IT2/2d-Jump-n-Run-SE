extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level_folder = "res://Scenes/Levels/"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_StartLevelButton_pressed():
	get_tree().change_scene(level_folder+"First_Level/First_Level.tscn")
	pass # Replace with function body.



func _on_OptionsButton_pressed():
	get_node("Options").popup_centered(OS.window_size)
