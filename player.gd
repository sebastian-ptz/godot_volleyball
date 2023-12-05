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

func _process(delta):
	#print("X: %f - Y: %f" %[velocity.x, velocity.y])
	#print("Anim: " + get_random_animation())
	
	if velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	elif velocity.y < 0 && velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("jump")
	elif velocity.y < 0 && velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("jump")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("fall")
	elif velocity.y > 0 && velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("fall")
	elif velocity.y > 0 && velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("fall")
	elif velocity.y == 0 && velocity.x < 0 :
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
	elif velocity.y == 0 && velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
	else:
		#should pick random animaton but overrides currently playing animations
		#play_random_idle_animation(delta)  
		$AnimatedSprite2D.play("blink")


func play_random_idle_animation():
	var random_float = randf()
	if $AnimatedSprite2D.animation_finished:
		if random_float < 0.05: #5% blink
			$AnimatedSprite2D.play("blink")
		else: 
			$AnimatedSprite2D.play("idle")
	else: 
		$AnimatedSprite2D.play($AnimatedSprite2D.animation)
	
