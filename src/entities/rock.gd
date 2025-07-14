extends CharacterBody2D

@export var speed : int = 150

func _physics_process(delta: float) -> void: #delta会递加导致rock加速
	velocity.x = speed * -1
	move_and_slide()
