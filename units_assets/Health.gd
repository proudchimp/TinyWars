extends Node2D

signal dead

onready var recover_health = $RecoverHealth

var initial_health 
var health: int = 100 setget set_health

func _ready():
	initial_health = health

func set_health(value: int):
	health = value
	
func take_hit(damage: int):
	health -= damage
	if health < 0:
		emit_signal("dead")
	return true
	

func _physics_process(delta):
	if recover_health.is_stopped():
		if health < 100:
			health += 2
			print("recovered 2 health")
			recover_health.start()
