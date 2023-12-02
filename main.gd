extends Node2D

@export var impulse_scale = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("impulse_left"):
		$Ball.apply_impulse(Vector2(-400,0))
	if Input.is_action_just_pressed("impulse_right"):
		$Ball.apply_impulse(Vector2(400,0))
	if Input.is_action_just_pressed("impulse_up"):
		$Ball.apply_impulse(Vector2(0,-400))
	if Input.is_action_just_pressed("impulse_down"):
		$Ball.apply_impulse(Vector2(0,400))
	


func _on_ball_body_entered(body):
	if $Ball.get_colliding_body() == $Player:
		var temp = $Ball.get_linear_velocity() * Vector2(-1,-1) * Vector2(impulse_scale, impulse_scale)
		$Ball.apply_impulse(temp)
	
