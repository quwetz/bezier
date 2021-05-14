extends Node2D


var is_root_node: bool = false
var dragging: bool = false
var prev: Node2D setget set_prev
var next: Node2D setget set_next

var parent_min: Node2D = null
var parent_max: Node2D = null

var show: bool = true
var size: float = 10.0
var color: Color = Color.black

var velocity = Vector2.RIGHT.rotated(rand_range(0.0, 2*PI)) * rand_range(0.8, 1.2)

onready var collider = $CollisionShape2D
onready var last_pos: Vector2 = Vector2.ZERO

export var LineSegment: PackedScene


func _process(delta):
	if is_root_node and dragging:
		self.position = get_global_mouse_position()
	if is_root_node and Globals.screen_saver_mode:
		move_node(delta)
	update_position()
	var screensize = OS.get_window_size()
	global_position = Vector2(clamp(global_position.x, 0, screensize.x), clamp(global_position.y, 0, screensize.y))

func update_position():
	if not is_root_node:
		global_position = parent_min.global_position + (parent_max.global_position - parent_min.global_position) * Globals.t


func move_node(delta):
	var screensize = OS.get_window_size()
	global_position += velocity * Globals.speed * delta
	if global_position.x < 0 or global_position.x > screensize.x:
		velocity.x *= -1.0
	if global_position.y < 0 or global_position.y > screensize.y:
		velocity.y *= -1.0
	
		

func _draw():
	set_visuals()
	if Globals.show_nodes:
		draw_circle(Vector2.ZERO, size, color)
	if Globals.show_subdivisions:
		if prev != null:
			draw_line(Vector2.ZERO, prev.global_position - global_position, color,1.0, true)


func set_visuals():
	if is_root_node:
		color = Globals.ROOT_NODE_COLOR
		size = 10.0
		show = true
	elif is_draw_node():
		color = Globals.DRAW_NODE_COLOR
		size = 7.0
		show = true
	else: 
		color = Globals.OTHER_NODE_COLOR
		size = 5.0
		show = Globals.show_subdivisions


func choose_size() -> float:
	if is_root_node:
		return 10.0
	if is_draw_node():
		return 7.0
	return 5.0

func is_draw_node() -> bool:
	return prev == null and next == null

func set_prev(value):
	prev = value
	if prev != null:
		prev.next = self


func set_next(value):
	next = value


func _input(event):
	if is_root_node and (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.pressed:
			if get_global_mouse_position().distance_to(self.global_position) <= 10.0:
				dragging = true
				get_tree().set_input_as_handled()
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			dragging = false
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			if event.position.distance_to(self.global_position) <= 30.0:
				dragging = true
				get_tree().set_input_as_handled()
		elif !event.pressed and event.get_index() == 0:
			if dragging:
				global_position = event.position
			dragging = false


func _on_Timer_timeout():
	if is_draw_node():
		if last_pos != Vector2.ZERO:
			var line_segment = LineSegment.instance()
			line_segment.global_position = global_position
			line_segment.line_start = last_pos
			get_parent().add_child(line_segment)
		$Timer.start(0.01)
		last_pos = global_position
