extends CharacterBody2D

var health = 100
var dir = 1
var isKnockback = false
var knockbackTime = .5
var knockbackElapsed = 0.0

@onready var player = get_node("/root/Game/Player")

signal dead

func _physics_process(delta: float) -> void:
	#If there is knockback
	if(isKnockback):
		#increment knockbackElpased by the time that has passed
		knockbackElapsed += delta
		
		#Get the percentage of time elapsed
		var t = clamp(knockbackElapsed / knockbackTime, 0, 1)
		
		dir = lerp(-1.0, 1.0, t)
		
		if(t >= 1):
			isKnockback = false
		
	var direction = dir * global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()
	
func _ready(): 
	%Slime.play_walk()
	
func take_damage(strength):
	health -= strength
	%Slime.play_hurt()
	
	
	if health <= 0:
		emit_signal("dead")
		remove_from_group("enemies")
		queue_free()
		const SMOKESCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKESCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
	else:
		isKnockback = true
		
		
		
	
		
