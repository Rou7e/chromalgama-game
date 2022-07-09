extends Node2D
var input_vector = Vector2.ZERO
var ship
var parent_id
var velocity
var pos
var rot
var target
var selected_ship



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if ship == null:
		if selected_ship == 0:
			#add_child(acl_t1.instance())
			add_child(gamestate.tel_t1.instance())
		elif selected_ship == 1:
			add_child(gamestate.tel_t1.instance())
		elif selected_ship == 2:
			add_child(gamestate.tel_t2.instance())
		elif selected_ship == 3:
			add_child(gamestate.tel_t3.instance())
		elif selected_ship == 4:
			add_child(gamestate.tel_t4.instance())
		elif selected_ship == 5:
			add_child(gamestate.tel_t5.instance())
		elif selected_ship == 6:
			add_child(gamestate.tel_t6.instance())
		elif selected_ship == 7:
			add_child(gamestate.tel_t7.instance())

		elif selected_ship == 8:
			add_child(gamestate.sel_t1.instance())
		elif selected_ship == 9:
			add_child(gamestate.sel_t2.instance())
		elif selected_ship == 10:
			add_child(gamestate.sel_t3.instance())
		elif selected_ship == 11:
			add_child(gamestate.sel_t4.instance())
		elif selected_ship == 12:
			add_child(gamestate.sel_t5.instance())
		elif selected_ship == 13:
			add_child(gamestate.sel_t6.instance())
		elif selected_ship == 14:
			add_child(gamestate.sel_t7.instance())
	
		else:
			add_child(gamestate.tel_t1.instance())
	else:
		var vessel=ship.instance()
		vessel.global_position = pos
		vessel.global_rotation = rot
		vessel.speed_vector = velocity
		add_child(vessel)
	if get_parent().get_parent().get_node("Players").get_child_count() >= 1:
		for i in range(get_parent().get_parent().get_node("Players").get_child_count()):
			if get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip").id != parent_id:
				target = get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip")

func _physics_process(delta):
	var ship = get_node("BaseShip")
	if is_instance_valid(ship)==false:
		for i in get_parent().get_parent().get_node("Players").get_children():
			i.rpc("make_score")
		queue_free()
		return
	
	if is_instance_valid(target)==false:
		if get_parent().get_parent().get_node("Players").get_child_count() > 1:
			for i in range(get_parent().get_parent().get_node("Players").get_child_count()):
				if is_instance_valid(get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip")):
					if get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip").id != parent_id:
						target = get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip")
		else:
			if get_parent().get_parent().get_node("NPCs").get_child_count() > 0:
				for i in range(get_parent().get_parent().get_node("NPCs").get_child_count()):
						if is_instance_valid(get_parent().get_parent().get_node("NPCs").get_child(i).get_node("BaseShip")) and is_instance_valid(get_node("BaseShip")):
							if get_parent().get_parent().get_node("NPCs").get_child(i).parent_id != parent_id:
								target = get_parent().get_parent().get_node("NPCs").get_child(i).get_node("BaseShip")
		return
		
	ship.set_target_position(target.global_position)
	#var path_to_enemy = target.global_position - ship.global_position
	
	if ship.get_angle_to(target.global_position) < 0:
		input_vector.x=-1
	if ship.get_angle_to(target.global_position) > 0:
		input_vector.x=1

	if ship.get_angle_to(target.global_position) < 0.1 and ship.get_angle_to(target.global_position) > -0.1:
		if ship.global_position.distance_to(target.global_position) > 5000*ship.get_node("ShipCargo").scale.x:
			input_vector.y=1
		if ship.global_position.distance_to(target.global_position) < 5000*ship.get_node("ShipCargo").scale.x:
			input_vector.y=-1
			ship.set_primary(1)
			ship.set_ability(1)
			ship.set_shooting(1)
		
	ship.set_input_vector(input_vector)
	
