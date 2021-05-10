extends CanvasLayer

onready var player_sprite_label = $Player_Sprite_Slider/Player_Sprite_Label
onready var dummy_label = $Dummy_Slider/Dummy_Label
onready var camera_label = $Camera_Slider/Camera_Label
onready var speed_label = $Speed_Slider/Speed_Label
onready var jump_label = $Jump_Slider/Jump_Label

signal player_sprite_slider_changed
signal dummy_slider_changed
signal camera_slider_changed
signal speed_slider_changed
signal jump_slider_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Player_Sprite_Slider_value_changed(value):
	player_sprite_label.set_text("Player size: " + str(value))
	emit_signal("player_sprite_slider_changed", value)


func _on_Dummy_Slider_value_changed(value):
	dummy_label.set_text("Dummy size: " + str(value))
	emit_signal("dummy_slider_changed", value)


func _on_Camera_Slider_value_changed(value):
	camera_label.set_text("Camera zoom: " + str(value))
	emit_signal("camera_slider_changed", value)
	


func _on_Speed_Slider_value_changed(value):
	speed_label.set_text("Player speed: " + str(value))
	emit_signal("speed_slider_changed", value)


func _on_Jump_Slider_value_changed(value):
	jump_label.set_text("Player jump: " + str(value))
	emit_signal("jump_slider_changed", value)