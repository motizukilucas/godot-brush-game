extends Node2D

var paint_list = []

var last_mouse_pos = Vector2()

onready var DrawControl = get_node("Draw Control")

func _process(delta):
	var mouse_pos = get_global_mouse_position()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if mouse_pos.distance_to(last_mouse_pos) >= 1:
			add_paint(mouse_pos)
			
	last_mouse_pos = mouse_pos

func _draw():
	for dot in paint_list:
		draw_circle(dot.pos, 32, Color(0,0,0))
		
		var timer = Timer.new()
		dot.body.add_child(timer)
		timer.set_wait_time(5)
		timer.connect("timeout", self, "_on_Timer_timeout", [dot])
		
		add_child(dot.body)
		
		timer.start()

func _on_Timer_timeout(dot):
	paint_list.erase(dot)
	dot.body.queue_free()
	
#	paint_list.clear()
	update()

func add_paint(mouse_pos):
	var dot = {}

	dot.pos = mouse_pos

	var body = StaticBody2D.new()
	var shape = CircleShape2D.new()
	shape.set_radius(32)
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)
	body.set_position(mouse_pos)
	body.add_child(collision)
	dot.body = body
	
	paint_list.append(dot)
	update()
	
