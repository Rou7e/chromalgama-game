extends Control


func _ready():
	pass


func _on_ButtonConnect_pressed():
	var ip = $GridContainer/IP.text
	var nickname = $GridContainer2/Playername.text
	Lobby.connect_to_server(ip, nickname)
	get_tree().change_scene("res://menus/MPLobby.tscn")


func _on_ButtonHost_pressed():
	Lobby.start_server()
	get_tree().change_scene("res://menus/MPLobby.tscn")
	
