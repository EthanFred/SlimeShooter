extends Area2D


var travelled_distance = 0
var player: Node = null


func _ready():
	player = get_tree().get_root().get_node("Game/Player")
	
func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance = SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
	

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage") and player:
		var damage = player.get_damage()
		body.take_damage(damage)
		
