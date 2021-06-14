extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Intro").play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Intro_finished():
	_on_Loop_finished()


func _on_Loop_finished():
	get_node("Loop").play()
