extends Area2D

var canShoot = true

var player: Node = null

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		if(canShoot):
			shoot()
			
	#var enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#var target_enemy = enemies_in_range[0]
		#look_at(target_enemy.global_position)

func shoot():
	canShoot = false
	%Reload.start(.15)
	const BULLET = preload("res://Bullet.tscn")
	
	var newBullet = BULLET.instantiate()
	newBullet.player = player
	newBullet.global_position = %ShootingPoint.global_position
	newBullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(newBullet)


func _on_reload_timeout() -> void:
	canShoot = true # Replace with function body.
