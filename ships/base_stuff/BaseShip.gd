extends Area2D
class_name BaseShip

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200
export(float) var max_speed = 250

var cooling = 100
var primary = 100
var secondary = 100
var turret = 100
var crew = 4

const desc= 'HUMAN PROTECTORATE \nFRIGATE-CLASS\n CARGO SHIP'

const PrimaryProjectile = preload("res://ships/weapons/PlasmaBullet.tscn")
const Drone = preload("res://playerSummons/T2BattleDrone.tscn")
var overheat = false
var secondary_cd = 5

var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO

var is_shooting = false
var is_shooting_primary = false
var using_ability = false
var is_boarding

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
	
	if is_shooting:
		propagate_call("shoot", [[self]])
		
func _process(delta):
	if is_shooting_primary and overheat == false:
		if primary > 0:
			primary -= delta*30
			var plasmaball = PrimaryProjectile.instance()
			plasmaball.global_position = self.global_position
			get_parent().add_child(plasmaball)
		else:
			primary += delta*10
			overheat = true
	else:
		primary += delta*10
		#$UVBeam.visible = false
	
	if primary == 100:
		overheat=false

	if using_ability==true and secondary > 0 and secondary_cd>5:
		secondary -= 1
		secondary_cd = 0
		var drone = Drone.instance()
		drone.global_position = self.global_position
		get_parent().add_child(drone)
	else:
		secondary_cd += delta
		


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
