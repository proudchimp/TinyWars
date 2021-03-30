extends Node2D

onready var bullet_manager = $BulletManager
onready var player_manager = $PlayerManager
onready var enemy_manager = $EnemyManager
onready var controller_manager = $Controls

func _ready():
	for player_unit in player_manager.get_children():
		player_unit.connect("player_fired", bullet_manager, "handle_bullet_spawn")
	for enemy_unit in enemy_manager.get_children():
		enemy_unit.connect("enemy_fired", bullet_manager, "handle_bullet_spawn")

