extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -1200.0
@export var player_type = "p1"
var gravity = 3000


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump_" + player_type) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left_" + player_type, "move_right_" + player_type)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	move_and_slide()
