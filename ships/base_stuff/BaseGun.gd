extends Node2D

class_name Plasmagun

export(String) var gun_group = "secondary"

export(float) var bullet_speed = 1000
export(float) var bullet_damage = 10
export(float) var fire_rate = 240 #Rounds per minute
export(float) var cost = 10
export(bool) var turnable = true

export var projectile = preload("projectiles/PlasmaBullet.tscn")

var recharge_time = 0
var target_position = Vector2.ZERO

func _ready():
#	$FusionGuardianWeapon/Area2D.disabled=true
	pass

func _physics_process(delta):
	if turnable:
		look_at(target_position)
	if recharge_time >= 0:
		recharge_time -= delta

func target(position):
	target_position = position

func shoot(req_gun_group, charge_state, excludes):
	if req_gun_group != gun_group:
		return
	var time_per_shot = 60/fire_rate
	var times_fired_this_tick = 0
	while recharge_time < 0 and charge_state.charge >= cost:
		var vel = Vector2(bullet_speed, 0).rotated(global_rotation)
		var pos = global_position + times_fired_this_tick * time_per_shot * vel
		rpc("spawn_bullet", pos, vel, excludes, bullet_damage)

		var bullet = projectile.instance()
		bullet.velocity = Vector2(bullet_speed, 0).rotated(global_rotation)
		bullet.global_position = global_position + times_fired_this_tick * time_per_shot * bullet.velocity
		bullet.damage = bullet_damage
		bullet.excludes = excludes
		get_node("/root").add_child(bullet)
#		FusionGuardianWeapon/Area2D.disabled=false
		#$FusionGuardianWeapon/Area2D/AnimatedSprite.visible=true

		recharge_time += time_per_shot
		times_fired_this_tick += 1
		charge_state.charge -= cost
		

remotesync func spawn_bullet(position, velocity, excludes, damage):
	var bullet = projectile.instance()
	bullet.velocity = velocity
	bullet.global_position = position
	bullet.damage = damage
	bullet.excludes = excludes
	get_node("/root").add_child(bullet)
	
