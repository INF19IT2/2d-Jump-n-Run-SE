extends Popup


var resolutions = [Vector2(),Vector2(1920,1080),Vector2(1280,720),Vector2(800,600)]
var resolutionDropdown
# Called when the node enters the scene tree for the first time.
func _ready():
	resolutionDropdown = get_node("OptionsBackground/Container/Resolution/ResolutionDropdown")
	var currentResolution = OS.window_size
	resolutionDropdown.set_item_text(0,String(currentResolution[0]) + "x" + String(currentResolution[1]))
	resolutions[0] = Vector2(currentResolution[0],currentResolution[1])
	get_node("OptionsBackground/Container/Fullscreen/FullscreenCheckBox").pressed = OS.window_fullscreen
	hide()

func _on_ResolutionDropdown_item_selected(index):
	if(OS.window_fullscreen):
		OS.window_fullscreen = false
		get_node("OptionsBackground/Container/Fullscreen/FullscreenCheckBox").pressed = false
	var selectedResolution = resolutions[resolutionDropdown.get_selected_id()]
	changeWindowAndPopupSize(selectedResolution)


func _on_FullscreenCheckBox_toggled(button_pressed):
	var resOptions = get_node("OptionsBackground/Container/Resolution/ResolutionDropdown")
	OS.window_fullscreen = button_pressed
	if(button_pressed):
		changeWindowAndPopupSize(OS.get_screen_size())
	else:
		changeWindowAndPopupSize(resolutions[resOptions.selected])
	resOptions.disabled = button_pressed


func _on_TextureButton_pressed():
	hide()


func changeWindowAndPopupSize(newWindowSize):
	get_viewport().size = newWindowSize
	OS.window_size = newWindowSize
	OS.center_window()
	hide()
	popup_centered_ratio()


func _on_FullscreenLabel_focus_entered():
	hide()


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100 + value)
