extends KinematicBody2D

#define variables
var speed : int = 200
var jumpForce : int = 500
var gravity : int = 800
var ducking_height: int = 0
var is_ducked: bool = false
onready var standing_collision = $CollisionShape2D
onready var crouching_collision = $Ducking_CollisionShape2D
onready var player_standing = $Sprite
onready var player_ducked = $Sprite2


var velocity = Vector2()

#gets called 60 times a second
func _physics_process(delta):
	velocity.x = 0
	
	#define movement
	if Input.is_action_pressed("move_right"):
		velocity.x += 200
	if Input.is_action_pressed("move_left"):
		velocity.x -= 200
	
	#gravity
	velocity.y += gravity * delta
	
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor() and !is_ducked:
		velocity.y -= jumpForce
		
	#var player_pos = player.get_position_in_parent()
	if Input.is_action_pressed("move_down") and is_on_floor():
		standing_collision.disabled = true
		crouching_collision.disabled = false
		player_standing.visible = false
		player_ducked.visible = true
		is_ducked=true
	
	if !Input.is_action_pressed("move_down"):
		standing_collision.disabled = false
		crouching_collision.disabled = true
		is_ducked = false
		player_standing.visible = true
		player_ducked.visible = false
		#player -= 48
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)
	
