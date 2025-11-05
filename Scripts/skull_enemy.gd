extends Node2D

@export var EnemySpeed = 60
var direction  = 1

@onready var enemy_animation: AnimatedSprite2D = $"Enemy Animation"
@onready var right: RayCast2D = $RIGHT
@onready var left: RayCast2D = $LEFT



func _process(delta: float) -> void:
	if left.is_colliding():
		direction = -1
		enemy_animation.flip_h = true
	if right.is_colliding():
		direction = 1
		enemy_animation.flip_h = false
		
		
	position.x += direction * EnemySpeed * delta


func _on_kill_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(1)

	
