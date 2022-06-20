extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackToMenu_pressed():
	self.visible=false
	#get_tree().change_scene("res://MainMenu.tscn")
	$Stats.clear()
	gamestate.end_game()

func make_score(winner):
	for i in get_parent().get_parent().get_parent().get_children():
		if i.get_player_name() == winner:
			$Stats.add_item(i.get_player_name() + " - wins!")
		else:
			$Stats.add_item(i.get_player_name())
