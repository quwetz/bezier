extends Control




func _on_MenuButton_toggled(button_pressed):
	visible = button_pressed


func _on_MenuButton_pressed():
	visible = not visible
