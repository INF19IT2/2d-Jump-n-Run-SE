extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var test = get_node("CanvasLayer/KinematicBody2D/Control")
	test.connect("dummy_slider_changed", self, "changed_dummy_size")

func changed_dummy_size(value):
	var dummy = get_node("KinematicBody2D")
	dummy.scale = Vector2(value, value)
