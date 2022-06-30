extends Control

onready var menuTheme = load("res://resources/ui/menu_theme.tres")
onready var butScript = load("res://menus/encyclopediaButton.gd")
onready var imgUnknown = load("res://resources/encyclopedia/unknown.png")
onready var selScript = load("res://menus/enc_select_button.gd")

onready var imgTEL1 = load("res://resources/encyclopedia/tel1.png")
onready var imgTEL2 = load("res://resources/encyclopedia/tel2.png")
onready var imgTEL3 = load("res://resources/encyclopedia/tel3.png")
onready var imgTEL4 = load("res://resources/encyclopedia/tel4.png")
onready var imgTEL5 = load("res://resources/encyclopedia/tel5.png")
onready var imgTEL6 = load("res://resources/encyclopedia/tel6.png")
onready var imgTEL7 = load("res://resources/encyclopedia/tel7.png")

onready var imgSEL1 = load("res://resources/encyclopedia/sel11.png")
onready var imgSEL2 = load("res://resources/encyclopedia/sel22.png")
onready var imgSEL3 = load("res://resources/encyclopedia/sel33.png")
onready var imgSEL4 = load("res://resources/encyclopedia/sel44.png")
onready var imgSEL5 = load("res://resources/encyclopedia/sel55.png")
onready var imgSEL6 = load("res://resources/encyclopedia/sel66.png")
onready var imgSEL7 = load("res://resources/encyclopedia/sel77.png")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	showMenu()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func showMenu():
	for i in $EntriesListing.get_children():
		i.queue_free()
	var button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "ENC1"
	button.sw = 1
	$EntriesListing.add_child(button)
	button = Button.new()

	button.theme = menuTheme
	button.text = "ENC2"

	$EntriesListing.add_child(button)
	button = Button.new()

	button.theme = menuTheme
	button.text = "ENC3"

	$EntriesListing.add_child(button)
	button = Button.new()

	button.theme = menuTheme
	button.text = "ENC4"

	$EntriesListing.add_child(button)
	button = Button.new()

	button.theme = menuTheme
	button.text = "ENC5"

	$EntriesListing.add_child(button)

func showShips():
	for i in $EntriesListing.get_children():
		i.queue_free()
	var button = Button.new()
	button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "<="
	button.sw = 0
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T1"
	button.title = TranslationServer.translate("TEL1")
	button.quote = TranslationServer.translate('TEL1QUOTE')
	button.paragraph = TranslationServer.translate("TEL1TEXT")
	button.image = imgTEL1
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T2"
	button.title = TranslationServer.translate("TEL2")
	button.quote = TranslationServer.translate('TEL2QUOTE')
	button.paragraph = TranslationServer.translate("TEL2TEXT")
	button.image = imgTEL2
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T3"
	button.title = TranslationServer.translate("TEL3")
	button.quote = TranslationServer.translate('TEL3QUOTE')
	button.paragraph = TranslationServer.translate("TEL3TEXT")
	button.image = imgTEL3
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T4"
	button.title = TranslationServer.translate("TEL4")
	button.quote = TranslationServer.translate('TEL4QUOTE')
	button.paragraph = TranslationServer.translate("TEL4TEXT")
	button.image = imgTEL4
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T5"
	button.title = TranslationServer.translate("TEL5")
	button.quote = TranslationServer.translate('TEL5QUOTE')
	button.paragraph = TranslationServer.translate("TEL5TEXT")
	button.image = imgTEL5
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T6"
	button.title = TranslationServer.translate("TEL6")
	button.quote = TranslationServer.translate('TEL6QUOTE')
	button.paragraph = TranslationServer.translate("TEL6TEXT")
	button.image = imgTEL6
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL T7"
	button.title = TranslationServer.translate("TEL7")
	button.quote = TranslationServer.translate('TEL7QUOTE')
	button.paragraph = TranslationServer.translate("TEL7TEXT")
	button.image = imgTEL7
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T1"
	button.title = TranslationServer.translate("SEL1")
	button.quote = TranslationServer.translate('SEL1QUOTE')
	button.paragraph = TranslationServer.translate("SEL1TEXT")
	button.image = imgSEL1
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T2"
	button.title = TranslationServer.translate("SEL2")
	button.quote = TranslationServer.translate('SEL2QUOTE')
	button.paragraph = TranslationServer.translate("SEL2TEXT")
	button.image = imgSEL2
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T3"
	button.title = TranslationServer.translate("SEL3")
	button.quote = TranslationServer.translate('SEL3QUOTE')
	button.paragraph = TranslationServer.translate("SEL3TEXT")
	button.image = imgSEL3
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T4"
	button.title = TranslationServer.translate("SEL4")
	button.quote = TranslationServer.translate('SEL4QUOTE')
	button.paragraph = TranslationServer.translate("SEL4TEXT")
	button.image = imgSEL4
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T5"
	button.title = TranslationServer.translate("SEL5")
	button.quote = TranslationServer.translate('SEL5QUOTE')
	button.paragraph = TranslationServer.translate("SEL5TEXT")
	button.image = imgSEL5
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T6"
	button.title = TranslationServer.translate("SEL6")
	button.quote = TranslationServer.translate('SEL6QUOTE')
	button.paragraph = TranslationServer.translate("SEL6TEXT")
	button.image = imgSEL6
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL T7"
	button.title = TranslationServer.translate("SEL7")
	button.quote = TranslationServer.translate('SEL7QUOTE')
	button.paragraph = TranslationServer.translate("SEL7TEXT")
	button.image = imgSEL7
	$EntriesListing.add_child(button)
	

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene("res://MainMenu.tscn")
