extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var acceleration = 15
var turn_speed = 10
var speed_vector = Vector2.ZERO
var input_vector = Vector2.ZERO
var primary_cd = 10

var Drone = preload("res://playerSummons/T2BattleDrone.tscn")
var Plasmaball = preload("res://projectiles/PROJECTILE_PLASMA.tscn")
onready var player = get_parent().get_child(3)

# Called when the node enters the scene tree for the first time.
func _ready():
	speed_vector.x = 0
	speed_vector.y = 0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_speed=get_parent().get_child(3).speed_vector.length()
	#$RayCastLeft.move_local_x()
	#$RayCastRight.move_local_x()
	if $RayCastLeft.get_collider() == get_parent().get_child(3) or $RayCastRight.get_collider() == get_parent().get_child(3):
		#$Camera2D/VBoxContainer/PRIMARY.value -= 10
		if get_parent().get_child(3).get_child(2).get_child(1).get_child(4).value > 10 and primary_cd > 10:
			primary_cd = 0
			get_parent().get_child(3).get_child(2).get_child(1).get_child(4).value -= 10
			var plasmaball = Plasmaball.instance()
			plasmaball.global_position = self.global_position
			get_parent().add_child(plasmaball)
	primary_cd+=delta
	player.get_child(2).get_child(1).get_child(4).value+=1
	
func _physics_process(delta):
	#input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	speed_vector.x = speed_vector.x-sin(global_rotation)*input_vector.y*acceleration
	speed_vector.y = speed_vector.y+cos(global_rotation)*input_vector.y*acceleration
	global_rotation_degrees += input_vector.x*turn_speed
	global_position += speed_vector*delta
