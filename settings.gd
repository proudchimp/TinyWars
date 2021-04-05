extends Node

enum UNITS {
	PLAYER_SOLDIER,
	PLAYER_TANK
}

enum WORLDS {
	TERRA,
	MASCARA
}

const MAX_SLOTS = 6

var player_units: Dictionary = {
	UNITS.PLAYER_SOLDIER: 1,
	UNITS.PLAYER_TANK: 1
} setget set_units

var game_world: int setget set_world

func set_units(units):
	player_units = units
	
func get_units():
	return player_units

func set_world(world):
	game_world = world

func get_world():
	return game_world
