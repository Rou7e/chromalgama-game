extends Node2D

class_name Plasmagun

const BULLET = preload("PlasmaBullet.tscn")

export(float) var bullet_speed = 1000
export(float) var bullet_damage = 10
export(float) var fire_rate = 240 #Rounds per minute
export(bool) var turnable = true

var recharge_time = 0
var target_position = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	if turnable:
		look_at(target_position)
	if recharge_time >= 0:
		recharge_time -= delta

func target(position):
	target_position = position

func shoot(excludes):
	var time_per_shot = 60/fire_rate
	var times_fired_this_tick = 0
	while recharge_time < 0:
		var bullet = BULLET.instance()
		bullet.velocity = Vector2(bullet_speed, 0).rotated(global_rotation)
		bullet.global_position = global_position + times_fired_this_tick * time_per_shot * bullet.velocity
		bullet.damage = bullet_damage
		bullet.excludes = excludes
		get_node("/root").add_child(bullet)
		recharge_time += time_per_shot
		times_fired_this_tick += 1
