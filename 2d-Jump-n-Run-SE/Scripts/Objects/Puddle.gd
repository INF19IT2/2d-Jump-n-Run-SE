extends Area2D

var overlapsPlayer = false
var player

func _on_Puddle_body_entered(body):
	if body.has_method('get_name'):
		if body.get_name() == "Player":
			overlapsPlayer = true
			player = body

func _on_Puddle_body_exited(body):
	if body.has_method('get_name'):
		if body.get_name() == "Player":
			overlapsPlayer = false

func _process(delta):
	if overlapsPlayer && player != null:
		if player.has_method('take_damage'):
			player.take_damage(delta)
