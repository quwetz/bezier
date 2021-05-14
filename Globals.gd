extends Node

signal new_node_added

var t: float = 0.0
const ROOT_NODE_COLOR = Color.webgreen
const DRAW_NODE_COLOR = Color.crimson
const OTHER_NODE_COLOR = Color.white
const CURVE_COLOR = Color.crimson
var show_particles = false
var show_subdivisions: bool = true
var show_nodes: bool = true
var screen_saver_mode: bool = false
var curve_width: float = 2.0
var curve_lifetime: float = 2 * PI
var curve_color = CURVE_COLOR
var node_speed: float = 50.0
var t_speed: float = 1.0
