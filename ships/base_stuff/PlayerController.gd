extends Node2D

var input_vector = Vector2.ZERO
const mark_friend = preload("res://projectiles/mark_friendly.tscn")
const mark_enemy = preload("res://projectiles/mark_enemy.tscn")
const mark_cursor = preload("res://projectiles/mark_cursor.tscn")
const cargo = preload("res://ships/selenite_ships/Cargo.tscn")
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


#const tel_t2 = preload("res://ships/tellurian_ships/tel_t2.tscn")

var selected_ship

# Called when the node enters the scene tree for the first time.
func _ready():
	var markf = mark_friend.instance()
	if selected_ship == 0:
		add_child(acl_t1.instance())

	elif selected_ship == 1:
		add_child(tel_t1.instance())
	elif selected_ship == 2:
		add_child(tel_t2.instance())
	elif selected_ship == 3:
		add_child(tel_t3.instance())
	elif selected_ship == 4:
		add_child(tel_t4.instance())
	elif selected_ship == 5:
		add_child(tel_t5.instance())
	elif selected_ship == 6:
		add_child(tel_t6.instance())
	elif selected_ship == 7:
		add_child(tel_t7.instance())

	elif selected_ship == 8:
		add_child(sel_t1.instance())
	elif selected_ship == 9:
		add_child(sel_t2.instance())
	elif selected_ship == 10:
		add_child(sel_t3.instance())
	elif selected_ship == 11:
		add_child(sel_t4.instance())
	elif selected_ship == 12:
		add_child(sel_t5.instance())
	elif selected_ship == 13:
		add_child(sel_t6.instance())
	elif selected_ship == 14:
		add_child(sel_t7.instance())

	else:
		add_child(cargo.instance())
	#if selected_ship == 2:
	#	add_child(tel_t2.instance())

	$Camera2D.zoom.x = 9*get_child(1).get_child(0).scale.x
	$Camera2D.zoom.y = 9*get_child(1).get_child(0).scale.y
	$Camera2D.scale.x = 9*get_child(1).get_child(0).scale.x
	$Camera2D.scale.y = 9*get_child(1).get_child(0).scale.y
	$Camera2D/Player_UI/Label5.text = $BaseShip.desc
	$Camera2D/Player_UI/HEAT.max_value = $BaseShip.cooling
	$Camera2D/Player_UI/PRIMARY.max_value = $BaseShip.charge_states["primary"].charge
	$Camera2D/Player_UI/TURRET.max_value = $BaseShip.charge_states["secondary"].charge
	$Camera2D/Player_UI/SECONDARY.max_value = $BaseShip.charge_states["ability"].charge

	if get_parent().get_child_count() > 1:
		for i in range(get_parent().get_child_count()):
			if get_parent().get_child(i) != self:
				$Camera2D/ENEMY_UI/Label5.text = get_parent().get_child(i).get_child(1).desc
				$Camera2D/ENEMY_UI/HEAT.max_value = get_parent().get_child(i).get_child(1).cooling
				$Camera2D/ENEMY_UI/PRIMARY.max_value = get_parent().get_child(i).get_child(1).charge_states["primary"].charge
				$Camera2D/ENEMY_UI/TURRET.max_value = get_parent().get_child(i).get_child(1).charge_states["secondary"].charge
				$Camera2D/ENEMY_UI/SECONDARY.max_value = get_parent().get_child(i).get_child(1).charge_states["ability"].charge
				markf.global_position = $Camera2D/Sprite4.rect_min_size/2
	$Camera2D.current = is_network_master()
	$Camera2D.visible = is_network_master()
	

	$BaseShip.id = "PC"+str(get_network_master())
	#mark.global_position.x = ($BaseShip.global_position.x-2300)/9.11
	#mark.global_position.y = ($BaseShip.global_position.y-1200)/8.1
	
	#for i in range(get_parent().get_child_count()):
	#	mark.global_position.x = (get_parent().get_child(i).$BaseShip.global_position.x+1200)/9.11
	#	mark.global_position.y = (get_parent().get_child(i).$BaseShip.global_position.y+2300)/8.1
	#	$Camera2D/Sprite.add_child(mark)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child_count() <= 1:
		return

	
	
	
	$Camera2D.global_position = $BaseShip.global_position
	
	$Camera2D/Player_UI/HEAT.value = $BaseShip.cooling
	#$Camera2D/Player_UI/CREW.value = $BaseShip.crew
	$Camera2D/Player_UI/PRIMARY.value = $BaseShip.charge_states["primary"].charge
	$Camera2D/Player_UI/TURRET.value = $BaseShip.charge_states["secondary"].charge
	$Camera2D/Player_UI/SECONDARY.value = $BaseShip.charge_states["ability"].charge
	
	if self.is_network_master():
		get_node("/root/world/bg").global_position = $BaseShip.global_position * (1 - 0.25)
	
	
	for child in $Camera2D/Sprite4.get_children():
		$Camera2D/Sprite4.remove_child(child)
	#mark.global_position.x = ($BaseShip.global_position.x-2300)/9.11
	#mark.global_position.y = ($BaseShip.global_position.y-1200)/8.1
	#$Camera2D/Sprite4.add_child(mark)

	#$Camera2D/Sprite4.add_child(mark)	
	var markf = mark_friend.instance()
	markf.global_position = $Camera2D/Sprite4.rect_size/2
	$Camera2D/Sprite4.add_child(markf)
		
	var markc = mark_cursor.instance()
	markc.global_position = $Camera2D/Sprite4.rect_size/2-($BaseShip.global_position-get_global_mouse_position())/($Camera2D.scale.x*10)
	$Camera2D/Sprite4.add_child(markc)
	
	if get_parent().get_child_count() > 1:
		for i in range(get_parent().get_child_count()):
			if get_parent().get_child(i) != self:
				var marke = mark_enemy.instance()
				marke.global_position = $Camera2D/Sprite4.rect_size/2-($BaseShip.global_position-get_parent().get_child(i).get_child(1).global_position)/($Camera2D.scale.x*10)
				if marke.global_position.x > $Camera2D/Sprite4.rect_size.x:
					marke.global_position.x = $Camera2D/Sprite4.rect_size.x-2
				if marke.global_position.y > $Camera2D/Sprite4.rect_size.y:
					marke.global_position.y = $Camera2D/Sprite4.rect_size.y-2
					
				if marke.global_position.x < 0:
					marke.global_position.x = 2
				if marke.global_position.y < 0:
					marke.global_position.y = 2
				$Camera2D/Sprite4.add_child(marke)
				$Camera2D/ENEMY_UI/Label5.text = get_parent().get_child(i).get_child(1).desc
				$Camera2D/ENEMY_UI/HEAT.value = get_parent().get_child(i).get_child(1).cooling
				$Camera2D/ENEMY_UI/PRIMARY.value = get_parent().get_child(i).get_child(1).charge_states["primary"].charge
				$Camera2D/ENEMY_UI/TURRET.value = get_parent().get_child(i).get_child(1).charge_states["secondary"].charge
				$Camera2D/ENEMY_UI/SECONDARY.value = get_parent().get_child(i).get_child(1).charge_states["ability"].charge
				#$Camera2D/Sprite4.add_child(mark)
	#for i in range(get_parent().get_child_count()):
	#	mark.global_position.x = (get_parent().get_child(i).get_child(1).global_position.x-2300)/9.11
	#	mark.global_position.y = (get_parent().get_child(i).get_child(1).global_position.y-1200)/8.1
	#	$Camera2D/Sprite.add_child(mark)

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
	#ship.set_boarding(Input.get_action_strength("act_board"))
	
	

func set_player_name(new_name):
	$Camera2D.get_node("label").set_text(new_name)

func get_player_name():
	return $Camera2D.get_node("label").text

func get_enemy():
	get_parent().get_node("EnemyController").get_child(0)
