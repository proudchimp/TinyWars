extends Node2D

onready var gun = $Gun
onready var gun_direction = $GunDirection
onready var attack_cooldown = $AttackCooldown

var gun_cooldown: float = 0.2 setget set_cooldown

func _ready():
	attack_cooldown.wait_time = gun_cooldown

func set_cooldown(value: float):
	gun_cooldown = value
