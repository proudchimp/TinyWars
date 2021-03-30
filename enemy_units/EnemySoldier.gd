extends KinematicBody2D

signal enemy_fired(bullet, place, direction)

export (PackedScene) var Bullet
export var initial_health: int = 100
export var range_size: int = 100
export var gun_cooldown: float = 0.2

onready var gun = $GunHandler/Gun
onready var gun_direction = $GunHandler/GunDirection
onready var attack_cooldown = $GunHandler/AttackCooldown
onready var gun_handler = $GunHandler
onready var unit_range = $AI/Range
onready var health = $Health

func _ready():
	yield(get_tree(), "idle_frame")
	unit_range.set_range_size(range_size)
	health.set_health(initial_health)
	gun_handler.set_cooldown(gun_cooldown)


func shoot():
	if attack_cooldown.is_stopped():
		var bullet_instance = Bullet.instance()
		var bullet_direction = gun_direction.global_position - gun.global_position
		emit_signal("enemy_fired", bullet_instance, gun.global_position, bullet_direction.normalized())
		attack_cooldown.start()

func handle_hit(damage):
	health.take_hit(damage)

func _on_Health_dead():
	queue_free()


func _on_AI_shoot():
	shoot()


func _on_AI_look(position):
	look_at(position)
