extends Node2D

var dragging = false
var selected = []
var highlighted = []
onready var camera = $Camera2D


var drag_start = Vector2.ZERO
var select_rect = RectangleShape2D.new()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed():
			dragging = true
			drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			update()
			var drag_end = get_global_mouse_position()
			select_rect.extents = (drag_end - drag_start) / 2
			
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			var query_results = space.intersect_shape(query, 10)
			selected = []
			for item in query_results:
				if item.collider.is_in_group("player_units"):
					selected.append(item)
			if selected:
				clean_highlight()
			for item in selected:
				if item.collider.is_in_group("player_units"):
					item.collider.selected = true
					highlighted.append(item)
		
	if event is InputEventMouseButton and selected and event.button_index == BUTTON_RIGHT:
		for item in selected:
			if item.collider:
				item.collider.target = get_global_mouse_position()
			
	if event is InputEventMouseButton and not selected:
		clean_highlight()

	if event is InputEventMouseMotion and dragging:
		update()

func clean_highlight():
	for unit in highlighted:
		if unit.collider:
			unit.collider.selected = false
	highlighted = []

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
				Color(.5, .5, .5), false)
