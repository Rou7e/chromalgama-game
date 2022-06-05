extends Area2D
class_name UVBeam

var velocity = Vector2.ZERO;
var damage = 0;
var time_to_live = 0.1
var excludes = [];
var parent

func _ready():
	pass
	
func _physics_process(delta):
	if is_instance_valid(parent):
		global_position = parent.global_position
	time_to_live -= delta
	if time_to_live < 0:
		queue_free()


func _area_entered(area):
	if excludes.has(area.get("id")):
		return
	if area.has_method("receive_damage"):
		area.rpc("receive_damage", damage)
		
