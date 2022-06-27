extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sw = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _pressed():
	if sw == 0:
		get_parent().get_parent().showMenu()
	if sw == 1:
		get_parent().get_parent().showShips()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
