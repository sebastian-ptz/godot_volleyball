extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fly")

func _process(delta):
	#var timer = Timer.new()
	#timer.set_wait_time(3000)
	self.play("fly")
	
	if $AnimationPlayer.animation_finished:
		await get_tree().create_timer(20).timeout
		$AnimationPlayer.play("fly")
		
