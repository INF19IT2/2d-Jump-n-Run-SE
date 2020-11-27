extends Node


var resolutions = [Vector2(),Vector2(1920,1080),Vector2(1280,720),Vector2(800,600)]
var resolutionDropdown
# Called when the node enters the scene tree for the first time.
func _ready():
	resolutionDropdown = get_node("GraphicOptions/ResolutionOptions")
	var currentResolution = OS.window_size
	resolutionDropdown.set_item_text(0,String(currentResolution[0]) + "x" + String(currentResolution[1]))
	resolutions[0] = Vector2(currentResolution[0],currentResolution[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResolutionOptions_item_selected(index):
	var selectedResolution = resolutions[resolutionDropdown.get_selected_id()]
	OS.window_size = selectedResolution


func _on_CheckButton_toggled(button_pressed):
	if(button_pressed):
		OS.window_size = OS.get_screen_size()
	else:
		OS.window_size = resolutions[0]
	OS.window_borderless = button_pressed
