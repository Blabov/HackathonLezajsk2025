extends CanvasLayer


func damage_effect() -> void:
	$DamageEffect.visible = true
	await get_tree().create_timer(0.5).timeout
	$DamageEffect.visible = false
