extends Control

func _ready():
	# Called every time the node is added to the scene.
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("game_ended", self, "_on_game_ended")
	gamestate.connect("game_error", self, "_on_game_error")
	
	$Connect/ItemList.add_item("ACL T1 Byte !!!NYP!!!")
	
	$Connect/ItemList.add_item("TEL T1 Drone")
	$Connect/ItemList.add_item("TEL T2 Drone")
	$Connect/ItemList.add_item("TEL T3 Drone")
	$Connect/ItemList.add_item("TEL T4 Revenant")
	$Connect/ItemList.add_item("TEL T5 Constructor")
	$Connect/ItemList.add_item("TEL T6 Dequisitor")
	$Connect/ItemList.add_item("TEL T7 Balor")
	
	$Connect/ItemList.add_item("SEL T1 Kunai")
	$Connect/ItemList.add_item("SEL T2 Navaja")
	$Connect/ItemList.add_item("SEL T3 Cutlass")
	$Connect/ItemList.add_item("SEL T4 Machete")
	$Connect/ItemList.add_item("SEL T5 Tanto")
	$Connect/ItemList.add_item("SEL T6 Claymore")
	$Connect/ItemList.add_item("SEL T7 Zweihander")
	
	$Connect/ItemList.add_item("REM T4 Lex Aeterna")
	# Set the player name according to the system username. Fallback to the path.
	if OS.has_environment("USERNAME"):
		$Connect/Name.text = OS.get_environment("USERNAME")
	else:
		var desktop_path = OS.get_system_dir(0).replace("\\", "/").split("/")
		$Connect/Name.text = desktop_path[desktop_path.size() - 2]


func _on_host_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return
	
	if len($Connect/ItemList.get_selected_items())==0:
		$Connect/ErrorLabel.text = "Select a ship!"
		return
	
	$Connect.hide()
	$Players.show()
	$Connect/ErrorLabel.text = ""

	var player_name = $Connect/Name.text
	gamestate.host_game(player_name, $Connect/ItemList.get_selected_items()[0])
	#gamestate.selected_ships.append($Connect/ItemList.get_selected_items()[0])
	refresh_lobby()


func _on_join_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	if len($Connect/ItemList.get_selected_items())==0:
		$Connect/ErrorLabel.text = "Select a ship!"
		return

	var ip = $Connect/IPAddress.text
	if not ip.is_valid_ip_address():
		$Connect/ErrorLabel.text = "Invalid IP address!"
		return

	$Connect/ErrorLabel.text = ""
	$Connect/Host.disabled = true
	$Connect/Join.disabled = true

	var player_name = $Connect/Name.text
	gamestate.join_game(ip, player_name, $Connect/ItemList.get_selected_items()[0])


func _on_connection_success():
	$Connect.hide()
	$Players.show()
	#gamestate.selected_ships.append($Connect/ItemList.get_selected_items()[0])


func _on_connection_failed():
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false
	$Connect/ErrorLabel.set_text("Connection failed.")


func _on_game_ended():
	show()
	$Connect.show()
	$Players.hide()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func _on_game_error(errtxt):
	$ErrorDialog.dialog_text = errtxt
	$ErrorDialog.popup_centered_minsize()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func refresh_lobby():
	var players = gamestate.get_player_list()
	players.sort()
	$Players/List.clear()
	$Players/List.add_item(gamestate.get_player_name() + " (You)")
	for p in players:
		$Players/List.add_item(p)

	$Players/Start.disabled = not get_tree().is_network_server()


func _on_start_pressed():
	
	gamestate.begin_game()


func _on_find_public_ip_pressed():
	OS.shell_open("https://icanhazip.com/")
