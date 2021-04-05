extends Node2D

onready var gun = $Gun
onready var gun_direction = $GunDirection
onready var attack_cooldown = $AttackCooldown
onready var shot_sound = $PistolSound
onready var heavy_sound = $HeavySound

var gun_cooldown: float = 0.2 setget set_cooldown

func _ready():
	attack_cooldown.wait_time = gun_cooldown

func set_cooldown(value: float):
	gun_cooldown = value

func play_sound(weapon):
	if weapon == "pistol":
		shot_sound.play()
	if weapon == "heavy":
		heavy_sound.play()
