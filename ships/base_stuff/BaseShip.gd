extends Area2D
class_name BaseShip

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200
export(float) var max_speed = 750

const LOCATION_SIZE = 10000

var cooling = 100

export var desc = 'FREE CONVENTION \nFIGHTER-CLASS\n DRONE T1'

var is_active = {
	"primary": false,
	"secondary": false,
	"ability": false,
}

class ChargeState:
	var charge = 100
	var overheat = 0

var charge_states = {}


var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO

var id = "_no_id"

func _ready():
	set_network_master(get_parent().get_network_master())
	for key in is_active.keys():
		charge_states[key] = ChargeState.new()

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
		for i in $Engines.get_children():
			i.animation="running"
	else:
		for i in $Engines.get_children():
			i.animation="stopped"
	
	if input_vector.y < 0:
		for i in $BackThrusters.get_children():
			i.animation="running"
	else:
		for i in $BackThrusters.get_children():
			i.animation="default"
			
	if input_vector.x < 0:
		for i in $LeftThrusters.get_children():
			i.animation="running"
	else:
		for i in $LeftThrusters.get_children():
			i.animation="default"
			
	if input_vector.x > 0:
		for i in $RightThrusters.get_children():
			i.animation="running"
	else:
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
		charge_states[key].charge = min(100, charge_states[key].charge + delta * 10)
	
	if self.is_network_master():
		send_sync_info()
	


remotesync func receive_damage(amount):
	cooling -= amount
	#if cooling <= 0:
	#	queue_free()
	#queue_free()

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
	
	
