extends Node2D

export (PackedScene) var PlayerUnit
export (PackedScene) var PlayerTank

var DEBUG = false

onready var ground_map = $EnvironmentManager/Ground
onready var camera = $Controls/Camera2D
onready var bullet_manager = $BulletManager
onready var player_manager = $PlayerManager
onready var enemy_manager = $EnemyManager
onready var controller_manager = $Controls
onready var spawn_point = $PlayerSpawn

var dead_player_count: int = 0
var dead_enemy_count: int = 0
var game_settings = null

func _ready():
	game_settings = get_tree().get_root().get_node("/root/Settings")
	_configure_camera()
	_create_players()
	_make_spawn(player_manager.get_children())
	
	yield(get_tree(), "idle_frame")
	
	for player_unit in player_manager.get_children():
		player_unit.connect("player_fired", bullet_manager, "handle_bullet_spawn")
	for enemy_unit in enemy_manager.get_children():
		enemy_unit.connect("enemy_fired", bullet_manager, "handle_bullet_spawn")
		

func _configure_camera():
	print_debug("[INFO] Configuring Camera Limits")
	var used_rect = ground_map.get_used_rect()
	var map_cellsize = ground_map.cell_size
	camera.limit_left = used_rect.position.x * map_cellsize.x
	camera.limit_right = used_rect.end.x * map_cellsize.x
	camera.limit_top = used_rect.position.y * map_cellsize.y
	camera.limit_bottom = used_rect.end.y * map_cellsize.y

func _make_spawn(units):
	var points = spawn_point.get_children()
	for unit in units:
		var spawn_index = randi() % points.size()
		var point = points[spawn_index]
		points.remove(spawn_index)
		unit.position = point.position
		
func _create_players():
	print("[INFO] Player Settings Settings: ", game_settings.player_units)
	
	for _i in range(game_settings.player_units.get(game_settings.UNITS.PLAYER_SOLDIER)):
		print("[INFO] Should Spawn Player")
		var soldier: PlayerSoldier = PlayerUnit.instance()
		player_manager.add_child(soldier)
	for _i in range(game_settings.player_units.get(game_settings.UNITS.PLAYER_TANK)):
		print("[INFO] Should Spawn Heavy Unit")
		var heavy = PlayerTank.instance()
		player_manager.add_child(heavy)
	
	

func _process(_delta):
	
	if DEBUG:
		for child in enemy_manager.get_children():
			enemy_manager.remove_child(child)
	
	if enemy_manager.get_child_count() <= 0:
		get_tree().change_scene("res://ui/WinScreen.tscn")
	if player_manager.get_child_count() <= 0:
		get_tree().change_scene("res://ui/GameOverScreen.tscn")
