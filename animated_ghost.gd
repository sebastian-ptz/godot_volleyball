extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("ghost_around")

func _process(delta):
	var anim_time = $AnimationPlayer.current_animation_position
	if  anim_time > 5 && anim_time < 12:
		self.play("attack")
	else: 
		self.play("walk")
	
	if $AnimationPlayer.animation_finished:
		await get_tree().create_timer(20).timeout
		$AnimationPlayer.play("ghost_around")
		
