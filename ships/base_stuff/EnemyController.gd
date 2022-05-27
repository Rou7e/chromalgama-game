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


# Called when the node enters the scene tree for the first time.
func _ready():
	var vessel=ship.instance()
	vessel.global_position = pos
	vessel.global_rotation = rot
	vessel.speed_vector = velocity
	add_child(vessel)
	if get_parent().get_parent().get_node("Players").get_child_count() > 1:
		for i in range(get_parent().get_parent().get_node("Players").get_child_count()):
			if get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip").id != parent_id:
				target = get_parent().get_parent().get_node("Players").get_child(i).get_node("BaseShip")

func _physics_process(delta):
	var ship = get_node("BaseShip")
	ship.set_target_position(target.global_position)
	#var path_to_enemy = target.global_position - ship.global_position
	
	if ship.get_angle_to(target.global_position) < ship.global_rotation:
		input_vector.x=-1
	if ship.get_angle_to(target.global_position) > ship.global_rotation:
		input_vector.x=1

	#if global_rotation+0.1 > path_to_enemy.angle() and path_to_enemy.angle() > global_rotation-0.1:
	#	if path_to_enemy.length() > 500:
	#		input_vector.y=1
	#	if path_to_enemy.length() < 500:
	#		input_vector.y=-1
		

	
	ship.set_input_vector(input_vector)
	
	#ship.set_shooting(Input.get_action_strength("shoot"))
	#ship.set_ability(Input.get_action_strength("ability"))
	#ship.set_primary(Input.get_action_strength("primary_shoot"))
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
