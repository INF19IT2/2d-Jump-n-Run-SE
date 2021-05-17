extends Area2D

var velocity = Vector2()
export var speed = 32
export var damage = 5
export var lifetime = 2

func start(_position, _facingRight):
	#set parameters if slider is present
	var parent = get_parent()
	if parent != null:
		var speed_slider = parent.get_node("KinematicBody2D2").get_node("Control").get_node("Projectile_Speed_Slider")
		speed = speed_slider.value
	
	$Lifetime.wait_time = lifetime
	position = _position
	velocity.x = speed if _facingRight else -speed

func _process(delta):
	move(delta)

func move(delta):
	position += velocity * delta

func _on_Projectile_body_entered(body):
	dissolveProjectile()
	if body.has_method('take_damage'):
		body.take_damage(damage)
	if body.has_method('get_infected'):
		body.get_infected()

func _on_Lifetime_timeout():
	dissolveProjectile()

func dissolveProjectile():
	queue_free()
