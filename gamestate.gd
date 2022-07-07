extends Node

const mark_friend = preload("res://projectiles/mark_friendly.tscn")
const mark_enemy = preload("res://projectiles/mark_enemy.tscn")
const mark_cursor = preload("res://projectiles/mark_cursor.tscn")
#const cargo = preload("res://ships/selenite_ships/Cargo.tscn")
const tel_t4 = preload("res://ships/tellurian_ships/tel_t4.tscn")
const tel_t2 = preload("res://ships/tellurian_ships/tel_t2.tscn")
const tel_t3 = preload("res://ships/tellurian_ships/tel_t3.tscn")
const tel_t1 = preload("res://ships/tellurian_ships/tel_t1.tscn")
const tel_t5 = preload("res://ships/tellurian_ships/tel_t5.tscn")
const tel_t6 = preload("res://ships/tellurian_ships/tel_t6.tscn")
const tel_t7 = preload("res://ships/tellurian_ships/tel_t7.tscn")
const acl_t1 = preload("res://ships/tellurian_ships/acl_t1.tscn")

const sel_t4 = preload("res://ships/selenite_ships/sel_t4.tscn")
const sel_t2 = preload("res://ships/selenite_ships/sel_t2.tscn")
const sel_t3 = preload("res://ships/selenite_ships/sel_t3.tscn")
const sel_t1 = preload("res://ships/selenite_ships/sel_t1.tscn")
const sel_t5 = preload("res://ships/selenite_ships/sel_t5.tscn")
const sel_t6 = preload("res://ships/selenite_ships/sel_t6.tscn")
const sel_t7 = preload("res://ships/selenite_ships/sel_t7.tscn")

# Default game server port. Can be any number between 1024 and 49151.
# Not on the list of registered or common ports as of November 2020:
# https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
const DEFAULT_PORT = 10567
const npc_type = ["ACL T1", "TEL T1", "TEL T2", "TEL T3", "TEL T4", "TEL T5", "TEL T6", "TEL T7", "SEL T1", "SEL T2", "SEL T3", "SEL T4", "SEL T5", "SEL T6", "SEL T7"]
# Max number of players.
const MAX_PEERS = 12

var npc_id = 1
var peer = null

# Name for my player.
var player_name = "The Warrior"
var selected_ship
# Names for remote players in id:name format.
var players = {}
var players_ready = []
var selected_ships = {}
var NPCs = []
var NPC_selected_ships = []

# Signals to let lobby GUI know what's going on.
signal player_list_changed()
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what)

# Callback from SceneTree.
func _player_connected(id):
	# Registration of a client beings here, tell the connected player that we are here.
	rpc_id(id, "register_player", player_name, selected_ship)
	


# Callback from SceneTree.
func _player_disconnected(id):
	if has_node("/root/World"): # Game is in progress.
		if get_tree().is_network_server():
			emit_signal("game_error", "Player " + players[id] + " disconnected")
			end_game()
	else: # Game is not in progress.
		# Unregister this player.
		unregister_player(id)


# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	# We just connected to a server
	emit_signal("connection_succeeded")


# Callback from SceneTree, only for clients (not server).
func _server_disconnected():
	emit_signal("game_error", "Server disconnected")
	end_game()


# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	get_tree().set_network_peer(null) # Remove peer
	emit_signal("connection_failed")


# Lobby management functions.

remote func register_player(new_player_name, selected_ship):
	var id = get_tree().get_rpc_sender_id()
	#print(id)
	players[id] = new_player_name
	selected_ships[id] = selected_ship
	emit_signal("player_list_changed")

remote func register_NPC(selected_ship):
	#print(id)
	NPCs.append( "NPC " + npc_type[selected_ship] + "/" + str(npc_id))
	NPC_selected_ships.append(selected_ship) 
	emit_signal("player_list_changed")
	npc_id += 1

func unregister_player(id):
	players.erase(id)
	selected_ships.erase(id)
	emit_signal("player_list_changed")


remote func pre_start_game(spawn_points, npc_spawn_points):
	# Change scene.
	var world = load("res://world.tscn").instance()
	get_tree().get_root().add_child(world)

	get_tree().get_root().get_node("Lobby").hide()

	var player_scene = load("res://ships/base_stuff/PlayerController.tscn")
	var enemy_scene = load("res://ships/base_stuff/EnemyController.tscn")
	var n_id = 0
	for p_id in spawn_points:
		var spawn_pos = world.get_node("SpawnPoints/" + str(spawn_points[p_id])).position
		
		if p_id >= 500:
			var enemy = enemy_scene.instance()
			enemy.selected_ship = NPC_selected_ships[n_id]
			
			enemy.parent_id = "ENEMY"
			enemy.global_position = spawn_pos
			world.get_node("NPCs").add_child(enemy)
			n_id+=1
			continue
		var player = player_scene.instance()
		
		player.set_name(str(p_id)) # Use unique ID as node name.
		player.position=spawn_pos
		player.set_network_master(p_id) #set unique id as master.
		
		
		if p_id == get_tree().get_network_unique_id():
			# If node for this peer id, set name.
			player.set_player_name(player_name)
			player.selected_ship = selected_ship
		else:
			# Otherwise set name from peer.
			player.set_player_name(players[p_id])
			player.selected_ship = selected_ships[p_id]
			
		world.get_node("Players").add_child(player)

	# Set up score.
	#world.get_node("Score").add_player(get_tree().get_network_unique_id(), player_name)
	#for pn in players:
	#	world.get_node("Score").add_player(pn, players[pn])

	if not get_tree().is_network_server():
		# Tell server we are ready to start.
		rpc_id(1, "ready_to_start", get_tree().get_network_unique_id())
	elif players.size() == 0:
		post_start_game()


remote func post_start_game():
	get_tree().set_pause(false) # Unpause and unleash the game!


remote func ready_to_start(id):
	assert(get_tree().is_network_server())

	if not id in players_ready:
		players_ready.append(id)

	if players_ready.size() == players.size():
		for p in players:
			rpc_id(p, "post_start_game")
		post_start_game()


func host_game(new_player_name, selected_ship_host):
	player_name = new_player_name
	selected_ship=selected_ship_host
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PEERS)
	get_tree().set_network_peer(peer)


func join_game(ip, new_player_name, selected_ship_client):
	player_name = new_player_name
	selected_ship = selected_ship_client
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(peer)


func get_player_list():
	return players.values()

func get_npc_list():
	return NPCs


func get_player_name():
	return player_name


func begin_game():
	assert(get_tree().is_network_server())

	# Create a dictionary with peer id and respective spawn points, could be improved by randomizing.
	var spawn_points = {}
	var npc_spawn_points = []
	spawn_points[1] = 0 # Server in spawn point 0.
	var spawn_point_idx = 1
	for p in players:
		spawn_points[p] = spawn_point_idx
		spawn_point_idx += 1
	for e in range(npc_id-1):
		spawn_points[e+500] = spawn_point_idx
		npc_spawn_points.append(e)
		spawn_point_idx += 1
	# Call to pre-start game with the spawn points.
	for p in players:
		rpc_id(p, "pre_start_game", spawn_points)

	pre_start_game(spawn_points, npc_spawn_points)


func end_game():
	if has_node("/root/world"): # Game is in progress.
		# End it
		for i in get_node("/root/world/Players").get_children():
			i.queue_free()
		get_node("/root/world").queue_free()

	emit_signal("game_ended")
	players.clear()
	selected_ships.clear()
	players_ready.clear()
	selected_ship = 0
	

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
