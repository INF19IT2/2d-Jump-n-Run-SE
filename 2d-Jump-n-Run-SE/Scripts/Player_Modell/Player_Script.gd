extends KinematicBody2D

#define variables
export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800

# Player stats
var health : int = 100
var health_max : int = 100

signal player_stats_changed

var velocity = Vector2()

#gets called 60 times a second
func _physics_process(delta):
	velocity.x = 0
	
	#define movement
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	
	#gravity
	velocity.y += gravity * delta
	
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y -= jumpForce
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)


