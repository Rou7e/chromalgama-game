extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selectedShip = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Constructor_pressed():
	selectedShip=1


func _on_StartBattle_pressed():
	if selectedShip==0:
		$Alert.popup_centered()
	else:
		get_tree().change_scene("res://SpaceBattle.tscn");
