extends Area2D

var velocity = Vector2()
export var speed = 256
export var damage = 1
export var lifetime = 1
var movingRight: bool
var creator

func start(_position, _facingRight, _creator):
	$Lifetime.wait_time = lifetime
	position = _position
	velocity.x = speed if _facingRight else -speed
	movingRight = _facingRight
	creator = _creator

func _ready():
	if creator == "enemy":
		$AnimatedSprite.flip_h = movingRight
		

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
	if body.get("ISCRATE"):
		body.crate_destroy()


func _on_Projectile_area_entered(area):
	dissolveProjectile()
	if area.has_method('dissolveProjectile'):
		area.dissolveProjectile()


func _on_Lifetime_timeout():
	dissolveProjectile()

func dissolveProjectile():
	queue_free()
