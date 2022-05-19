extends Area2D
class_name BaseShip

export(float) var inertia_factor = 1.0
export(float) var turn_speed = 90
export(float) var acceleration = 200

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
	
	if is_shooting:
		propagate_call("shoot", [[self]])

func _receive_damage(amount):
	print("Damaged by ", amount)
	queue_free()
