extends Area2D
class_name BaseShip

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200
export(float) var max_speed = 750

const LOCATION_SIZE = 10000

export(float) var cooling = 100
var max_cooling = cooling

export var desc = 'FREE CONVENTION \nFIGHTER-CLASS\n DRONE T1'

var is_active = {
	"primary": false,
	"secondary": false,
	"ability": false,
}

var explosion = preload("res://ships/weapons/projectiles/ExplosionArea.tscn")
export var exhaust = preload("res://projectiles/selenite_exhaust.tscn")

class ChargeState:
	var charge = 100
	var overheat = false

var charge_states = {}


var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO

var id = "_no_id"

func _ready():
	max_cooling = cooling
	set_network_master(get_parent().get_network_master())
	for key in is_active.keys():
		charge_states[key] = ChargeState.new()
	max_cooling = cooling

func set_input_vector(vector):

	input_vector = vector

func set_shooting(val):
	is_active["secondary"] = val
func set_ability(val):
	is_active["ability"] = val
func set_primary(val):
	is_active["primary"] = val

var target_position = Vector2.ZERO

func set_target_position(position):
	target_position = position

func _physics_process(delta):
	
	if input_vector.y > 0:
		if get_parent().get_child(0).get_node("EngineSound").playing == false:
			get_parent().get_child(0).get_node("EngineSound").play()
		for i in $Engines.get_children():
			var exhaust_entity = exhaust.instance()
			i.animation="running"
			exhaust_entity.scale=i.scale
			exhaust_entity.global_position=i.global_position
			exhaust_entity.offset = i.offset
			exhaust_entity.global_rotation = i.global_rotation
			
			get_node("/root").add_child(exhaust_entity)
	else:
		get_parent().get_child(0).get_node("EngineSound").stop()
		for i in $Engines.get_children():
			i.animation="stopped"
	
	if input_vector.y < 0:
		if get_parent().get_child(0).get_node("ThrusterSound").playing == false:
			get_parent().get_child(0).get_node("ThrusterSound").play()
		for i in $BackThrusters.get_children():
			i.animation="running"
	else:
		get_parent().get_child(0).get_node("ThrusterSound").stop()
		for i in $BackThrusters.get_children():
			i.animation="default"
			
	if input_vector.x < 0:
		if get_parent().get_child(0).get_node("ThrusterSound2").playing == false:
			get_parent().get_child(0).get_node("ThrusterSound2").play()
		for i in $LeftThrusters.get_children():
			i.animation="running"
	else:
		get_parent().get_child(0).get_node("ThrusterSound2").stop()
		for i in $LeftThrusters.get_children():
			i.animation="default"
			
	if input_vector.x > 0:
		if get_parent().get_child(0).get_node("ThrusterSound3").playing == false:
			get_parent().get_child(0).get_node("ThrusterSound3").play()
		for i in $RightThrusters.get_children():
			i.animation="running"
	else:
		get_parent().get_child(0).get_node("ThrusterSound3").stop()
		for i in $RightThrusters.get_children():
			i.animation="default"
			
	propagate_call("target", [target_position])
	
	global_rotation_degrees += input_vector.x*turn_speed*delta
	speed_vector = speed_vector * inertia_factor + (Vector2(input_vector.y, 0)*acceleration*delta).rotated(global_rotation)
	var radi = global_position.length()
	if radi > LOCATION_SIZE:
		speed_vector -= global_position.normalized() * (radi-LOCATION_SIZE)
	global_position += speed_vector*delta
	
	if speed_vector.length() > max_speed:
		speed_vector = speed_vector.normalized() * max_speed
	
	for key in is_active.keys():
		if is_active[key]:
			propagate_call("shoot", [key, charge_states[key], [id]])
	
	for key in is_active.keys():
		if key != "ability":
			charge_states[key].charge = min(100, charge_states[key].charge + delta * 10)
			if charge_states[key].charge >= 100:
				charge_states[key].overheat = false
	
	if self.is_network_master():
		send_sync_info()
	


remotesync func receive_damage(amount):
	cooling -= amount
	if get_parent().get_child(0).get_node("DamageDealt").playing == false:
		get_parent().get_child(0).get_node("DamageDealt").play()
	get_parent().get_child(0).get_node("DamageDealt").stream.loop = false
	if cooling <= 0:
		var explosion_mrp = explosion.instance()
		var winner = ""
		explosion_mrp.get_node("AnimatedSprite").scale = $ShipCargo.scale*10
		explosion_mrp.global_position=global_position
		get_node("/root").add_child(explosion_mrp)
		#if get_parent().get_parent().get_parent().get_node("NPCs").get_child_count()==0 and get_parent().get_parent().get_parent().get_node("Players").get_child_count()==1:
		#	winner = get_parent().get_parent().get_parent().get_node("Players").get_child(0).name
		#	get_parent().get_parent().get_parent().get_node("Players").get_child(0).rpc("game_over", winner)
		#if get_parent().get_parent().get_child_count() <= 2 and get_parent().get_parent().name=="Players":
		#	#get_parent().get_parent().get_parent().get_node("GameOverMenu").visible = true
		#	
		#	for i in range(get_parent().get_parent().get_child_count()):
		#		if get_parent().get_player_name() != get_parent().get_parent().get_child(i).get_player_name():
		#			winner = get_parent().get_parent().get_child(i).get_player_name()
		get_parent().get_child(0).get_node("EngineSound").stop()
		get_parent().get_child(0).get_node("ThrusterSound").stop()
		get_parent().get_child(0).get_node("ThrusterSound2").stop()
		get_parent().get_child(0).get_node("ThrusterSound3").stop()
		get_parent().get_child(0).get_node("DamageDealt").stop()
		
		queue_free()

func _on_BaseShip_area_entered(area):
	return
	if area.name == "Area2D":
		speed_vector.y=0
		speed_vector.x=100
	if area.name == "Area2D3":
		speed_vector.y=0
		speed_vector.x=-100
	if area.name == "Area2D4":
		speed_vector.y=-100
		speed_vector.x=0
	if area.name == "Area2D2":
		speed_vector.y=100
		speed_vector.x=0

func send_sync_info():
	rpc_unreliable("recv_sync_info", global_position, global_rotation, speed_vector, target_position)

# warning-ignore:shadowed_variable
puppet func recv_sync_info(position, rotation, velocity, target_position):
	global_position = position
	global_rotation = rotation
	speed_vector = velocity
	set_target_position(target_position)
	
	
