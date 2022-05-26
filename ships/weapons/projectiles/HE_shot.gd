extends PlasmaBullet
var target_position;
var explosion = preload("res://ships/weapons/projectiles/ExplosionArea.tscn")

func _physics_process(delta):
	._physics_process(delta)
	time_to_live+=delta
	#if time_to_live < delta:
		#$AnimatedSprite.animation="default"
		#get_parent().add_child(explosion_mrp)
		#queue_free()

		#while $AnimatedSprite.frame!=35:
		#	pass
		

func _ready():
	time_to_live = (global_position - target_position).length() / velocity.length()

func _area_entered(area):
	var explosion_mrp = explosion.instance()
	explosion_mrp.damage=damage
	explosion_mrp.excludes=excludes
	explosion_mrp.global_position=global_position
	if excludes.has(area.get("id")):
		return
	
	get_parent().add_child(explosion_mrp)
	queue_free()
