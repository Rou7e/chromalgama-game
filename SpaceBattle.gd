extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player = preload("res://playerShips/ShipConstructor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()
	pass # Replace with function body.

func spawn_player():
	var player = Player.instance()
	player.global_position = $playerSpawn.global_position
	add_child(player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
