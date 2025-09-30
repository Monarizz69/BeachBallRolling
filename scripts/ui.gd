extends Control

var countdown := 3
var total_time := 0.0

signal restart_game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.is_game_start == true:
		total_time += delta
		var minutes = int(total_time / 60)
		var seconds = int(total_time) % 60
		var milliseconds = int((total_time - int(total_time)) * 1000)
		$InGame/GameTimer.text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]

func new_game():
	GameManager.player_spawnpoint = Vector3.ZERO
	GameManager.is_game_start = false
	$StartGame.show()
	$StartGame/StartButton.show()
	$InGame.hide()
	$Finish.hide()
	
	$InGame/GameTimer.text = "00:00:000"
	total_time = 0

# starting game
func _on_start_button_pressed() -> void:
	countdown = 3
	$StartGame/Countdown.text = str(countdown)
	
	$StartGame/Countdown.show()
	$StartGame/StartButton.hide()
	$CountdownTimer.start()
	$OneSecTimer.start()

# game started
func _on_countdown_timer_timeout() -> void:
	GameManager.is_game_start = true
	$StartGame.hide()
	$InGame.show()
	$Finish.hide()
	$StartGame/Countdown.hide()
	$OneSecTimer.stop()

func _on_one_sec_timer_timeout() -> void:
	countdown -= 1
	$StartGame/Countdown.text = str(countdown)


func _on_finish_game_finish() -> void:
	print("receive")
	$StartGame.hide()
	$InGame.hide()
	$Finish.show()
	GameManager.is_game_start = false
	
	$Finish/FinishTime.text = $InGame/GameTimer.text


func _on_restart_mid_game_button_pressed() -> void:
	GameManager.is_game_start = false
	new_game()
	restart_game.emit()


func _on_restart_button_pressed() -> void:
	new_game()
	restart_game.emit()
