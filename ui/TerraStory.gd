extends CanvasLayer

func _on_ChangeScene_timeout():
	get_tree().change_scene("res://ui/UnitSelectionScreen.tscn")
