extends KinematicBody2D

#define variables
export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800

#preload projectile object
const PROJECTILE = preload("res://Scenes/Objects/Projectile.tscn")

#time between shots
const PROJECTILE_COOLDOWN_TIME = 0.25
var projectileCooldown = 0.0

var velocity = Vector2()
var facingRight = true

#gets called 60 times a second
func _physics_process(delta):
	velocity.x = 0
	
	#define movement
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		facingRight = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		facingRight = false
	
	#create projectile on player position
	if Input.is_action_just_pressed("shoot"):
		if projectileCooldown <= 0.0:
			var projectile = PROJECTILE.instance()
			projectile.start(position, facingRight)
			get_parent().add_child(projectile)
			projectileCooldown = PROJECTILE_COOLDOWN_TIME
	projectileCooldown -= delta
	
	#gravity
	velocity.y += gravity * delta
	
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y -= jumpForce
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)


