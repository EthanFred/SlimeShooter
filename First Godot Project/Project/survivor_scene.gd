extends Node2D

var coins = 10;
var mobsToSpawn = 1
var mobsToKill = 1
var wave = 0
var enemiesDied = 0
var strengthCost = 1.0
var speedCost = 1.0
var healthCost = 1.0


func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	#If mob dies, call end_wave
	new_mob.dead.connect(end_wave)

func _on_mob_timer_timeout() -> void:
	spawn_mob()
	mobsToSpawn -= 1
	if mobsToSpawn == 0:
		%MobTimer.stop()
	
	


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	
	
func end_wave():
	
	enemiesDied+=1
	print (enemiesDied)
	if enemiesDied == mobsToKill:
		print ("Ending wave")
		
		
		get_tree().paused = true
		%PowerUpScreen.visible = true;
		%CoinText.text = "Coins: %d" % coins
		
	
	
func begin_wave():
	%PowerUpScreen.visible = false;
	get_tree().paused = false;
	wave += 1
	mobsToSpawn = 5*wave
	mobsToKill = mobsToSpawn
	enemiesDied = 0
	%Player.health = %Player.maxHealth
	if %MobTimer.wait_time > 1:
		%MobTimer.wait_time-=.01
	%MobTimer.start()
	
	print("Beginning wave")


func _on_add_health_pressed() -> void:
	print("Health Pressed")
	if coins >= healthCost:
		%Player.maxHealth *= 1.01
		coins -= healthCost
		healthCost *= 2
		$PowerUpScreen/StartNextWave/CoinText.text = "Coins: %d" % coins
		
	


func _on_add_strength_pressed() -> void:
	if coins >= strengthCost:
		%Player.strength *= 1.1
		coins -= strengthCost
		strengthCost *= 2
		$PowerUpScreen/StartNextWave/CoinText.text = "Coins: %d" % coins


func _on_add_speed_pressed() -> void:
	if coins >= speedCost:
		%Player.speed *= 1.01
		coins -= speedCost
		speedCost *= 2
		$PowerUpScreen/StartNextWave/CoinText.text = "Coins: %d" % coins


func _on_start_next_wave_pressed() -> void:
	begin_wave() # Replace with function body.
