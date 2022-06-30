extends CanvasLayer

onready var buttoncontainer = get_node("Panel/VBoxContainer")
onready var buttonscript = load("res://menus/KeyButton.gd")
onready var menuTheme = load("res://resources/ui/menu_theme.tres")

onready var menuFont = load("res://resources/fonts/plain_text.tres")

var keybinds
var volumes
var buttons = {}
var key_labels = ["SET1","SET2","SET3","SET4","SET5","SET6","SET7","SET8","SET9","SET10"]
# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	keybinds = Global.keybinds.duplicate()
	volumes = Global.volumes.duplicate()
	
	$Panel/VBoxContainer2/HScrollBar.value=volumes["master"]
	$Panel/VBoxContainer2/HScrollBar2.value=volumes["music"]
	$Panel/VBoxContainer2/HScrollBar3.value=volumes["sfx"]
	
	for key in keybinds.keys():
		
		var hbox = HBoxContainer.new()
		var label = Label.new()
		var button = Button.new()
		
		hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		label.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		
		label.text = key_labels[i]
		
		var button_value = keybinds[key]
		
		if button_value != null:
			button.text = OS.get_scancode_string(button_value)
		else:
			button.text = "Unassigned"
		
		button.set_script(buttonscript)
		button.key = key
		button.value = button_value
		button.menu = self
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		button.theme = menuTheme
	
		label.theme=menuTheme
		label.set("custom_fonts/font", menuFont)
		hbox.add_child(label)
		hbox.add_child(button)
		buttoncontainer.add_child(hbox)
		i=i+1
		buttons[key] = button

func change_bind(key, value):
	keybinds[key] = value
	for k in keybinds.keys():
		if k != key and value != null and keybinds[k] == value:
			keybinds[k] = null
			buttons[k].value = null
			buttons[k].text = "Unassigned"


func back():
	get_tree().change_scene("res://MainMenu.tscn")


func save():
	Global.keybinds = keybinds.duplicate()
	Global.volumes = volumes.duplicate()
	Global.set_game_binds()
	Global.write_config()
	back()

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene("res://MainMenu.tscn")


func _on_HScrollBar_value_changed(value):
	volumes["master"]=$Panel/VBoxContainer2/HScrollBar.value
	Global.set_game_binds()

func _on_HScrollBar2_value_changed(value):
	volumes["music"]=$Panel/VBoxContainer2/HScrollBar2.value
	Global.set_game_binds()

func _on_HScrollBar3_value_changed(value):
	volumes["sfx"]=$Panel/VBoxContainer2/HScrollBar3.value
	Global.set_game_binds()

func _on_Button_pressed():
	Global.language = 0
	Global.set_game_binds()


func _on_Button2_pressed():
	Global.language = 1
	Global.set_game_binds()
