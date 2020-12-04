extends KinematicBody2D

#define variables

var ducking_height: int = 0
var is_ducked: bool = false
var is_moving: bool = false
onready var standing_collision = $CollisionShape2D
onready var crouching_collision = $ducking_CollisionShape2D
onready var player_standing = $Virus
onready var player_ducked = $Virus_Crouch
onready var player_jump = $Virus_Jump

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

signal player_dead
signal player_stats_changed


var coins : int = 0

var velocity = Vector2()
var facingRight = true

var pos = Vector2()


#gets called when the node and its children have entered the scene tree
func _ready():
	emit_signal("player_stats_changed", self)
	print(player_standing.get_global_position())
	


func set_checkpoint(var check):
	pos = check


func respawn():
	self.position = pos
	health = health_max
	emit_signal("player_stats_changed", self)


#gets called 60 times a second
func _physics_process(delta):
	velocity.x = 0
	is_moving = false
	
	#define movement
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		facingRight = true
		is_moving = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		facingRight = false

		is_moving = true

	
	#create projectile on player position
	if Input.is_action_just_pressed("shoot") and is_ducked == false:
		if projectileCooldown <= 0.0:
			var projectile = PROJECTILE.instance()
			projectile.start(position, facingRight)
			get_parent().add_child(projectile)
			projectileCooldown = PROJECTILE_COOLDOWN_TIME
	projectileCooldown -= delta
	
	if is_on_floor():
		player_jump.visible = false
		player_standing.visible = true
	elif not is_on_floor() and not is_ducked:
		player_standing.visible = false
		player_jump.visible = true
		
	#gravity
	velocity.y += gravity * delta
	
	if velocity.x != 0:
		player_standing.flip_v = false
		player_standing.flip_h = velocity.x < 0
		player_ducked.flip_v = false
		player_ducked.flip_h = velocity.x < 0
	elif velocity.y != 0:
		player_jump.flip_v = velocity.y > 0
		
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor() and !is_ducked:
		velocity.y -= jumpForce
		player_jump.visible = true
		player_standing.visible = false
		
	#define running
	if Input.is_action_pressed("running") and is_moving and !is_ducked:
		if(facingRight):
			velocity.x += speed
		elif(!facingRight):
			velocity.x -= speed
		
	
	#var player_pos = player.get_position_in_parent()

	if Input.is_action_pressed("move_down") and is_on_floor():
		standing_collision.disabled = true
		crouching_collision.disabled = false
		player_ducked.visible = true
		player_standing.visible = false
		is_ducked=true
	
	if not Input.is_action_pressed("move_down"):
		standing_collision.disabled = false
		crouching_collision.disabled = true
		is_ducked = false
		player_standing.visible = true
		player_ducked.visible = false
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_pressed("test_dmg"):
		take_damage(10)
		
	if get_position().floor().y > 600:
		take_damage(5)
		
func take_damage(dmg):
	if health > dmg:
		health -= dmg
		emit_signal("player_stats_changed", self)
	else:
		print("Dead")
		respawn()
	
func add_collectable():
	coins += 1
	var lab = get_node("Label")
	lab.set_text(str(coins))
