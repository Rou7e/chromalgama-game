extends Area2D
class_name BaseShip

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200
export(float) var max_speed = 250

var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO

var is_shooting = false

func _ready():
	pass

func set_input_vector(vector):
	input_vector = vector
	
func set_shooting(val):
	is_shooting = val

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
		


func _on_collision(value):
	var collider = value
	print(collider)

	#Then your else if ladder

func _receive_damage(amount):
	print("Damaged by ", amount)
	queue_free()


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
