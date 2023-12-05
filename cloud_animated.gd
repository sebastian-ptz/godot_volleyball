extends AnimatedSprite2D

@export var _animation = "cloud_1"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("cloud/" + _animation)

func _process(delta):
	self.play("move")
	
	if $AnimationPlayer.animation_finished:
		$AnimationPlayer.play("cloud/" + _animation)
		
