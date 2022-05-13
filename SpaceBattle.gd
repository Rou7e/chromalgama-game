extends Node2D

onready var player_vars = get_node("/root/global")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player
var Enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	if player_vars.SB_selected_ship == 1:
		Player = preload("res://playerShips/ShipConstructor.tscn")
	if player_vars.SB_selected_ship == 2:
		Player = preload("res://playerShips/ShipCargo.tscn")
		
	if player_vars.SB_selected_enemy == 1:
		Enemy = preload("res://enemyShips/ShipConstructor.tscn")
	if player_vars.SB_selected_enemy == 2:
		Enemy = preload("res://enemyShips/ShipCargo.tscn")
	
	spawn_player()
	spawn_enemy()
	pass # Replace with function body.

func spawn_player():
	var player = Player.instance()
	#var camera = Camera2D.new()
	player.global_position = $playerSpawn.global_position
	add_child(player)

func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.global_position = $enemySpawn.global_position
	add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
