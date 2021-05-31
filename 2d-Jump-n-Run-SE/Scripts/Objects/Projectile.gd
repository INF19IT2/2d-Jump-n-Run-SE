extends Area2D

var velocity = Vector2()
export var speed = 64
export var damage = 1
export var lifetime = 4

func start(_position, _facingRight, _creator):
	$Lifetime.wait_time = lifetime
	position = _position
	if _creator == "enemy":
		$AnimatedSprite.play("default")
	velocity.x = speed if _facingRight else -speed


func _ready():
	var slider = get_parent()
	if slider.name != "Node2D":
		slider = slider.get_parent()
	slider.connect("projectile_speed_slider_changed", self, "set_speed")
	slider.connect("projectile_size_slider_changed", self, "set_size")
		
func set_slider_values():
	#speed slider
	var speed_slider = get_parent()
	if speed_slider.name != "Node2D":
		speed_slider = speed_slider.get_parent()
	speed_slider = speed_slider.get_node("CanvasLayer").get_node("Virus").get_node("Control").get_node("Projectile_Speed_Slider")
	speed = speed_slider.value * 64
	velocity.x = speed if velocity.x>0 else -speed

	#lifetime slider
	var lifetime_slider = get_parent()
	if lifetime_slider.name != "Node2D":
		lifetime_slider = lifetime_slider.get_parent()
	lifetime_slider = lifetime_slider.get_node("CanvasLayer").get_node("Virus").get_node("Control").get_node("Projectile_Lifetime_Slider")
	lifetime = lifetime_slider.value
	var lifetimeTimer : Timer = get_node("Lifetime")
	lifetimeTimer.start(lifetime)

	#size slider
	var size_slider = get_parent()
	if size_slider.name != "Node2D":
		size_slider = size_slider.get_parent()
	size_slider = size_slider.get_node("CanvasLayer").get_node("Virus").get_node("Control").get_node("Projectile_Size_Slider")
	var scaling_value = size_slider.value
	scale = Vector2(scaling_value,scaling_value)

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

func _on_Projectile_area_entered(area):
	dissolveProjectile()
	if area.has_method('dissolveProjectile'):
		area.dissolveProjectile()
	
func _on_Lifetime_timeout():
	dissolveProjectile()

func dissolveProjectile():
	queue_free()

func set_speed(value):
	speed = value * 64
	velocity.x = speed if velocity.x>0 else -speed

func set_size(value):
	scale = Vector2(value, value)
