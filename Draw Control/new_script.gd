extends Node2D

var paint_list = []
var body_list = []

var last_mouse_pos = Vector2()

func _ready():
	pass
#	$Timer.set_wait_time(5)
	
#	$Timer.connect("timeout", self, "_on_Timer_timeout", [body_list])

func _process(_delta):
	var mouse_pos = get_viewport().get_mouse_position()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if mouse_pos.distance_to(last_mouse_pos) >= 1:
			add_paint(mouse_pos)
			add_body(mouse_pos)
#			$Timer.start()

	last_mouse_pos = mouse_pos

func _draw():
	for dot in paint_list:
		draw_circle(dot.pos, 32, Color(0,0,0))
		
	for body in body_list:
		add_child(body)

func _on_Timer_timeout(new_body_list):
	print("hello world")
	for body in new_body_list:
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
	
	var timer = Timer.new()
	timer.set_wait_time(5)
	timer.start()
	timer.connect("timeout", self, "_on_Timer_timeout", [body_list])
	print(timer.time_left)
	
	body.add_child(timer)
