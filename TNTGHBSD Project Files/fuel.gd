extends Area2D

func _on_despawn_timer_timeout():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.refuel()
		queue_free()
