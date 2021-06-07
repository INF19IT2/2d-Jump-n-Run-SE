extends ColorRect

onready var _anim_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func transition_to(_next_scene):
	_anim_player.play_backwards("Fade")
	yield(_anim_player, "animation_finished")
	
	# Changes the scene
	get_tree().change_scene(_next_scene)