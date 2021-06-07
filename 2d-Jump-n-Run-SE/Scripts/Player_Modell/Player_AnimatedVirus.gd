extends KinematicBody2D

signal hit
var is_moving: bool = false

export var speed : int = 75
export var jumpForce : int = 250
export var gravity : int = 800
var velocity = Vector2()

#preload projectile object
const PROJECTILE = preload("res://Scenes/Objects/Projectile.tscn")

#time between shots
const PROJECTILE_COOLDOWN_TIME = 0.3
var projectileCooldown = 0.0

# Player stats
var health : int = 10
var health_max : int = 10

signal player_dead
signal player_stats_changed
signal spam(pos)

var invincible = false

var coins : int = 0

var facingRight = true

var pos = Vector2(155, 186)

var lastx = position.x
var spamtimer = 0

#gets called when the node and its children have entered the scene tree
func _ready():
	emit_signal("player_stats_changed", self)


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
	if Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		velocity.x += speed
		facingRight = true
		is_moving = true
	if Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		velocity.x -= speed
		facingRight = false
		is_moving = true
		
	#idle Animation
	if velocity.length() == 0:
		$AnimatedSprite.play("idle")
		$AnimatedSprite.animation = "idle"
		
	#gravity
	velocity.y += gravity * delta
	
	#x-Vector > 0 --> move Animaiton
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite.animation = "move"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
		
	#define Jumping
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y -= jumpForce
		$AnimatedSprite.play("jump_up")
		
	if velocity.y > 0 and !is_on_floor():
		$AnimatedSprite.play("jump_down")

	#define running
	if Input.is_action_pressed("running") and is_moving:
		$AnimatedSprite.set_speed_scale(2)
		if(facingRight):
			velocity.x += speed
		elif(!facingRight):
			velocity.x -= speed
	else:
		$AnimatedSprite.set_speed_scale(1)
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)
	
		#create projectile on player position
	if Input.is_action_pressed("shoot"):
		if projectileCooldown <= 0.0:
			var projectile = PROJECTILE.instance()
			projectile.start(position, facingRight, "player")
			get_parent().add_child(projectile)
			projectileCooldown = PROJECTILE_COOLDOWN_TIME
	projectileCooldown -= delta
	
	
	if abs(position.x-lastx)<=20:
		spamtimer += 1
	else:
		lastx = position.x
		spamtimer = 0
		
	if spamtimer >= 300:
		emit_signal("spam",position)
		spamtimer = 0
		
	if get_position().floor().y > 600:
		take_damage(5)
		

func take_damage(dmg):
	if !invincible:
		if health > dmg:
			health -= dmg
			emit_signal("player_stats_changed", self)
		else:
			respawn()
	
func add_collectable():
	coins += 1
	var lab = get_node("Label")
	lab.set_text(str(coins))

#player is invincible for 5 seconds
func add_star():
	invincible = true
	yield(get_tree().create_timer(5.0), "timeout")
	invincible = false
	#called when the player "collects" a life-potion
	#player-hp get filled up to 100% 
func life_potion(): 
	health = health_max
	emit_signal("player_stats_changed", self)


func get_name():
	return "Player"
