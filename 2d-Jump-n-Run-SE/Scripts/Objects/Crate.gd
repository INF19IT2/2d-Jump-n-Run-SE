extends StaticBody2D


# Declare member variables here. Examples:
var i = 1
const ISCRATE : bool = true

var crate2 = load("res://imagesFiles/crate/crate_2.png")
var crate3 = load("res://imagesFiles/crate/crate_3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func crate_destroy():
	if(i == 1):
		get_node("Sprite").texture = crate2
		i += 1
	elif(i == 2):
		get_node("Sprite").texture = crate3
