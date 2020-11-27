extends KinematicBody2D

#define variables

var ducking_height: int = 0
var is_ducked: bool = false
onready var standing_collision = $CollisionShape2D
onready var crouching_collision = $Ducking_CollisionShape2D
onready var player_standing = $Sprite
onready var player_ducked = $Sprite2

export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800


# Player stats
var health : int = 100
var health_max : int = 100

signal player_stats_changed

var coins : int = 0


var velocity = Vector2()

#gets called when the node and its children have entered the scene tree
func _ready():
	emit_signal("player_stats_changed", self)

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

	if Input.is_action_just_pressed("test_dmg"):
		if health > 10:
			health -= 10
			emit_signal("player_stats_changed", self)
		elif health <= 10:
			health = 0
			emit_signal("player_stats_changed", self)
			print("Dead")

func add_collectable():
	coins += 1
	var lab = get_node("Label")
	lab.set_text(str(coins))