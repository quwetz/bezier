extends Node

onready var time: float = 0.0

func _process(delta):
	time += delta
	Globals.t = sin(time) * 0.5 + 0.5


func _on_Button_pressed():
	$BezierGraph.clear()


func _on_Background_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
