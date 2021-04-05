extends CanvasLayer


var game_settings: Settings = null

func _ready():
	game_settings = get_tree().get_root().get_node("/root/Settings")

func _on_Button_pressed():
	get_tree().change_scene("res://ui/WorldSelection.tscn")
