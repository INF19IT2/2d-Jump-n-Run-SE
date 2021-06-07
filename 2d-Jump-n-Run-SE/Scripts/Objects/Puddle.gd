extends Area2D

var overlapsPlayer = false
var player

# damage interval in s
var damageTime = 1
# damage value
var damageValue = 2

var temp : float = damageTime

func start(pos):
	position = pos
	position.y += 6
	
func _on_Puddle_body_entered(body):
	if body.has_method('get_name'):
		if body.get_name() == "Player":
			overlapsPlayer = true
			player = body

func _on_Puddle_body_exited(body):
	if body.has_method('get_name'):
		if body.get_name() == "Player":
			overlapsPlayer = false
			temp = 1

func _process(delta):
	if overlapsPlayer && player != null:
		if player.has_method('take_damage'):
			temp += delta
			if temp >= damageTime:
				player.take_damage(damageValue)
				temp = 0
