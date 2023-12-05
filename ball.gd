extends RigidBody2D

signal hit_left_floor
signal hit_right_floor

enum BALL {DEFAULT, SLOW, BIG, BOUNCE}

@export var ball_type = BALL.SLOW

@export var MAX_SPEED_x = 600.0
@export var MAX_SPEED_y = -1000.0
@export var MIN_SPEED_x = 200.0
@export var MIN_SPEED_y = -500.0


var gravity = 1000
func _ready():
	match ball_type:
		BALL.SLOW:
			self.gravity_scale = 0.2
			MAX_SPEED_x = MAX_SPEED_x/2
			MAX_SPEED_y = MAX_SPEED_y/2
			MIN_SPEED_x = MIN_SPEED_x/3
			MIN_SPEED_y = MIN_SPEED_y/3
		BALL.BIG:
			$Sprite2D.scale = Vector2(1.5,1.5)
			$CollisionShape2D.shape.radius = 48
		BALL.BOUNCE:
			MAX_SPEED_x = MAX_SPEED_x*5
			MAX_SPEED_y = MAX_SPEED_y*5
			MIN_SPEED_x = MIN_SPEED_x*5
			MIN_SPEED_y = MIN_SPEED_y*5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	pass
	
	
	
#	Legacy code:
#	 Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity*1.5 * delta
#
#	#print(velocity)
#
#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		if collision.get_collider().is_in_group("player"):
#			print(collision.get_collider())
#			var player = collision.get_collider() as CharacterBody2D
#			print(collision.get_normal())
#			print(collision.get_remainder())
#			print(player.velocity)
#			var add_velocity = player.velocity + Vector2(0, -2000)
#			var reflect = collision.get_remainder().bounce(collision.get_normal()) + add_velocity
#			print(reflect)
#			velocity = velocity.bounce(collision.get_normal())
#			move_and_collide(reflect * delta)
#		else:
#			var reflect = collision.get_remainder().bounce(collision.get_normal())
#			velocity = velocity.bounce(collision.get_normal())
#			move_and_collide(reflect * delta)


func _on_body_entered(body):
	if body.is_in_group("player"):
		if abs(linear_velocity.x) > MAX_SPEED_x:
			linear_velocity.x = linear_velocity.x * 1.2
			if abs(linear_velocity.x) > MAX_SPEED_x:
				linear_velocity.x = (linear_velocity.x/abs(linear_velocity.x))*MAX_SPEED_x
		if abs(linear_velocity.x) > MAX_SPEED_x:
			print(linear_velocity.x)
			linear_velocity.x = (linear_velocity.x/abs(linear_velocity.x))*MAX_SPEED_x
		if linear_velocity.y < MAX_SPEED_y:
			linear_velocity.y = linear_velocity.y * 1.2
			if linear_velocity.y < MAX_SPEED_y:
				linear_velocity.y = MAX_SPEED_y
		if linear_velocity.y > MIN_SPEED_y:
			linear_velocity.y = MIN_SPEED_y
	if body.is_in_group("left_floor"):
		hit_left_floor.emit()
	if body.is_in_group("right_floor"):
		hit_right_floor.emit()

