extends Node2D

var line_start: Vector2

func _ready():
	$Timer.start(Globals.line_timer)

func _on_Timer_timeout():
	queue_free()
	
func _draw():
	draw_line(Vector2.ZERO, line_start - global_position, Globals.CURVE_COLOR, Globals.curve_width, true)
