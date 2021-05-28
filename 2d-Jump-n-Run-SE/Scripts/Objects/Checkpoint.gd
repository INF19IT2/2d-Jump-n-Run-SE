extends Area2D


# Declare member variables here.
onready var checkpoint_default = $Sprite
onready var checkpoint_active = $Sprite2

var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "capture"

func _on_Area2D_body_entered(body):
	if (body.has_method("set_checkpoint")):
		body.set_checkpoint(body.get_position().floor())
		
		if (!entered):
			$AnimatedSprite.play("capture")
			yield(get_node("AnimatedSprite"), "animation_finished")
			$AnimatedSprite.play("idle")		
			
		entered = true
		
		

		
