extends CanvasLayer

var health_texture = preload("res://textures/health.png")
var empty_health_texture = preload("res://textures/health_broken.png")

func _ready() -> void:
	set_visible_health(3, 3)

func set_visible_health(amount, max_amount) -> void:
	for child in $Health.get_children():
		child.queue_free()

	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = health_texture
		$Health.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_SCALE
		text_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	for i in max_amount - amount:
		var text_rect = TextureRect.new()
		text_rect.texture = empty_health_texture
		$Health.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_SCALE
		text_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
