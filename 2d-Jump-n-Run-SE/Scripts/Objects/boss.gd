extends KinematicBody2D

#preload projectile object
const PROJECTILE = preload("res://Scenes/Objects/Projectile_Enemies.tscn")

#time between shots
const PROJECTILE_COOLDOWN_TIME = 0.6
var projectileCooldown = 2
var facingRight = false
var health = 30
var projectileStartPos = position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#create projectile on scientist position
	
	projectileStartPos.y = get_parent().get_node("CanvasLayer").get_node("Virus").position.y
	projectileStartPos.x = position.x
	
	var playerPos = get_parent().get_node("CanvasLayer").get_node("Virus").position.x
	
	if playerPos < self.position.x:
		facingRight = false
		$BosshaftesSprite.flip_h = false
	else:
		facingRight = true
		$BosshaftesSprite.flip_h = true
		
	if projectileCooldown <= 0.0:
		var projectile = PROJECTILE.instance()
		projectile.damage = 2
		projectile.start(projectileStartPos, facingRight, "enemy")
		get_parent().add_child(projectile)
		projectile.set_slider_values()
		projectileCooldown = PROJECTILE_COOLDOWN_TIME 

	projectileCooldown -= delta
	
func take_damage(damage):
	health -= damage
	if(health <= 0):
		queue_free()
