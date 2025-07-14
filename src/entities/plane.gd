extends CharacterBody2D

var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var flap_power :int = 400 #飞机向上力度
@export var max_tilt_angle : int = 60 # 45 朝右下倾斜
@export var min_tilt_angle : int = -60 #-45 朝右上倾斜

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	#设施倾斜角度
	var tilt_angle = clamp((velocity.y / gravity) * max_tilt_angle,min_tilt_angle,max_tilt_angle)
	self.rotation_degrees = tilt_angle

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("flap"):
		velocity.y -= flap_power #给飞机一个向上的力度
		
