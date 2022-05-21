extends Node2D

var input_vector = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D/Player_UI/HEAT.max_value = $BaseShip.cooling
	$Camera2D/Player_UI/CREW.max_value = $BaseShip.crew
	$Camera2D/Player_UI/PRIMARY.max_value = $BaseShip.primary
	$Camera2D/Player_UI/SECONDARY.max_value = $BaseShip.secondary
	$Camera2D/Player_UI/TURRET.max_value = $BaseShip.turret
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.global_position = $BaseShip.global_position
	$Camera2D/Player_UI/HEAT.value = $BaseShip.cooling
	$Camera2D/Player_UI/CREW.value = $BaseShip.crew
	$Camera2D/Player_UI/PRIMARY.value = $BaseShip.primary
	$Camera2D/Player_UI/SECONDARY.value = $BaseShip.secondary
	$Camera2D/Player_UI/TURRET.value = $BaseShip.turret

func _input(event):
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down") 
	var ship = get_node("BaseShip")
	
	ship.set_input_vector(input_vector)
	
	ship.set_shooting(Input.get_action_strength("shoot"))
	ship.set_target_position(get_global_mouse_position())

func set_player_name(new_name):
	$Camera2D.get_node("label").set_text(new_name)

func get_enemy():
	get_parent().get_node("EnemyController").get_child(0)
