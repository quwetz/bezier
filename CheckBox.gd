extends CheckBox



func _on_Screensaver_toggled(button_pressed):
	Globals.screen_saver_mode = button_pressed


func _on_ShowSubdivision_toggled(button_pressed):
	Globals.show_subdivisions = button_pressed


func _on_ShowNodes_toggled(button_pressed):
	Globals.show_nodes = button_pressed
