extends Control
const PORT = 10567
const MAX_PLAYERS = 10
func _ready():
	# Called every time the node is added to the scene.
	$AudioStreamPlayer2D3.play(0.0)
	$AudioStreamPlayer2D3.stream.loop = false
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("game_ended", self, "_on_game_ended")
	gamestate.connect("game_error", self, "_on_game_error")
	
	
	
	$Connect/ItemList.add_item("ACL T1 Byte !!!NYI!!!")
	
	$Connect/ItemList.add_item("TEL T1 Builder USV")
	$Connect/ItemList.add_item("TEL T2 Zapper USV")
	$Connect/ItemList.add_item("TEL T3 Bomber USV")
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
	
	#$Connect/ItemList.add_item("REM T4 Lex Aeterna")
	# Set the player name according to the system username. Fallback to the path.
	if OS.has_environment("USERNAME"):
		$Connect/Name.text = OS.get_environment("USERNAME")
	else:
		var desktop_path = OS.get_system_dir(0).replace("\\", "/").split("/")
		$Connect/Name.text = desktop_path[desktop_path.size() - 2]

# Player info, associate ID to data
var player_info = {}
# Info we send to other players
var my_info = { name = "TODO" }

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", my_info)

func _player_disconnected(id):
	player_info.erase(id) # Erase player from info.

func _connected_ok():
	pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	pass # Server kicked us; show error and abort.

func _connected_fail():
	pass # Could not even connect to server; abort.

remote func register_player(info):
	# Get the id of the RPC sender.
	var id = get_tree().get_rpc_sender_id()
	# Store the info
	player_info[id] = info

	# Call function to update lobby UI here

func start_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer

func connect_to_server(ip):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, PORT)
	get_tree().network_peer = peer
func _on_host_pressed():
	$AudioStreamPlayer2D3.play()
	$AudioStreamPlayer2D3.stream.loop = false
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
	$AudioStreamPlayer2D3.play()
	$AudioStreamPlayer2D3.stream.loop = false
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

	$Connect/Host.disabled = false
	$Connect/Join.disabled = false
	$Connect/ErrorLabel.text = "Host doesn't respond!"

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


func _on_Host_mouse_entered():
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D2.stream.loop = false


func _on_Join_mouse_entered():
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D2.stream.loop = false


func _on_Start_mouse_entered():
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D2.stream.loop = false

func _process(delta):
	if Input.is_action_pressed("key_escape"):
		gamestate.end_game()
		get_tree().change_scene("res://MainMenu.tscn")
