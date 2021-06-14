extends Node2D

const PUDDLE = preload("res://Scenes/Objects/Puddle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var virus = get_node("CanvasLayer/Virus")
	virus.connect("spam",self,"spawnpuddle")

func spawnpuddle(pos):
	var puddle = PUDDLE.instance()
	puddle.start(pos)
	add_child(puddle)

	
