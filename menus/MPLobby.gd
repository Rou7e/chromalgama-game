extends Control


func _ready():
	pass
	
func _process(delta):
	var num_players = len(Lobby.player_info)+1
	var is_host = get_tree().get_network_unique_id() == 1
	$PlayerCount.text = str(num_players)
	$StartButton.visible = is_host

remotesync func start_game():
	get_tree().change_scene("res://SpaceBattle.tscn")

func _on_StartButton_pressed():
	rpc("start_game")
