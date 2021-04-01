extends CanvasLayer

onready var slots: Label = $Panel/MarginContainer/MainContainer/SlotsContainer/SlotsAvailable
onready var soldierSelectSpin = $Panel/MarginContainer/MainContainer/InteractionContainer/SoldierContainer/SoldierSelect
onready var tankSelectSpin = $Panel/MarginContainer/MainContainer/InteractionContainer/HBoxContainer2/TankSelect

var max_slots: int
var soldier_units: int
var tank_units: int
var available_slots: int
var game_settings: Settings = null

func _ready():
	game_settings = get_tree().get_root().get_node("/root/Settings")
	max_slots = game_settings.MAX_SLOTS
	available_slots = max_slots
	
	
func _process(_delta):
	if int(available_slots) <= 0:
		soldierSelectSpin.editable = false
	if int(available_slots) <= 2:
		tankSelectSpin.editable = false
	
	
func _on_SoldierSelect_value_changed(value):
	soldier_units = int(value)
	update_slots()
	

func _on_TankSelect_value_changed(value):
	tank_units = (int(value) * 2)
	update_slots()


func update_slots():
	available_slots = max_slots - (soldier_units + tank_units)
	slots.text = String(available_slots)

func _on_StartGameButton_pressed():
	game_settings.set_units({
		game_settings.UNITS.PLAYER_SOLDIER: soldier_units,
		game_settings.UNITS.PLAYER_TANK: tank_units/2,
	})
	get_tree().change_scene("res://Main.tscn")

func _on_ResetUnits_pressed():
	get_tree().reload_current_scene()
