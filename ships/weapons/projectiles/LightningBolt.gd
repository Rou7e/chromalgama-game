extends Area2D
class_name LightningBolt

var velocity = Vector2.ZERO;
var damage = 1;
var time_to_live = 0.5
var excludes = [];

func _ready():
	pass
	
func _physics_process(delta):
	#global_position += get_parent().global_position
	time_to_live -= delta
	if time_to_live < 0:
		queue_free()


func _area_entered(area):
	if excludes.has(area.get("id")):
		return
	if area.has_method("receive_damage"):
		area.rpc("receive_damage", damage)
		