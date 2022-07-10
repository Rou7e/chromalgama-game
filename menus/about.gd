extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("key_escape"):
		get_tree().change_scene("res://MainMenu.tscn")


func _on_Start_pressed():
	OS.shell_open("https://discord.gg/vckVDhtFGn")


func _on_Start2_pressed():
	OS.shell_open("https://github.com/Rou7e/chromalgama-game/issues")
