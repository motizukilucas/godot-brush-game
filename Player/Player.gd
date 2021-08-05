extends KinematicBody2D

export (int) var move_speed = 400
export (int) var jump_speed = -600
export (int) var gravity = 1000

var velocity = Vector2()

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += move_speed
	if left:
		velocity.x -= move_speed
		
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2.UP)
