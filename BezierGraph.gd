extends Node2D


var BNode = preload("res://BNode.tscn")


var nodes: Array = []
var is_root: bool = true
var subdivision: Node2D = null


func _process(delta):
	if is_root:
		update_nodes()


func update_nodes():
	for n in nodes:
		n.update_position()
		n.update()
	if subdivision != null:
		subdivision.update_nodes()
		

func clear():
	for n in nodes:
		n.queue_free()
		
	if subdivision != null:
		subdivision.clear()
		subdivision.queue_free()
		subdivision = null
	nodes.clear()


func add_node() -> Node2D:
	var bnode: Node2D = BNode.instance()
	
	if is_root:
		bnode.is_root_node = true
	
	if nodes.size() > 0:
		bnode.prev = nodes[nodes.size() - 1]
		create_subdivisions(bnode.prev, bnode)
	else: 
		bnode.prev = null
	
	nodes.append(bnode)
	add_child(bnode)
	bnode.global_position = get_global_mouse_position()
	return bnode
	
	
func create_subdivisions(parent_min, parent_max):
	if subdivision == null:
		instance_sub_graph()
		
	var new_node: Node2D = subdivision.add_node()
	new_node.parent_min = parent_min
	new_node.parent_max = parent_max
	
	
func instance_sub_graph():
	var BGraph = load("res://BezierGraph.tscn")
	subdivision = BGraph.instance()
	subdivision.is_root = false
	add_child(subdivision)

func _unhandled_input(event):
	if is_root:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				add_node()
				Globals.call_deferred("emit_signal", "new_node_added")
				get_tree().set_input_as_handled()
		elif event is InputEventScreenTouch:
			if event.pressed and event.get_index() == 0:
				add_node()
				Globals.call_deferred("emit_signal", "new_node_added")
				get_tree().set_input_as_handled()
