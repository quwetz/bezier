extends CPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(lifetime)
	if Globals.show_particles:
		emitting = true
		color = Globals.curve_color
	


func _on_Timer_timeout():
	print("foo")
	queue_free()
