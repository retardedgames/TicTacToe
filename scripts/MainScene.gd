extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var audioplayer
var soundBtn
var config
# Called when the node enters the scene tree for the first time.
func _ready():
	soundBtn = get_node("SoundCheckBox")
	audioplayer = get_node("AudioStreamPlayer")
	config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	var mute=config.get_value("audio","mute",false)
	soundBtn.pressed=!mute
	if !mute:
		audioplayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	print("Play button pressed.")
	get_tree().change_scene("res://Game.tscn")
	
	pass # Replace with function body.


func _on_SettingsButton_pressed():
	print("Settings Button pressed.")
	pass # Replace with function body.


func _on_SoundCheckBox_pressed():
	if soundBtn.pressed:
		config.set_value("audio","mute",false)
		audioplayer.play()
	else:
		config.set_value("audio","mute",true)
		audioplayer.stop()
	config.save("user://settings.cfg")
	pass # Replace with function body.
