extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = 15
var turn_speed = 5
var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO
var Drone = preload("res://playerSummons/T2BattleDrone.tscn")
var overheat = false
var secondary_cd = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	speed_vector.x = 0
	speed_vector.y = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.global_rotation = 0
	if Input.get_action_strength("shoot")==1 and overheat == false:
		if $Camera2D/VBoxContainer/PRIMARY.value > 0:
			$Camera2D/VBoxContainer/PRIMARY.value -= delta*30
			$UVBeam.visible = true
		else:
			$Camera2D/VBoxContainer/PRIMARY.value += delta*10
			$UVBeam.visible = false
			overheat = true
	else:
		$Camera2D/VBoxContainer/PRIMARY.value += delta*10
		$UVBeam.visible = false
	
	if $Camera2D/VBoxContainer/PRIMARY.value == $Camera2D/VBoxContainer/PRIMARY.max_value:
		overheat=false

	if Input.get_action_strength("ability")==1 and $Camera2D/VBoxContainer/SECONDARY.value > 0 and secondary_cd>5:
		$Camera2D/VBoxContainer/SECONDARY.value -= 1
		secondary_cd = 0
		var drone = Drone.instance()
		drone.global_position = self.global_position
		get_parent().add_child(drone)
	else:
		secondary_cd += delta

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#speed_vector.x = speed_vector.x-sin(global_rotation)*input_vector.y*acceleration
	#speed_vector.y = speed_vector.y+cos(global_rotation)*input_vector.y*acceleration
	global_rotation_degrees += input_vector.x*turn_speed
	global_position.x -= sin(global_rotation)*input_vector.y*acceleration*delta*50
	global_position.y += cos(global_rotation)*input_vector.y*acceleration*delta*50
