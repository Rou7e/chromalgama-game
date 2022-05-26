extends Area2D

var excludes=[]
var damage = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.frame=0
	for area in get_overlapping_areas():
		if excludes.has(area.get("id")):
			return
		if area.has_method("receive_damage"):
			area.rpc("receive_damage", damage)

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
