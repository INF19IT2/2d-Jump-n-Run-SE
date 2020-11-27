extends Area2D


func _ready():
	pass


func _on_Collectable_body_entered(body):
	if(body.has_method("add_collectable")):
		body.add_collectable()
		queue_free()
