extends Node2D


var line_start: Vector2

export var ParticleEffect: PackedScene

onready var color: Color = Globals.curve_color
onready var total_lifetime: float = Globals.curve_lifetime

func _ready():
	Globals.connect("new_node_added", self, "queue_free")
	Globals.connect("curve_lifetime_changed", self, "_on_curve_lifetime_changed")
	Globals.connect("curve_width_changed", self, "_on_curve_width_changed")
	$Timer.start(Globals.curve_lifetime)
	if Globals.show_particles:
		create_particles()
		

func create_particles():
	var p = ParticleEffect.instance()
	p.global_position = global_position
	get_parent().add_child(p)

	
func _on_Timer_timeout():
	queue_free()
	
func _draw():
	draw_circle(Vector2.ZERO, Globals.curve_width / 2, color)
	draw_circle(line_start - global_position, Globals.curve_width / 2, color)
	draw_line(Vector2.ZERO, line_start - global_position, color, Globals.curve_width, true)


func _on_curve_lifetime_changed(value):
	$Timer.start(($Timer.time_left / total_lifetime) *  value)
	total_lifetime = value


func _on_curve_width_changed(value):
	update()
