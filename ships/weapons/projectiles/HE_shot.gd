extends Area2D
var velocity = Vector2.ZERO;
var damage = 0;
var time_to_live = 10
var excludes = [];

var explosion = preload("res://ships/weapons/projectiles/ExplosionArea.tscn")

func _ready():
	pass
	
func _physics_process(delta):
	global_position += velocity * delta
	time_to_live -= delta
	if time_to_live < 0:
		queue_free()

		


func _on_ChargedBullet_area_entered(area):
	print("projectile collided!")
	if excludes.has(area.get("id")):
		return
	if area.has_method("receive_damage"):
		print("explosion spawned!")
		var explosion_mrp = explosion.instance()
		explosion_mrp.damage=damage
		explosion_mrp.get_node("AnimatedSprite").scale = 0.1*explosion_mrp.get_node("AnimatedSprite").scale
		explosion_mrp.get_node("CollisionShape2D").scale = 0.1*explosion_mrp.get_node("CollisionShape2D").scale
		explosion_mrp.excludes=excludes
		explosion_mrp.global_position=global_position
		get_parent().add_child(explosion_mrp)
		queue_free()
