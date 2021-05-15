extends KinematicBody2D

var velocity = Vector2.ZERO
var acceleration = 700
var friction = 5000
export var max_speed = 700
export var Explosion: PackedScene

onready var target = global_position setget set_target


func _ready():
	Globals.connect("game_over", self, "_on_game_over")


func _on_game_over():
	var explosion = Explosion.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()


func _process(delta):
	if target.distance_squared_to(global_position) < 300:
		apply_friction(delta)
	else:
		if target_is_in_opposite_direction():
			apply_friction(delta)
		var direction = (target - global_position).normalized()
		velocity = velocity.move_toward(direction * max_speed, delta * acceleration)
	move_and_slide(velocity)


func apply_friction(delta):
	velocity = velocity.move_toward(Vector2.ZERO, delta * friction)


func target_is_in_opposite_direction() ->  bool:
	return (cos(velocity.angle_to(target - global_position)) < 0.5)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			self.target = event.global_position
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.target = event.global_position
			
func set_target(value):
	target = value
	
