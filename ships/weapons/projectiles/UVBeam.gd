extends Area2D
class_name UVBeam

var velocity = Vector2.ZERO;
var damage = 10;
var time_to_live = 1
var excludes = [];

func _ready():
	pass
	
func _physics_process(delta):
	global_position += velocity*delta
	time_to_live -= delta
	if time_to_live < 0:
		queue_free()


func _area_entered(area):
	if excludes.has(area.get("id")):
		return
	if area.has_method("receive_damage"):
		area.rpc("receive_damage", damage)
		
