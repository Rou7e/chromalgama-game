extends Node2D

class_name BaseGun

export(String) var gun_group = "secondary"

export(float) var fire_rate = 240 #Rounds per minute
export(float) var cost = 10
export(bool) var turnable = true
export(float) var turn_speed = 1

var recharge_time = 0
var target_position = Vector2.ZERO
var faces_target = true

func target(position):
	target_position = position

func _ready():
	pass

func turn(delta):
	if turnable:
		var angle_delta = get_angle_to(target_position)
		rotate(min(abs(angle_delta), turn_speed*delta) * sign(angle_delta))
		faces_target = angle_delta < 1e-8

func _physics_process(delta):
	turn(delta)
	if recharge_time >= 0:
		recharge_time -= delta

func fire(excludes, subtick_time):
	pass

func shoot(req_gun_group, charge_state, excludes):
	if req_gun_group != gun_group:
		return
	if not faces_target:
		return
	var time_per_shot = 60/fire_rate
	var times_fired_this_tick = 0
	while recharge_time < 0 and charge_state.charge >= cost and charge_state.overheat == false:
		var subtick_time = times_fired_this_tick * time_per_shot
		fire(excludes, subtick_time)
		
#		FusionGuardianWeapon/Area2D.disabled=false
		#$FusionGuardianWeapon/Area2D/AnimatedSprite.visible=true

		recharge_time += time_per_shot
		times_fired_this_tick += 1
		charge_state.charge -= cost
		if charge_state.charge < cost:
			charge_state.overheat = true
