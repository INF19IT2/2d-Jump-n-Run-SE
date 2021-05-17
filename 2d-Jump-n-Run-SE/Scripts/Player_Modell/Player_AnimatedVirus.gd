extends KinematicBody2D

signal hit
var is_moving: bool = false

export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800
var velocity = Vector2()

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

var facingRight = true

var pos = Vector2(155, 186)

#gets called when the node and its children have entered the scene tree
func _ready():
	emit_signal("player_stats_changed", self)
	var slider = get_node("Control")
	slider.connect("player_sprite_slider_changed", self, "change_player_size")
	slider.connect("camera_slider_changed", self, "change_camera")
	slider.connect("speed_slider_changed", self, "change_speed")
	slider.connect("jump_slider_changed", self, "change_jump")

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
	if Input.is_action_just_pressed("shoot"):
		if projectileCooldown <= 0.0:
			var projectile = PROJECTILE.instance()
			projectile.start(position, facingRight)
			get_parent().add_child(projectile)
			projectileCooldown = PROJECTILE_COOLDOWN_TIME
	projectileCooldown -= delta

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

func change_player_size(value):
	$AnimatedSprite.scale = Vector2(value, value)
	$CollisionShape2D.scale = Vector2(value, value)

func change_camera(value):
	$Camera2D.zoom = Vector2(value, value)

func change_speed(value):
	speed = value

func change_jump(value):
	jumpForce = value
