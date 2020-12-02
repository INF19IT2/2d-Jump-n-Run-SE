extends Node

func _ready():
	var playernode = get_parent()# .get_node("Player")
	playernode.connect("player_stats_changed", self, "update_health_bar")

func update_health_bar(var player):
	$Health/Bar.rect_size.x = 100 * player.health / player.health_max
