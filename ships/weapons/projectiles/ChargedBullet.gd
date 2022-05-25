extends PlasmaBullet
class_name ChargedBullet

var target_position;

func _physics_process(delta):
	._physics_process(delta)
	if time_to_live < delta:
		for area in $ExplosionArea.get_overlapping_areas():
			if area.has_method("receive_damage"):
				area.rpc("receive_damage", damage)
		queue_free()

func _ready():
	time_to_live = (global_position - target_position).length() / velocity.length()
