extends Node2D

var timer : Timer = Timer.new() #还没有加载到场景中

@onready var game_form: Control = %GameForm
@onready var plane: CharacterBody2D = %Plane
@export var min_spawn_rock_time : float = 1.0
@export var max_spawn_rock_time : float = 3.0
@export var s_rock : PackedScene = preload("res://src/entities/rock.tscn") #预加载，还没有实例化
var current_score : int = 0
var score_timer : Timer = Timer.new()

func _ready() -> void:
	self.add_child(timer) #加载到场景中
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = randf_range(min_spawn_rock_time,max_spawn_rock_time)
	timer.start()
	
	self.add_child(score_timer)
	score_timer.timeout.connect(_on_score_timer_timeout)
	score_timer.wait_time = 1
	score_timer.start()
	
func _process(delta: float) -> void:
	if plane.position.y < -3 or plane.position.y > ProjectSettings.get_setting("display/window/size/viewport_height"):
		game_over()
	
func spawn_rock() -> void:
	var rock : Node2D = s_rock.instantiate() #实例化
	rock.rock_entered.connect(_on_rock_entered)
	var random_choice : int = randi_range(0,1)
	
	if random_choice == 0:
		rock.rotation_degrees = 0
		rock.position = Vector2(720,randi_range(260,320))
	else:
		rock.rotation_degrees = 180
		rock.position = Vector2(720,randi_range(20,90))

	self.add_child(rock) #add_child里面必须是个节点(node)

func game_over() -> void:
	print("飞机坠毁")
	get_tree().paused = true
	plane.queue_free()
	for rock in get_tree().get_nodes_in_group("rock"):
		rock.queue_free()

func _on_rock_entered() -> void:
	game_over()
	
func _on_timer_timeout() -> void:
	spawn_rock()
	timer.wait_time = randf_range(min_spawn_rock_time,max_spawn_rock_time)
	timer.start()

func _on_score_timer_timeout() -> void:
	current_score += 1
	game_form.update_score_display(current_score)
