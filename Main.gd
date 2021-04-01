extends Node2D

export (PackedScene) var PlayerSoldier
export (PackedScene) var PlayerTank

onready var bullet_manager = $BulletManager
onready var player_manager = $PlayerManager
onready var enemy_manager = $EnemyManager
onready var controller_manager = $Controls

var dead_player_count: int = 0
var dead_enemy_count: int = 0

func _ready():
	var game_settings = get_tree().get_root().get_node("/root/Settings")
	for _i in range(game_settings.UNITS.PLAYER_SOLDIER):
		var soldier  = PlayerSoldier.instance()
		player_manager.add_child(soldier)
	
	for player_unit in player_manager.get_children():
		player_unit.connect("player_fired", bullet_manager, "handle_bullet_spawn")
	for enemy_unit in enemy_manager.get_children():
		enemy_unit.connect("enemy_fired", bullet_manager, "handle_bullet_spawn")
		

func _process(_delta):
	if enemy_manager.get_child_count() <= 0:
		get_tree().change_scene("res://ui/GameOverScreen.tscn")
	if player_manager.get_child_count() <= 0:
		get_tree().change_scene("res://ui/GameOverScreen.tscn")
