extends Node2D

signal projectile_speed_slider_changed
signal projectile_size_slider_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	var slider = get_node("CanvasLayer/Virus/Control")
	slider.connect("dummy_slider_changed", self, "changed_dummy_size")
	slider.connect("projectile_speed_slider_changed", self, "changed_projectile_speed")
	slider.connect("projectile_size_slider_changed", self, "changed_projectile_size")

func changed_dummy_size(value):
	var dummy = get_node("KinematicBody2D")
	dummy.scale = Vector2(value, value)
	var scientist = get_node("scientist")
	scientist.scale = Vector2(value, value)
	
func changed_projectile_speed(value):
	emit_signal("projectile_speed_slider_changed", value)

func changed_projectile_size(value):
	emit_signal("projectile_size_slider_changed", value)
