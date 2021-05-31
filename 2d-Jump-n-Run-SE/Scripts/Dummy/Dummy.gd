extends KinematicBody2D


# Declare member variables here. Examples:
var health : int = 1
var count : int = 0
export var speed : int = 200
export var jumpForce : int = 500
export var gravity : int = 800

onready var dummy_default = $Sprite
onready var dummy_infected = $Sprite2

var infection_duration : int = 5

var infected : bool = false

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x += speed
	pass 


func _physics_process(delta):
	
	#define movement
	if(is_on_wall()):
		velocity.x = 0
		if(count == 1):
			velocity.x += speed
			count = 0
		elif(count == 0):
			velocity.x -= speed
			count = 1
	
	
	#gravity
	velocity.y += gravity * delta
	
	#Applying Velocity
		#Vector2.UP -> Ground is facing up
	velocity = move_and_slide(velocity, Vector2.UP)

func get_infected():
	infected = true
	$Infectiontimer.wait_time = infection_duration
	$Infectiontimer.start()
	dummy_default.visible = false
	dummy_infected.visible = true

func cure_infection():
	dummy_default.visible = true
	dummy_infected.visible = false
	infected = false

func take_damage(damage):
	health -= damage
	if(health <= 0):
		queue_free()

func _on_Infectiontimer_timeout():
	cure_infection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
