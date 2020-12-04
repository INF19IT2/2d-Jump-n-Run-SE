extends KinematicBody2D

#define variables

var ducking_height: int = 0
var is_ducked: bool = false
onready var standing_collision = $CollisionPolygon2D
onready var crouching_collision = $ducking_CollisionPolygon2D
onready var player_standing = $Virus
onready var player_ducked = $Virus_Crouch

export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800

#preload projectile object
const PROJECTILE = preload("res://Scenes/Objects/Projectile.tscn")

#time between shots
const PROJECTILE_COOLDOWN_TIME = 0.25
var projectileCooldown = 0.0

# Player stats
var health : int = 100
var health_max : int = 100

signal player_stats_changed

var coins : int = 0

var velocity = Vector2()
var facingRight = true

#gets called when the node and its children have entered the scene tree
func _ready():
	emit_signal("player_stats_changed", self)

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
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	#create projectile on player position
	if Input.is_action_just_pressed("shoot") and is_ducked == false:
		if projectileCooldown <= 0.0:
			var projectile = PROJECTILE.instance()
			projectile.start(position, facingRight)
			get_parent().add_child(projectile)
			projectileCooldown = PROJECTILE_COOLDOWN_TIME
	projectileCooldown -= delta
	
	#gravity
	velocity.y += gravity * delta
	
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor() and !is_ducked:
		velocity.y -= jumpForce
		$AnimatedSprite.animation = "jump"
		
		
	#var player_pos = player.get_position_in_parent()
	if Input.is_action_pressed("move_down") and is_on_floor():
		standing_collision.disabled = true
		crouching_collision.disabled = false
		$AnimatedSprite.animation = "crouch"
		is_ducked=true
	
	if !Input.is_action_pressed("move_down"):
		standing_collision.disabled = false
		crouching_collision.disabled = true
		is_ducked = false
		$AnimatedSprite.animation = "walk"
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
