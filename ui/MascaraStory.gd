extends CanvasLayer


func _on_Timer_timeout():
	get_tree().change_scene("res://ui/UnitSelectionScreen.tscn")
