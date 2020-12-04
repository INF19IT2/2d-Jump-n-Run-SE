extends Area2D

onready var timer = get_node("Timer")

var waittime = 0.25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
# Collision function
func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		var player_size = 32
		
		if ((body.global_position.y + player_size) <= self.global_position.y - 32):
			timer.set_wait_time(waittime)
			timer.start()


func _on_Timer_timeout():
	get_parent().queue_free()
