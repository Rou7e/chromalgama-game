extends Area2D


export(float) var inertia_factor = 1.0
export(float) var turn_speed = 10
export(float) var acceleration = 50

var speed_vector = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	global_rotation_degrees += input_vector.x*turn_speed
	speed_vector.x = speed_vector.x * inertia_factor - sin(global_rotation)*input_vector.y*acceleration
	speed_vector.y = speed_vector.y * inertia_factor + cos(global_rotation)*input_vector.y*acceleration
	global_position += speed_vector
