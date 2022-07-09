extends Node2D
var input_vector = Vector2.ZERO
var ship
var parent_id
var velocity
var pos
var rot
var target
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var explosion = preload("res://ships/weapons/projectiles/ExplosionArea.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var vessel=ship.instance()
	vessel.global_position = pos
	vessel.global_rotation = rot
	vessel.speed_vector = velocity
	add_child(vessel)
	if is_instance_valid(ship)==false:
		return
	
	if is_instance_valid(target)==false:
		if get_parent().get_parent().get_node("Players").get_child_count() > 1:
			for i in range(get_parent().get_parent().get_node("Players").get_child_count()):
				if is_instance_valid(get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip")):
					if get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip").id != parent_id:
						target = get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip")
		elif get_parent().get_parent().get_node("NPCs").get_child_count() > 1:
			for i in range(get_parent().get_parent().get_node("NPCs").get_child_count()):
				if is_instance_valid(get_parent().get_parent().get_node("NPCs").get_child(i).get_node("BaseShip")):
					if get_parent().get_parent().get_node("NPCs").get_child(i).get_node("BaseShip").id != parent_id and get_parent().get_parent().get_node("NPCs").get_child(i).parent_id != parent_id:
						target = get_parent().get_parent().get_node("NPCs").get_child(i).get_node("BaseShip")
		return
func _physics_process(delta):
	var ship = get_node("BaseShip")
	if is_instance_valid(ship)==false:
		queue_free()
		return
	if is_instance_valid(target)==false:
		return
	ship.set_target_position(target.global_position)
	#var path_to_enemy = target.global_position - ship.global_position
	
	if ship.get_angle_to(target.global_position) < 0:
		input_vector.x=-1
	if ship.get_angle_to(target.global_position) > 0:
		input_vector.x=1
	input_vector.y=1
	if ship.global_position.distance_to(target.global_position) < 100:
		var explosion_mrp = explosion.instance()
		explosion_mrp.damage=4
		explosion_mrp.excludes.append(parent_id)
		explosion_mrp.global_position=ship.global_position
		get_node("/root").add_child(explosion_mrp)
		queue_free()

	
	ship.set_input_vector(input_vector)
	
	#ship.set_shooting(Input.get_action_strength("shoot"))
	#ship.set_ability(Input.get_action_strength("ability"))
	#ship.set_primary(Input.get_action_strength("primary_shoot"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
