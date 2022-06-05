extends BaseGun

class_name DroneSpawner

export(float) var bullet_speed = 0
export(float) var bullet_damage = 10

export var launched_ship = preload("res://ships/tellurian_ships/tel_t1.tscn")
var projectile = preload("res://ships/base_stuff/EnemyController.tscn")

func _ready():
	pass

func fire(excludes, subtick_time):
	if get_parent().get_node("ShipCargo2") is AnimatedSprite:
		if get_parent().get_node("ShipCargo2").frames.get_frame_count("default") != get_parent().get_node("ShipCargo2").frame:
			get_parent().get_node("ShipCargo2").frame = get_parent().get_node("ShipCargo2").frame+1
	var vel = Vector2(bullet_speed, 0).rotated(global_rotation)
	var pos = global_position + subtick_time * vel
	$AudioStreamPlayer2D.play(0)
	$AudioStreamPlayer2D.stream.loop = false
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
	
