extends Node

#onready var settingsmenu = load("res://Menu.tscn")
var filepath = "res://keybinds.ini"
var volumepath = "res://volumes.ini"
var langpath = "res://language.ini"
#var filepath = "res://new_textfile.tres"
var configfile
var volumefile
var langfile

var volumes = {}
var keybinds = {}
var language = 0

func _ready():
	configfile = ConfigFile.new()
	volumefile = ConfigFile.new()
	langfile = ConfigFile.new()
	
	if langfile.load(langpath) == OK:
		for i in langfile.get_sections():
			language = langfile.get_value(i, "language")
	else:
		print("LANG FILE NOT FOUND")
		get_tree().quit()

	if volumefile.load(volumepath) == OK:
		for key in volumefile.get_section_keys("volume"):
			var key_value = volumefile.get_value("volume", key)
			if str(key_value) != "":
				volumes[key] = key_value

			else:
				volumes[key] = null
			
	else:
		print("VOLUME FILE NOT FOUND")
		get_tree().quit()
	
	#language = volumes["language"]
	
	if configfile.load(filepath) == OK:
		for key in configfile.get_section_keys("keybinds"):
			var key_value = configfile.get_value("keybinds", key)
			
			if str(key_value) != "":
				keybinds[key] = key_value

			else:
				keybinds[key] = null
	else:
		print("CONFIG FILE NOT FOUND")
		get_tree().quit()
	
	set_game_binds()

func set_game_binds():
	
	AudioServer.set_bus_volume_db(0,log(volumes["master"])*0.2)
	AudioServer.set_bus_volume_db(1,log(volumes["sfx"])*0.2)
	AudioServer.set_bus_volume_db(2,log(volumes["music"])*0.2)
	
	if language == 0:
		TranslationServer.set_locale("en")
	elif language == 1:
		TranslationServer.set_locale("ru")
	
	
	for key in keybinds.keys():
		var value = keybinds[key]
		
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		

		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)

func write_config():
	
	langfile.set_value("language", "language", language)
	langfile.save(langpath)
	
	for key in keybinds.keys():
		var key_value = keybinds[key]
		#print(key, ":", key_value)
		if key_value != null:
			configfile.set_value("keybinds", key, key_value)
		else:
			configfile.set_value("keybinds", key, "")
	configfile.save(filepath)
	
	for i in volumes.keys():
		var key_value = volumes[i]
		if key_value != null:
			volumefile.set_value("volume", i, key_value)
		else:
			volumefile.set_value("volume", i, "")
	volumefile.save(volumepath)

	
