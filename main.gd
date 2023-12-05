extends Node2D

var ball_scene = load("res://ball.tscn")
var ball_reference
var last_scored
var score = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	score = Vector2(0,0)
	$"ColorRect/User Interface/ScoreLeft".text = str(0)
	$"ColorRect/User Interface/ScoreRight".text = str(0)
	randomize()
	last_scored = randi()%2+1
	spawn_ball()


func _on_ball_hit_left_floor():
	score.y += 1
	$"ColorRect/User Interface/ScoreRight".text = str(score.y)
	last_scored = 2

	if score.y == 3:
		ball_reference.hit_left_floor.disconnect(_on_ball_hit_left_floor)
		ball_reference.hit_right_floor.disconnect(_on_ball_hit_right_floor)
		game_over(2)
	else:
		spawn_ball()


func _on_ball_hit_right_floor():
	score.x += 1
	$"ColorRect/User Interface/ScoreLeft".text = str(score.x)
	last_scored = 1
	
	if score.x == 3:
		ball_reference.hit_left_floor.disconnect(_on_ball_hit_left_floor)
		ball_reference.hit_right_floor.disconnect(_on_ball_hit_right_floor)
		game_over(1)
	else:
		spawn_ball()

func spawn_ball():
	if ball_reference != null:
		ball_reference.queue_free()
	
	await get_tree().create_timer(2).timeout
	
	ball_reference = ball_scene.instantiate()
	ball_reference.hit_left_floor.connect(_on_ball_hit_left_floor)
	ball_reference.hit_right_floor.connect(_on_ball_hit_right_floor)
	randomize()
	ball_reference.ball_type = randi()%3
	print(ball_reference.ball_type)
	add_child(ball_reference)
	
	match last_scored:
		1:
			ball_reference.position = $RightSpawnLocation.position
		2:
			ball_reference.position = $LeftSpawnLocation.position

func game_over(winner):
	match winner:
		1:
			$"ColorRect/User Interface/WinMessageLeft".visible = true
		2:
			$"ColorRect/User Interface/WinMessageRight".visible = true
	
	await get_tree().create_timer(6).timeout
	
	ball_reference.queue_free()
	
	$"ColorRect/User Interface/WinMessageLeft".visible = false
	$"ColorRect/User Interface/WinMessageRight".visible = false
	
	new_game()
