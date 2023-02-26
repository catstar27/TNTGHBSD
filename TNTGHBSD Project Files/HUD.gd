extends CanvasLayer

signal start_game
var is_playing = false

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$Message.text = "TNTGHBSD"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$ButtonContainer.show()
	is_playing = false

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$ButtonContainer.hide()
	start_game.emit()

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_quit_button_pressed():
	get_tree().quit()

func _unhandled_input(_event):
	if Input.is_action_pressed("escape"):
		get_tree().quit()
	if Input.is_action_pressed("enter"):
		if is_playing == false:
			$ButtonContainer.hide()
			start_game.emit()
			is_playing = true

func _on_player_fuel_amount(fuel):
	$FuelDisplayContainer/FuelAmountLabel.text = str(fuel)
