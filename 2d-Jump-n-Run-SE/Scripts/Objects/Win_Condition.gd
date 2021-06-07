extends Area2D

var level_folder = "res://Scenes/Levels/"

const TRANSITION = preload("res://Scenes/Transition/Transition.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	var transition = TRANSITION.instance()
	get_parent().add_child(transition)
	transition.transition_to(level_folder + "32x32_Level/32x32_Level.tscn")
