extends Node

@export var mob_scene: PackedScene
@onready var fuel_scene = preload("res://fuel.tscn")
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$FuelTimer.stop()
	$HUD.show_game_over()
	$Music.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("enemy", "queue_free")
	$Music.play()

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$FuelTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randi()
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_fuel_timer_timeout():
	var fuel = fuel_scene.instantiate()
	fuel.position = Vector2(randi_range(0,480),randi_range(0,720))
	add_child(fuel)
