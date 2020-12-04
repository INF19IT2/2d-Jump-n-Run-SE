extends Area2D


# Declare member variables here.
onready var checkpoint_default = $Sprite
onready var checkpoint_active = $Sprite2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 



func _on_Area2D_body_entered(body):
	if (body.has_method("set_checkpoint")):
		body.set_checkpoint(checkpoint_active.get_global_position())
		checkpoint_default.visible = false
		checkpoint_active.visible = true
