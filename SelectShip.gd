extends Node2D

onready var player_vars = get_node("/root/global")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selectedShip = 0
var selectedEnemy = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Constructor_pressed():
	selectedShip=1
func _on_Cargoship_pressed():
	selectedShip=2



func _on_StartBattle_pressed():
	if selectedShip==0 or selectedEnemy==0:
		$Alert.popup_centered()
	else:
		player_vars.SB_selected_ship=selectedShip
		player_vars.SB_selected_enemy=selectedEnemy
		get_tree().change_scene("res://SpaceBattle.tscn");





func _on_EConstructor_pressed():
	selectedEnemy=1


func _on_ECargoship_pressed():
	selectedEnemy=2
