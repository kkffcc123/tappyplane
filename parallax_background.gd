extends ParallaxBackground

@onready var parallax_layer: ParallaxLayer = %ParallaxLayer
@export var speed : int = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parallax_layer.motion_offset.x -= speed * delta
