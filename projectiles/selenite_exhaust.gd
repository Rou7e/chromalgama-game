extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(0).frame=0
	get_child(0).play()
	get_child(0).offset = self.offset/10
	self.offset = Vector2(0,0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child(0).frame==3:
		self.queue_free()
