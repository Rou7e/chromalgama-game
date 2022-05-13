extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = 15
var turn_speed = 5
var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	#speed_vector.x = 0
	#speed_vector.y = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	#input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#speed_vector.x = speed_vector.x-sin(global_rotation)*input_vector.y*acceleration
	#speed_vector.y = speed_vector.y+cos(global_rotation)*input_vector.y*acceleration
	#global_rotation_degrees += input_vector.x*turn_speed
	#global_position += speed_vector*delta
	pass
