extends Area2D
class_name tel_t4

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200
export(float) var max_speed = 250

export(float) var primary_proj_speed = 12000
export(float) var primary_damage = 10

var cooling = 100
var primary = 100
var secondary = 2
var turret = 100
var crew = 4

const desc= 'FREE CONVENTION \nCORVETTE-CLASS\n REVENANT'

const PrimaryProjectile = preload("res://projectiles/UVBeam.tscn")
const Drone = preload("res://playerSummons/T2BattleDrone.tscn")
var overheat = false
var overheat_turret = false
var secondary_cd = 5

var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO

var is_shooting = 0
var is_shooting_primary = 0
var using_ability = 0
var is_boarding = 0

var id = "_no_id"

func _ready():
	pass

func set_input_vector(vector):
	input_vector = vector
	
func set_shooting(val):
	is_shooting = val
func set_ability(val):
	using_ability = val
func set_primary(val):
	is_shooting_primary = val
func set_boarding(val):
	is_boarding = val

var target_position = Vector2.ZERO

func set_target_position(position):
	target_position = position

func _physics_process(delta):
	propagate_call("target", [target_position])
	
	#global_rotation_degrees += input_vector.x*turn_speed*delta
	#speed_vector = speed_vector * inertia_factor + (Vector2(input_vector.y, 0)*acceleration*delta).rotated(global_rotation)
	global_rotation_degrees += input_vector.x*turn_speed*delta
	speed_vector.x = -cos(global_rotation)*input_vector.y*acceleration*50*delta
	speed_vector.y = sin(global_rotation)*input_vector.y*acceleration*50*delta
	global_position.x -= speed_vector.x*delta
	global_position.y += speed_vector.y*delta
	
	if speed_vector.length() > max_speed:
		speed_vector = speed_vector.normalized() * max_speed
	
	if is_shooting and turret > 0 and overheat_turret==false:
		turret -= 1
		propagate_call("shoot", [[id]])
		if turret < 1:
			overheat_turret = true
	if turret > 99:
		overheat_turret = false

	
func _process(delta):
	if is_shooting_primary and overheat == false:
		if primary > 0:
			primary -= delta*60
			var bullet = PrimaryProjectile.instance()
			bullet.velocity = Vector2(primary_proj_speed, 0).rotated(global_rotation)
			bullet.global_position.x = $BeamSpawn.global_position.x
			bullet.global_position.y = $BeamSpawn.global_position.y
			bullet.global_rotation = global_rotation
			bullet.damage = primary_damage
			bullet.excludes = [self]
			get_node("/root").add_child(bullet)
		else:
			if primary < 100:
				primary+= delta*10
			overheat = true
	else:
		if primary < 100:
			primary+= delta*10
		#$UVBeam.visible = false
	
	if primary > 99:
		overheat=false
	if primary < 100:
		primary+= delta*10
	
	if using_ability and secondary > 0 and secondary_cd>5:
		secondary -= 1
		secondary_cd = 0
		var drone = Drone.instance()
		drone.global_position = self.global_position
		get_node("/root").add_child(drone)
	else:
		secondary_cd += delta
	
	if turret < 100:
		turret+= delta*10
	if self.is_network_master():
		send_sync_info()


remotesync func receive_damage(amount):
	cooling-=10
	#if cooling == 0:
	#	queue_free()
	#queue_free()


func _on_BaseShip_area_entered(area):

	if area.name == "Area2D":
		speed_vector.y=0
		global_position.x+=10
	if area.name == "Area2D3":
		speed_vector.y=0
		global_position.x+=-10
	if area.name == "Area2D4":
		global_position.y+=-10
		speed_vector.x=0
	if area.name == "Area2D2":
		global_position.y+=10
		speed_vector.x=0
	pass # Replace with function body.

func send_sync_info():
	rpc_unreliable("recv_sync_info", global_position, global_rotation, speed_vector, target_position)

puppet func recv_sync_info(position, rotation, velocity, target_position):
	global_position = position
	global_rotation = rotation
	speed_vector = velocity
	set_target_position(target_position)
	
	
