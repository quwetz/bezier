extends CPUParticles2D


func _ready():
	$Timer.start(lifetime)
	emitting = true
	color = Globals.curve_color
	


func _on_Timer_timeout():
	queue_free()
