extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = 15
var turn_speed = 5
var shoot = false
var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO
var Drone = preload("res://playerSummons/T2BattleDrone.tscn")
var Plasmaball = preload("res://projectiles/PROJECTILE_PLASMA.tscn")
var primary_cd = 5
var secondary_cd = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	speed_vector.x = 0
	speed_vector.y = 0
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.global_rotation = 0
	
	if Input.get_action_strength("shoot")==1 and $Camera2D/VBoxContainer/PRIMARY.value > 0 and primary_cd>5:
		$Camera2D/VBoxContainer/PRIMARY.value -= 10
		primary_cd = 0
		var plasmaball = Plasmaball.instance()
		plasmaball.global_position = self.global_position
		get_parent().add_child(plasmaball)
	else:
		primary_cd += delta
		$Camera2D/VBoxContainer/PRIMARY.value += 1
	
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
	speed_vector.x = speed_vector.x-sin(global_rotation)*input_vector.y*acceleration
	speed_vector.y = speed_vector.y+cos(global_rotation)*input_vector.y*acceleration
	global_rotation_degrees += input_vector.x*turn_speed
	global_position += speed_vector*delta
	
