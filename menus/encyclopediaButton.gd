extends Button

var title
var quote
var paragraph
var image

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _pressed():

	get_parent().get_parent().get_node("RichTextLabel2").text = title
	get_parent().get_parent().get_node("RichTextLabel3").text = quote
	get_parent().get_parent().get_node("RichTextLabel").text = paragraph
	get_parent().get_parent().get_node("Mrp").texture = image
