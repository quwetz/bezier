extends Node

export var Enemy: PackedScene

var score: int = 0 setget set_score
var game_time: float = 0.0
var newest_enemy: Node2D
var new_enemy_threshold = 5
var new_node_threshold = 10

var game_over = false

var on_t_zero_create_enemy = false
var on_t_zero_add_node = false

onready var scoreTimer = $ScoreTimer


func _ready():
	scoreTimer.start(1.0)
	Globals.connect("game_over", self, "_on_game_over")
	Globals.connect("t_near_zero_or_one", self, "_on_t_near_zero_or_one")
	


func _process(delta):
	game_time += delta
	if not game_over:
		$Label.text = str(game_time)


func set_score(value):
	score = value
	
	if value == new_enemy_threshold:
		on_t_zero_create_enemy = true
		new_enemy_threshold += new_enemy_threshold
	if value == new_node_threshold:
		on_t_zero_add_node = true
		new_node_threshold += new_node_threshold * (value / 10)

	Globals.node_speed = min(value, 250)

func add_enemy() -> Node2D:
	var e = Enemy.instance()
	add_child(e)
	var sz = OS.get_screen_size()
	e.add_node(Vector2(rand_range(0, sz.x), 0))
	e.add_node(Vector2(0, rand_range(0, sz.y)))
	return e


func _on_ScoreTimer_timeout():
	self.score += 1
	scoreTimer.start(1.0)
	

func _on_game_over():
	game_over = true
	Globals.high_score = max(Globals.high_score, int(game_time))
	yield(get_tree().create_timer(5.0), "timeout")
	Globals.emit_signal("game_ended")
	

func _on_t_near_zero_or_one():
	if on_t_zero_create_enemy:
		newest_enemy = add_enemy()
		on_t_zero_create_enemy = false
	if on_t_zero_add_node:
		var sz = OS.get_screen_size()
		newest_enemy.add_node(Vector2(rand_range(0, sz.x), rand_range(0, sz.y)))
		on_t_zero_add_node = false
		

