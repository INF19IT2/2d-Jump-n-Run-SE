extends KinematicBody2D

# Declare member variables here. Examples:
var health : int = 3
var count : int = 0
export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800
var facingRight = true
var activated = false

#preload projectile object
const PROJECTILE = preload("res://Scenes/Objects/Projectile_Enemies.tscn")

#time between shots
const PROJECTILE_COOLDOWN_TIME = 1
var projectileCooldown = 0.0

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 0
	pass 


func _physics_process(delta):
	
	var playerPos = get_parent().get_node("CanvasLayer").get_node("Virus").position.x
	
	if(abs(playerPos - self.position.x) <= 200 and activated == false):
		activated = true
	
	#define movement
	if (activated):
		$AnimatedSprite.play("walk")
		if velocity.x != 0:
			$AnimatedSprite.flip_h = velocity.x < 0
		if (abs(playerPos - self.position.x) >= (32 * 4)):
			if(playerPos > self.position.x and velocity.x <= 0):
				velocity.x += speed
				facingRight = true
			else:
				if(velocity.x >= 0):
					velocity.x -= speed
					facingRight = false
		else:
			if(get_parent().get_node("CanvasLayer").get_node("Virus").velocity.x == 0):
				velocity.x = 0
			else: 
				if(playerPos > self.position.x and velocity.x >= 0):
					velocity.x -= speed
					facingRight = true
				else:
					if(velocity.x <= 0):
						velocity.x += speed
						facingRight = false

	
	#create projectile on scientist position
	if projectileCooldown <= 0.0 and activated:
		var projectile = PROJECTILE.instance()
		projectile.start(position, facingRight, "enemy")
		get_parent().add_child(projectile)
		projectile.set_slider_values()
		projectileCooldown = PROJECTILE_COOLDOWN_TIME
	
	
	#
	projectileCooldown -= delta
	
	#gravity
	velocity.y += gravity * delta
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)


func take_damage(damage):
	health -= damage
	if(health <= 0):
		queue_free()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
