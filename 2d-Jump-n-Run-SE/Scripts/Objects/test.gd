extends KinematicBody2D

signal hit
export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800
var is_ducked: bool = false
var velocity = Vector2()

func _physics_process(delta):
	velocity.x = 0
	
	#define movement
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if velocity.length() > 0:
		$AnimatedSprite.play()
		$AnimatedSprite.set_speed_scale(5.0)
	else:
		$AnimatedSprite.stop()
	#gravity
	velocity.y += gravity * delta
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
		
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor() and !is_ducked:
		velocity.y -= jumpForce
		
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)
