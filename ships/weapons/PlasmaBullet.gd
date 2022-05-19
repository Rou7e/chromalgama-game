extends Area2D
class_name PlasmaBullet

var velocity = Vector2.ZERO;
var damage = 0;
var excludes = [];

func _ready():
	pass
	
func _physics_process(delta):
	global_position += velocity * delta
	velocity -= velocity.normalized() * delta * 100
	if velocity.length_squared() < 1:
		queue_free()


func _area_entered(area):
	if excludes.has(area):
		return
	if area.has_method("_receive_damage"):
		area._receive_damage(damage)
		queue_free()
		
