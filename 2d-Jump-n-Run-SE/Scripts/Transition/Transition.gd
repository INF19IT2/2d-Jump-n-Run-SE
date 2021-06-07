extends ColorRect

var next_scene_path = "res://Scenes/Levels/32x32_Level/32x32_Level.tscn"

onready var _anim_player = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func transition_to(_next_scene):
	_anim_player.play_backwards("Fade")
	yield(_anim_player, "animation_finished")
	
	# Plays the Fade animation and wait until it finishes
	#_anim_player.play("Fade")
	#yield(_anim_player, "animation_finished")
	# Changes the scene
	get_tree().change_scene(_next_scene)
