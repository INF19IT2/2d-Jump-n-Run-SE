extends CanvasLayer

onready var player_sprite_label = $Player_Sprite_Slider/Player_Sprite_Label
onready var dummy_label = $Dummy_Slider/Dummy_Label
onready var camera_label = $Camera_Slider/Camera_Label

signal player_sprite_slider_changed
signal dummy_slider_changed
signal camera_slider_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Player_Sprite_Slider_value_changed(value):
	player_sprite_label.set_text(str(value))
	emit_signal("player_sprite_slider_changed", value)


func _on_Dummy_Slider_value_changed(value):
	dummy_label.set_text(str(value))
	emit_signal("dummy_slider_changed", value)


func _on_Camera_Slider_value_changed(value):
	camera_label.set_text(str(value))
	emit_signal("camera_slider_changed", value)
