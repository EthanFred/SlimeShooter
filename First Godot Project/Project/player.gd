class_name Player

extends CharacterBody2D

signal health_depleted
var health = 100.0
var maxHealth = 100.0
var speed = 1.0
var strength = 10.0
var coins = 24


func _ready():
	add_to_group("player")
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600 * speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	const DAMAGERATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs:
		health -= DAMAGERATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		
		if health <= 0.0:
			health_depleted.emit()

func get_damage() -> float:
	return strength
	
func set_maxHealth():
	%ProgressBar.max_value = maxHealth
	
		
