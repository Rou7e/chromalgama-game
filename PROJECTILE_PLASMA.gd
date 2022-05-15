extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rot

# Called when the node enters the scene tree for the first time.
func _ready():
	rot = get_parent().global_rotation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x -= sin(rot)*delta*1500
	global_position.y -= cos(rot)*delta*1500
