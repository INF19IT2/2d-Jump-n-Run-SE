extends Area2D


func _ready():
	pass


func _on_Invincibility_Star_body_entered(body):
	if(body.has_method("add_star")):
		body.add_star()
		queue_free()

