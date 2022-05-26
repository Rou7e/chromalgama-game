extends BaseGun

class_name MRP

export(float) var bullet_speed = 1000
export(float) var bullet_damage = 10

export var projectile = preload("res://ships/weapons/projectiles/MRP_shot.tscn")

func _ready():
	pass

func fire(excludes, subtick_time):
	var vel = Vector2(bullet_speed, 0).rotated(global_rotation)
	var pos = global_position + subtick_time * vel
	rpc("spawn_bullet", pos, vel, excludes, bullet_damage)

remotesync func spawn_bullet(position, velocity, excludes, damage):
	var bullet = projectile.instance()
	bullet.velocity = velocity
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.damage = damage
	bullet.excludes = excludes
	bullet.set("target_position", target_position)
	get_node("/root").add_child(bullet)
	
