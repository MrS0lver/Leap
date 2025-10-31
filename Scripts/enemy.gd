extends Node2D

@export var EnemySpeed = 60
var direction  = 1

@onready var left: RayCast2D = $LEFT
@onready var right: RayCast2D = $RIGHT
@onready var enemy_animation: AnimatedSprite2D = $"Enemy Animation"


func _process(delta: float) -> void:
	if right.is_colliding():
		direction = -1
		enemy_animation.flip_h = true
	if left.is_colliding():
		direction = 1
		enemy_animation.flip_h = false
		
		
	position.x += direction * EnemySpeed * delta
