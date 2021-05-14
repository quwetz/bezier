extends Node2D

var line_start: Vector2


func _ready():
	Globals.connect("new_node_added", self, "queue_free")
	$Timer.start(Globals.curve_lifetime)
	
func _on_Timer_timeout():
	queue_free()
	
func _draw():
	draw_circle(Vector2.ZERO, Globals.curve_width / 2, Globals.curve_color)
	draw_circle(line_start - global_position, Globals.curve_width / 2, Globals.curve_color)
	draw_line(Vector2.ZERO, line_start - global_position, Globals.curve_color, Globals.curve_width, true)
