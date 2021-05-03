extends Area2D

var velocity = Vector2()
export var speed = 400
export var damage = 5
export var lifetime = 1

func start(_position, _facingRight):
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
