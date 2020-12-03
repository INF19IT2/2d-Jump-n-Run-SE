extends Popup


var resolutions = [Vector2(),Vector2(1920,1080),Vector2(1280,720),Vector2(800,600)]
var resolutionDropdown
# Called when the node enters the scene tree for the first time.
func _ready():
	resolutionDropdown = get_node("OptionsBackground/GraphicOptions/ResolutionOptions")
	var currentResolution = OS.window_size
	resolutionDropdown.set_item_text(0,String(currentResolution[0]) + "x" + String(currentResolution[1]))
	resolutions[0] = Vector2(currentResolution[0],currentResolution[1])

func _on_ResolutionOptions_item_selected(index):
	var selectedResolution = resolutions[resolutionDropdown.get_selected_id()]
	changeWindowAndPopupSize(selectedResolution)


func _on_CheckButton_toggled(button_pressed):
	if(button_pressed):
		changeWindowAndPopupSize(OS.get_screen_size())
	else:
		changeWindowAndPopupSize(resolutions[0])


func _on_TextureButton_pressed():
	hide()


func changeWindowAndPopupSize(newWindowSize):
	get_viewport().size = newWindowSize
	OS.window_size = newWindowSize
	OS.center_window()
	popup_centered(newWindowSize)
