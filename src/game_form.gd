extends Control

@onready var score_container: HBoxContainer = %ScoreContainer
@onready var w_game_over_pop_up: MarginContainer = %WGameOverPopUp

signal quit_pressed

signal retry_pressed

var number_textures = [
	preload("res://assets/textures/widgets/numbers/number0.png"),
	preload("res://assets/textures/widgets/numbers/number1.png"),
	preload("res://assets/textures/widgets/numbers/number2.png"),
	preload("res://assets/textures/widgets/numbers/number3.png"),
	preload("res://assets/textures/widgets/numbers/number4.png"),
	preload("res://assets/textures/widgets/numbers/number5.png"),
	preload("res://assets/textures/widgets/numbers/number6.png"),
	preload("res://assets/textures/widgets/numbers/number7.png"),
	preload("res://assets/textures/widgets/numbers/number8.png"),
	preload("res://assets/textures/widgets/numbers/number9.png")
]

func _ready() -> void:
	w_game_over_pop_up.hide()
	
func game_over() -> void:
	w_game_over_pop_up.show()
	
func game_retry() -> void:
	w_game_over_pop_up.hide()
	
#更新分数显示
func update_score_display(current_score:int)-> void:
	var score_str :String = str(current_score)
	var digit_count = score_str.length()
	for i in range(digit_count):
		var digit = int(score_str[i])
		var digit_sprite :TextureRect
		if score_container.get_child_count()<= i:
			digit_sprite = TextureRect.new()
			score_container.add_child(digit_sprite)
		else:
			digit_sprite = score_container.get_child(i)
		digit_sprite.texture = number_textures[digit]


"""
函数定义：

函数名：update_score_display

参数：current_score（整数类型，表示当前分数）

返回值：void（无返回值）

gdscript
var score_str :String = str(current_score)
var digit_count = score_str.length()
分数处理：

将整数分数转换为字符串（例如：123 → "123"）

获取分数字符串的长度（即数字位数），例如：

123 → 长度 3

1000 → 长度 4

gdscript
for i in range(digit_count):
遍历每位数字：

循环处理分数的每一位数字（从左到右）

例如：分数 123 会循环 3 次：

i=0：处理百位数字 '1'

i=1：处理十位数字 '2'

i=2：处理个位数字 '3'

gdscript
var digit = int(score_str[i])
获取当前位数字：

从字符串中提取当前位置的数字字符

将其转换为整数（例如：字符 '5' → 整数 5）

gdscript
var digit_sprite :TextureRect
if score_container.get_child_count() <= i:
	digit_sprite = TextureRect.new()
	score_container.add_child(digit_sprite)
else:
	digit_sprite = score_container.get_child(i)
动态创建/获取数字显示节点：

如果数字位数增加（分数位数比之前多）：

创建新的 TextureRect 节点

添加到分数容器（score_container）中

如果已有足够节点：

直接复用容器中对应位置的子节点

例如：

分数从 99（2位）变为 100（3位）时，会创建第3个节点

分数从 100 变回 99 时，会复用前2个节点（第3个节点保留但可能隐藏）

gdscript
digit_sprite.texture = number_textures[digit]
设置数字纹理：

从预设的纹理数组 number_textures 中获取对应数字的纹理

设置到 TextureRect 节点上

例如：

number_textures[0] 对应数字 0 的纹理

number_textures[5] 对应数字 5 的纹理

整体工作流程：
输入：整数分数（如 205）

转换：分数 → 字符串 → 拆分为单个数字 ["2", "0", "5"]

节点管理：

检查容器中子节点数量

位数增加时创建新节点

位数不变或减少时复用现有节点

纹理设置：

为每个数字位置设置对应纹理

最终显示效果：2 0 5（三个独立的数字图像）
"""


func _on_btn_retry_pressed() -> void:
	retry_pressed.emit()

func _on_btn_quit_pressed() -> void:
	quit_pressed.emit()
