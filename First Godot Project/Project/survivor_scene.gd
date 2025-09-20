extends Node2D


var mobsToSpawn = 15
var mobsToKill = 15
var wave = 0
var enemiesDied = 0


func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	#Add mob to group enemies to track how many are alive
	new_mob.add_to_group("enemies")
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
		
		wave += 1
		mobsToSpawn = 15 + (wave * 15)
		get_tree().paused = true
	
	
func begin_wave():
	print("Beginning wave")
	
