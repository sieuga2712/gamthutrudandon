extends Node2D

var grow_speed := 5.0  # scale tăng mỗi giây
var max_scale := 1.5
func _process(delta):
	if scale.x < max_scale:
		scale += Vector2.ONE * grow_speed * delta
		
func play_disappear():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.3)  # thu nhỏ về 0 trong 0.3 giây
	await tween.finished
	queue_free()
