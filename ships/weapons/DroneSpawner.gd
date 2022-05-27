extends BaseGun

class_name DroneSpawner

export(float) var bullet_speed = 0
export(float) var bullet_damage = 10

export var launched_ship = preload("res://ships/tellurian_ships/tel_t1.tscn")
var projectile = preload("res://ships/base_stuff/EnemyController.tscn")

func _ready():
	pass

func fire(excludes, subtick_time):
	var vel = Vector2(bullet_speed, 0).rotated(global_rotation)
	var pos = global_position + subtick_time * vel
	rpc("spawn_drone", pos, vel, excludes, bullet_damage)

remotesync func spawn_drone(position, velocity, excludes, damage):
	var drone = projectile.instance()
	drone.velocity = velocity
	drone.pos = global_position
	drone.rot = global_rotation
	drone.parent_id = get_parent().id
	drone.ship = launched_ship
	drone.set("target_position", target_position)
	get_parent().get_parent().get_parent().get_parent().get_node("NPCs").add_child(drone)
	
