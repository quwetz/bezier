extends Node

onready var time: float = 0.0


func _process(delta):
	time += delta
	Globals.t = sin(time * Globals.t_speed) * 0.5 + 0.5
	var r = sin(time * 2 + 3.14) * 0.5 + 0.5
	var g = sin((time * 2 + 0) * 1.0) * 0.5 + 0.5
	var b = sin((time * 2 + 1.62) * 1.0) * 0.5 + 0.5
	Globals.curve_color = Color(r,g,b,1.0)
	



func _on_Screensaver_toggled(button_pressed):
	Globals.screen_saver_mode = button_pressed


func _on_ShowSubdivision_toggled(button_pressed):
	Globals.show_subdivisions = button_pressed


func _on_ShowNodes_toggled(button_pressed):
	Globals.show_nodes = button_pressed


func _on_Clear_pressed():
	$BezierGraph.clear()


func _on_CurveWidth_value_changed(value):
	Globals.curve_width = value


func _on_CurveLifetime_value_changed(value):
	Globals.curve_lifetime = value


func _on_tSpeed_value_changed(value):
	Globals.t_speed = value


func _on_NodeSpeed_value_changed(value):
	Globals.node_speed = value


func _on_ShowParticles_toggled(button_pressed):
	Globals.show_particles = button_pressed
