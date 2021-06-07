extends StaticBody2D


# Declare member variables here. Examples:
var i = 1
const ISCRATE : bool = true

const LIFE = preload("res://Scenes/Objects/Life_Potion.tscn")
const STAR = preload("res://Scenes/Objects/Invincibility_Star.tscn")

var crate2 = load("res://imagesFiles/crate/crate_2.png")
var crate3 = load("res://imagesFiles/crate/crate_3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#spawn a randomized item, called by crate_destroy
func spawn_item():
	randomize()
	var random = rand_range(0,1)
	var item
	#instance item and add to node-tree
	if(random < 0.5):
		item = LIFE.instance()
	else:
		item = STAR.instance()
	item.set_name("spawned_item")
	add_child(item)
	
	#set position of item (after add_child is important!)
	var new_position = get_global_position()
	new_position.y = position.y - 30
	item.set_global_position(new_position)

func crate_destroy():
	if(i == 1):
		get_node("Sprite").texture = crate2
		i += 1
	elif(i == 2):
		get_node("Sprite").texture = crate3
		spawn_item()
		i += 1
