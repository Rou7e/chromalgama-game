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

onready var imgWEP1 = load("res://resources/encyclopedia/wep1.png")
onready var imgWEP2 = load("res://resources/encyclopedia/wep2.png")
onready var imgWEP3 = load("res://resources/encyclopedia/wep3.png")
onready var imgWEP4 = load("res://resources/encyclopedia/wep4.png")
onready var imgWEP5 = load("res://resources/encyclopedia/wep5.png")
onready var imgWEP6 = load("res://resources/encyclopedia/wep6.png")
onready var imgWEP7 = load("res://resources/encyclopedia/wep7.png")
onready var imgWEP8 = load("res://resources/encyclopedia/wep8.png")
onready var imgWEP9 = load("res://resources/encyclopedia/wep9.png")
onready var imgWEP10 = load("res://resources/encyclopedia/wep10.png")
onready var imgWEP11 = load("res://resources/encyclopedia/wep11.png")
onready var imgWEP12 = load("res://resources/encyclopedia/wep12.png")
onready var imgWEP13 = load("res://resources/encyclopedia/wep13.png")
onready var imgWEP14 = load("res://resources/encyclopedia/wep14.png")

onready var imgPLA1 = load("res://resources/encyclopedia/pla1.png")
onready var imgPLA2 = load("res://resources/encyclopedia/pla2.png")
onready var imgPLA3 = load("res://resources/encyclopedia/pla3.png")
onready var imgPLA4 = load("res://resources/encyclopedia/pla4.png")
onready var imgPLA5 = load("res://resources/encyclopedia/pla5.png")
onready var imgPLA6 = load("res://resources/encyclopedia/pla6.png")
onready var imgPLA7 = load("res://resources/encyclopedia/pla7.png")
onready var imgPLA8 = load("res://resources/encyclopedia/pla8.png")
onready var imgPLA9 = load("res://resources/encyclopedia/pla9.png")
onready var imgPLA10 = load("res://resources/encyclopedia/pla10.png")
onready var imgPLA11 = load("res://resources/encyclopedia/pla11.png")
onready var imgPLA12 = load("res://resources/encyclopedia/pla12.png")
onready var imgPLA13 = load("res://resources/encyclopedia/pla13.png")

onready var imgFAC1 = load("res://resources/encyclopedia/fac1.png")
onready var imgFAC2 = load("res://resources/encyclopedia/fac2.png")
onready var imgFAC3 = load("res://resources/encyclopedia/fac3.png")
onready var imgFAC4 = load("res://resources/encyclopedia/fac4.png")

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
	button.set_script(selScript)
	
	button.theme = menuTheme
	button.text = "ENC2"
	button.sw = 2
	$EntriesListing.add_child(button)
	#button = Button.new()

	#button.theme = menuTheme
	#button.text = "ENC3"
	#button.sw = 3
	#$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "ENC4"
	button.sw = 4
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "ENC5"
	button.sw = 5
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
	
func showWeapons():
	for i in $EntriesListing.get_children():
		i.queue_free()
	var button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "<="
	button.sw = 0
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL OSC"
	button.title = TranslationServer.translate("WEP1")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP1DESC")
	button.image = imgWEP1
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP2")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP2DESC")
	button.image = imgWEP2
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP3")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP3DESC")
	button.image = imgWEP3
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP4")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP4DESC")
	button.image = imgWEP4
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP5")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP5DESC")
	button.image = imgWEP5
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP6")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP6DESC")
	button.image = imgWEP6
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP7")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP7DESC")
	button.image = imgWEP7
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP8")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP8DESC")
	button.image = imgWEP8
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP9")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP9DESC")
	button.image = imgWEP9
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP10")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP10DESC")
	button.image = imgWEP10
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP11")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP11DESC")
	button.image = imgWEP11
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP12")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP12DESC")
	button.image = imgWEP12
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP13")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP13DESC")
	button.image = imgWEP13
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL ESD"
	button.title = TranslationServer.translate("WEP14")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("WEP14DESC")
	button.image = imgWEP14
	$EntriesListing.add_child(button)

func showPlaces():
	for i in $EntriesListing.get_children():
		i.queue_free()
	var button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "<="
	button.sw = 0
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE1")
	button.title = TranslationServer.translate("PLACE1")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE1DESC")
	button.image = imgPLA1
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE2")
	button.title = TranslationServer.translate("PLACE2")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE2DESC")
	button.image = imgPLA2
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE3")
	button.title = TranslationServer.translate("PLACE3")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE3DESC")
	button.image = imgPLA3
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE4")
	button.title = TranslationServer.translate("PLACE4")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE4DESC")
	button.image = imgPLA4
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE5")
	button.title = TranslationServer.translate("PLACE5")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE5DESC")
	button.image = imgPLA5
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE6")
	button.title = TranslationServer.translate("PLACE6")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE6DESC")
	button.image = imgPLA6
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE7")
	button.title = TranslationServer.translate("PLACE7")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE7DESC")
	button.image = imgPLA7
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE8")
	button.title = TranslationServer.translate("PLACE8")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE8DESC")
	button.image = imgPLA8
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE9")
	button.title = TranslationServer.translate("PLACE9")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE9DESC")
	button.image = imgPLA9
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE10")
	button.title = TranslationServer.translate("PLACE10")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE10DESC")
	button.image = imgPLA10
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE11")
	button.title = TranslationServer.translate("PLACE11")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE11DESC")
	button.image = imgPLA11
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE12")
	button.title = TranslationServer.translate("PLACE12")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE12DESC")
	button.image = imgPLA12
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = TranslationServer.translate("PLACE13")
	button.title = TranslationServer.translate("PLACE13")
	button.quote = TranslationServer.translate('')
	button.paragraph = TranslationServer.translate("PLACE13DESC")
	button.image = imgPLA13
	$EntriesListing.add_child(button)


func showFactions():
	for i in $EntriesListing.get_children():
		i.queue_free()
	var button = Button.new()
	button.set_script(selScript)
	button.theme = menuTheme
	button.text = "<="
	button.sw = 0
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "TEL"
	button.title = TranslationServer.translate("FAC1")
	button.quote = TranslationServer.translate('FAC1Q')
	button.paragraph = TranslationServer.translate("FAC1DESC")
	button.image = imgFAC1
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "SEL"
	button.title = TranslationServer.translate("FAC2")
	button.quote = TranslationServer.translate('FAC2Q')
	button.paragraph = TranslationServer.translate("FAC2DESC")
	button.image = imgFAC2
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "ACL"
	button.title = TranslationServer.translate("FAC3")
	button.quote = TranslationServer.translate('FAC3Q')
	button.paragraph = TranslationServer.translate("FAC3DESC")
	button.image = imgFAC3
	$EntriesListing.add_child(button)
	button = Button.new()
	button.set_script(butScript)
	button.theme = menuTheme
	button.text = "REM"
	button.title = TranslationServer.translate("FAC4")
	button.quote = TranslationServer.translate('FAC4Q')
	button.paragraph = TranslationServer.translate("FAC4DESC")
	button.image = imgFAC4
	$EntriesListing.add_child(button)

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene("res://MainMenu.tscn")
