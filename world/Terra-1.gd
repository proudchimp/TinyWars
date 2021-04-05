extends Node2D

onready var ground_map = $EnvironmentManager/Ground
onready var camera = $Controls/Camera2D

func _ready():
	var used_rect = ground_map.get_used_rect()
	var map_cellsize = ground_map.cell_size
	camera.limit_left = used_rect.position.x * map_cellsize.x
	camera.limit_right = used_rect.end.x * map_cellsize.x
	camera.limit_top = used_rect.position.y * map_cellsize.y
	camera.limit_bottom = used_rect.end.y * map_cellsize.y
	yield(get_tree(), "idle_frame")
