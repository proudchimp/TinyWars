extends KinematicBody2D

signal enemy_fired(bullet, place, direction)

export (PackedScene) var Bullet
export var health: int = 100
export var range_size: int = 100

onready var gun = $GunHandler/Gun
onready var gun_direction = $GunHandler/GunDirection
onready var attack_cooldown = $GunHandler/AttackCooldown
onready var unit_range = $Range

var enemies_on_range = {}
var active_target: KinematicBody2D = null

func _ready():
	yield(get_tree(), "idle_frame")
	unit_range.set_range_size(range_size)

func _on_Range_body_entered(body: KinematicBody2D):
	if body.is_in_group("player_units"):
		enemies_on_range[body.get_instance_id()] = body
		

func _process(_delta):
	if enemies_on_range.size() > 0:
		var active_key = enemies_on_range.keys()[0]
		active_target = enemies_on_range[active_key]
	else:
		active_target = null
	if active_target:
		look_at(active_target.position)
		shoot()

func shoot():
	if attack_cooldown.is_stopped():
		var bullet_instance = Bullet.instance()
		var bullet_direction = gun_direction.global_position - gun.global_position
		emit_signal("enemy_fired", bullet_instance, gun.global_position, bullet_direction.normalized())
		attack_cooldown.start()

func handle_hit(damage):
	if health <= 0:
		queue_free()
		return
	health -= damage

func _on_Range_body_exited(body):
	if body.is_in_group("player_units"):
		print("player Exited view area", body)
		enemies_on_range.erase(body.get_instance_id())
