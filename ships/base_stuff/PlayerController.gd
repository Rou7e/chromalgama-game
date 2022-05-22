extends Node2D

var input_vector = Vector2.ZERO
const mark_friend = preload("res://projectiles/mark_friendly.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var mark = mark_friend.instance()
	if gamestate.selected_ship == 0:
		add_child(load("res://ships/Cargo.tscn").instance())
	if gamestate.selected_ship == 1:
		add_child(load("res://ships/tellurian_ships/tel_t4.tscn").instance())
	$Camera2D/Player_UI/HEAT.max_value = get_child(1).cooling
	$Camera2D/Player_UI/CREW.max_value = get_child(1).crew
	$Camera2D/Player_UI/PRIMARY.max_value = get_child(1).primary
	$Camera2D/Player_UI/SECONDARY.max_value = get_child(1).secondary
	$Camera2D/Player_UI/TURRET.max_value = get_child(1).turret
	
	$Camera2D.current = is_network_master()
	$Camera2D.visible = is_network_master()
	

	get_child(1).id = "PC"+str(get_network_master())
	

	for i in range(get_parent().get_child_count()):
		mark.global_position.x = get_parent().get_child(i).global_position.x/9.11
		mark.global_position.y = get_parent().get_child(i).global_position.y/8.1
		$Camera2D/Sprite.add_child(mark)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mark = mark_friend.instance()
	
	$Camera2D.global_position = get_child(1).global_position
	$Camera2D/Player_UI/HEAT.value = get_child(1).cooling
	$Camera2D/Player_UI/CREW.value = get_child(1).crew
	$Camera2D/Player_UI/PRIMARY.value = get_child(1).primary
	$Camera2D/Player_UI/SECONDARY.value = get_child(1).secondary
	$Camera2D/Player_UI/TURRET.value = get_child(1).turret
	for i in range($Camera2D/Sprite.get_child_count()):
		$Camera2D/Sprite.remove_child($Camera2D/Sprite.get_child(i))
	for i in range(get_parent().get_child_count()):
		mark.global_position.x = get_parent().get_child(i).get_child(1).global_position.x/9.11
		mark.global_position.y = get_parent().get_child(i).get_child(1).global_position.y/8.1
		$Camera2D/Sprite.add_child(mark)

func _physics_process(delta):
	if self.is_network_master():
		var ship = get_node("BaseShip")
		ship.set_target_position(get_global_mouse_position())

func _input(event):
	if not self.is_network_master():
		return
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down") 
	var ship = get_node("BaseShip")
	
	ship.set_input_vector(input_vector)
	
	ship.set_shooting(Input.get_action_strength("shoot"))
	ship.set_ability(Input.get_action_strength("ability"))
	ship.set_primary(Input.get_action_strength("primary_shoot"))
	ship.set_boarding(Input.get_action_strength("act_board"))
	
	

func set_player_name(new_name):
	$Camera2D.get_node("label").set_text(new_name)

func get_enemy():
	get_parent().get_node("EnemyController").get_child(0)
