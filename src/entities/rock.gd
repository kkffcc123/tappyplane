extends CharacterBody2D

signal rock_entered 

"
不发生碰撞，只进行检测，即polygon无碰撞层级，用area2d检测是否有物体进入
"

@export var speed : int = 150

func _physics_process(delta: float) -> void: #delta会递加导致rock加速
	velocity.x = speed * -1
	move_and_slide()
	if self.position.x <= -56:
		self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	rock_entered.emit()
