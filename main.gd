extends Node2D

var timer : Timer = Timer.new() #还没有加载到场景中
@export var min_spawn_rock_time : float = 1.0
@export var max_spawn_rock_time : float = 3.0
@export var s_rock : PackedScene = preload("res://src/entities/rock.tscn") #预加载，还没有实例化

func _ready() -> void:
	self.add_child(timer) #加载到场景中
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = randf_range(min_spawn_rock_time,max_spawn_rock_time)
	timer.start()
	
func _on_timer_timeout() -> void:
	spawn_rock()
	timer.wait_time = randf_range(min_spawn_rock_time,max_spawn_rock_time)
	timer.start()

func spawn_rock() -> void:
	var rock : Node2D = s_rock.instantiate() #实例化
	rock.position = Vector2(720,216)
	self.add_child(rock) #add_child里面必须是个节点(node)
