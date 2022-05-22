extends Area2D
class_name BaseShip

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200
export(float) var max_speed = 250

export(float) var primary_proj_speed = 12000
export(float) var primary_damage = 10

var cooling = 100
var primary = 100
var secondary = 4
var turret = 100
var crew = 4

const desc= 'HUMAN PROTECTORATE \nFRIGATE-CLASS\n CARGO SHIP'

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

func set_target_position(position):
	propagate_call("target", [position])

func _physics_process(delta):
	global_rotation_degrees += input_vector.x*turn_speed*delta
	speed_vector = speed_vector * inertia_factor + (Vector2(input_vector.y, 0)*acceleration*delta).rotated(global_rotation)
	global_position += speed_vector*delta
	
	if speed_vector.length() > max_speed:
		speed_vector = speed_vector.normalized() * max_speed
	
	if is_shooting and turret > 0 and overheat_turret==false:
		turret -= 1
		propagate_call("shoot", [[self]])
		if turret < 1:
			overheat_turret = true
	if turret == 100:
		overheat_turret = false

	
func _process(delta):
	if is_shooting_primary and overheat == false:
		if primary > 0:
			primary -= delta*30
			var bullet = PrimaryProjectile.instance()
			bullet.velocity = Vector2(primary_proj_speed, 0).rotated(global_rotation)
			bullet.global_position = global_position
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


func _receive_damage(amount):
	print("Damaged by ", amount)
	cooling-=10
	if cooling == 0:
		queue_free()
	#queue_free()


func _on_BaseShip_area_entered(area):

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
	pass # Replace with function body.
