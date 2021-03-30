extends Node2D

signal dead

var health: int = 100 setget set_health

func set_health(value: int):
	health = value
	
func take_hit(damage: int):
	health -= damage
	if health < 0:
		emit_signal("dead")
	return true
	

