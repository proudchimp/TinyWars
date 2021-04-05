extends CanvasLayer

var game_settings: Settings = null
onready var mascara_button = $Panel/MarginContainer/MainContainer/Center/VBoxContainer/HBoxContainer/VBoxContainer2/MascaraButton

func _ready():
	game_settings = get_tree().get_root().get_node("/root/Settings")

func _on_TerraButton_pressed():
	game_settings.set_world(game_settings.WORLDS.TERRA)
	get_tree().change_scene("res://ui/TerraStory.tscn")


func _on_MascaraButton_pressed():
	game_settings.set_world(game_settings.WORLDS.MASCARA)
	get_tree().change_scene("res://ui/MascaraStory.tscn")
	
