extends Node2D

class_name Microwave

#const BULLET = preload("PlasmaBullet.tscn")

export(float) var bullet_speed = 1000
export(float) var bullet_damage = 10
export(float) var fire_rate = 240 #Rounds per minute
export(bool) var turnable = true

var is_shooting = false
var recharge_time = 0
var target_position = Vector2.ZERO
var shoot_time =0

func _ready():
#	$FusionGuardianWeapon/Area2D.disabled=true
	pass

func _physics_process(delta):
	if turnable:
		look_at(target_position)
	if recharge_time >= 0:
		recharge_time -= delta
	
	if shoot_time > 0.05:
		is_shooting = false
	
	if is_shooting:
		shoot_time+=delta

func target(position):
	target_position = position

func shoot(excludes):
	var time_per_shot = 60/fire_rate
	var times_fired_this_tick = 0
	is_shooting = true
	shoot_time = 0
	while recharge_time < 0:

		#var vel = Vector2(bullet_speed, 0).rotated(global_rotation)
		#var pos = global_position + times_fired_this_tick * time_per_shot * vel
		#rpc("spawn_bullet", pos, vel, excludes, bullet_damage)

		#var bullet = BULLET.instance()
		#bullet.velocity = Vector2(bullet_speed, 0).rotated(global_rotation)
		#bullet.global_position = global_position + times_fired_this_tick * time_per_shot * bullet.velocity
		#bullet.damage = bullet_damage
		#bullet.excludes = excludes
		#get_node("/root").add_child(bullet)
#		FusionGuardianWeapon/Area2D.disabled=false
		
		$FusionGuardianWeapon/Area2D/AnimatedSprite.set_frame(0)
		recharge_time += time_per_shot
		times_fired_this_tick += 1


		
#remotesync func spawn_bullet(position, velocity, excludes, damage):
	#var bullet = BULLET.instance()
	#bullet.velocity = velocity
	#bullet.global_position = position
	#bullet.damage = damage
	#bullet.excludes = excludes
	#get_node("/root").add_child(bullet)
	


func _on_Area2D_area_entered(area):
	
	if area==get_parent():
		return
	if area.has_method("receive_damage") and is_shooting:
		area.rpc("receive_damage", 0.1)
