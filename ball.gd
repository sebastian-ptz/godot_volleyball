extends RigidBody2D

@export var MAX_SPEED_y = -1000.0
@export var MAX_SPEED_x = 600.0
@export var MIN_SPEED_y = -500.0
@export var MIN_SPEED_x = 200.0


var gravity = 1000
func _ready():
	pass # Replace with function body.


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
				linear_velocity.x = MAX_SPEED_x
		if abs(linear_velocity.x) > MAX_SPEED_x:
			linear_velocity.x = MAX_SPEED_x
		if linear_velocity.y < MAX_SPEED_y:
			linear_velocity.y = linear_velocity.y * 1.2
			if linear_velocity.y < MAX_SPEED_y:
				linear_velocity.y = MAX_SPEED_y
		if linear_velocity.y > MIN_SPEED_y:
			linear_velocity.y = MIN_SPEED_y
		print(linear_velocity)

