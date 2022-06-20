extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().reload_current_scene()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_StartGame_pressed():
	#get_tree().reload_current_scene()
	get_tree().change_scene("res://lobby.tscn");


func _on_Button4_pressed():
	get_tree().quit()


func _on_StartGame_mouse_entered():
	$AudioStreamPlayer2D2.play(0.0)

func _on_Button4_mouse_entered():
	$AudioStreamPlayer2D2.play(0.0)
