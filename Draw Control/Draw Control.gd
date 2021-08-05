extends Node2D

var paint_list = []
var body_list = []

var last_mouse_pos = Vector2()

func _process(_delta):
	var mouse_pos = get_viewport().get_mouse_position()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if mouse_pos.distance_to(last_mouse_pos) >= 1:
			add_paint(mouse_pos)
			add_body(mouse_pos)

	last_mouse_pos = mouse_pos

func _draw():
	for dot in paint_list:
		draw_circle(dot.pos, 32, Color(0,0,0))
		
	for body in body_list:
		var timer = Timer.new()
		body.add_child(timer)
		timer.set_wait_time(5)
		timer.connect("timeout", self, "_on_Timer_timeout", [body])
		
		add_child(body)
		
		timer.start()

func _on_Timer_timeout(body):
	body_list.erase(body)
	body.queue_free()
	
	body_list.clear()	
	paint_list.clear()
	update()

func add_paint(mouse_pos):
	var dot = {}

	dot.pos = mouse_pos

	paint_list.append(dot)
	update()

func add_body(mouse_pos):
	var body = StaticBody2D.new()
	var shape = CircleShape2D.new()
	shape.set_radius(32)
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)
	body.set_position(mouse_pos)
	body.add_child(collision)
		
	body_list.append(body)
	
