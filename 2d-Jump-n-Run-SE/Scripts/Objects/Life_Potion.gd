extends Area2D


func _ready():
	pass 


func _on_Area2D_body_entered(body):
	if(body.has_method("life_potion")):
		body.life_potion()
		queue_free()
