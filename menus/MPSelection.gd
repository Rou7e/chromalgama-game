extends Control


func _ready():
	pass


func _on_ButtonConnect_pressed():
	var ip = $GridContainer/IP.text
	Lobby.connect_to_server(ip)
	get_tree().change_scene("res://menus/MPLobby.tscn")


func _on_ButtonHost_pressed():
	Lobby.start_server()
	get_tree().change_scene("res://menus/MPLobby.tscn")
	
