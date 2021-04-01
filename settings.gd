extends Node

enum UNITS {
	PLAYER_SOLDIER,
	PLAYER_TANK
}

const MAX_SLOTS = 10

var player_units: Dictionary = {
	UNITS.PLAYER_SOLDIER: 1,
	UNITS.PLAYER_TANK: 1
} setget set_units

func set_units(units):
	player_units = units
	
func get_units():
	return player_units
