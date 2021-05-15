extends Node

export var Game: PackedScene

var game: Node = null

var mode = Globals.screen_saver_mode
var particles = Globals.show_particles
var show_subdivisions = Globals.show_subdivisions
var show_nodes = Globals.show_nodes
var curve_lifetime = Globals.curve_lifetime
var curve_width = Globals.curve_width
var node_speed = Globals.node_speed
var t_speed = Globals.t_speed

onready var graph = $BezierGraph
onready var time: float = 0.0



func _ready():
	Globals.connect("game_started", self, "_on_game_started")
	Globals.connect("game_ended", self, "_on_game_ended")
	Globals.connect("highscore_set", self, "_on_highscore_set")


func _process(delta):
	time += delta
	Globals.t = sin(time * Globals.t_speed) * 0.5 + 0.5
	var r = sin(time * 2 + 3.14) * 0.5 + 0.5
	var g = sin((time * 2 + 0) * 1.0) * 0.5 + 0.5
	var b = sin((time * 2 + 1.62) * 1.0) * 0.5 + 0.5
	Globals.curve_color = Color(r,g,b,1.0)
	

func _on_highscore_set():
	$Highscore.text = "Highscore: " + str(Globals.high_score)
	
func _on_game_started():
	remove_child(graph)
	$MenuButton.visible = false
	$Options.visible = false
	game = Game.instance()
	add_child(game)
	Globals.game_is_running = true
	store_current_settings()
	apply_game_settings()
	


func _on_game_ended():
	add_child(graph)
	$MenuButton.visible = true
	game.queue_free()
	game = null
	Globals.game_is_running = false
	restore_settings()
	
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


func _on_StartGame_pressed():
	Globals.emit_signal("game_started")
	
	
func store_current_settings():
	mode = Globals.screen_saver_mode
	particles = Globals.show_particles
	show_subdivisions = Globals.show_subdivisions
	show_nodes = Globals.show_nodes
	curve_lifetime = Globals.curve_lifetime
	curve_width = Globals.curve_width
	node_speed = Globals.node_speed
	t_speed = Globals.t_speed
	

func restore_settings():
	Globals.screen_saver_mode = mode
	Globals.show_particles = particles
	Globals.show_subdivisions = show_subdivisions
	Globals.show_nodes = show_nodes
	Globals.curve_lifetime = curve_lifetime
	Globals.curve_width = curve_width
	Globals.node_speed = node_speed
	Globals.t_speed = t_speed

	
func apply_game_settings():
	Globals.screen_saver_mode = true
	Globals.show_particles = true
	Globals.show_subdivisions = true
	Globals.show_nodes = true
	Globals.curve_lifetime = 0.1
	Globals.curve_width = 1
	Globals.node_speed = 25.0
	Globals.t_speed = 1.0
