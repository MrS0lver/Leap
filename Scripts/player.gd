#extends CharacterBody2D
#
#
#const Walk_Speed = 300.0
#const JUMP_VELOCITY = -400.0
#@export var Run_Speed = 500
#@export_range(0,1) var acc = 0.1
#@export_range(0,1) var dec = 0.1
#@onready var player_animation: AnimatedSprite2D = $PlayerAnimation
#
#
#
#
#func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
#
	#if Input.is_action_just_pressed("JUMP") and (is_on_floor() or is_on_wall()):
		#velocity.y = JUMP_VELOCITY
		#if is_on_wall() and not is_on_floor():
			#player_animation.play("Wall")
	#
	#var speed
	#if Input.is_action_pressed("RUN") and not is_on_wall():
		#speed = Run_Speed
	#else:
		#speed = Walk_Speed
	#if is_on_wall() and not is_on_floor():
		#player_animation.play("Wall")
#
	#var direction := Input.get_axis("LEFT", "RIGHT")
	#if direction < 0:
		#player_animation.flip_h = true
	#if direction > 0:
		#player_animation.flip_h = false
		#
	#if is_on_floor():	
		#if direction == 0:
			#player_animation.play("Idle")
		#else:
			#player_animation.play("Run")
	#else:
		#player_animation.play("Jump")
		#
	#if direction:
		#velocity.x = move_toward(velocity.x, speed * direction, speed * acc)
		#player_animation.play("Run")
	#else:
		#velocity.x = move_toward(velocity.x, speed * direction, speed)
		##player_animation.play("Run")
#
	#move_and_slide()
#
#
#
#
#


extends CharacterBody2D

const Walk_Speed = 150.0
const JUMP_VELOCITY = -350.0
@export var Run_Speed = 300
@export_range(0,1) var acc = 0.1
@export_range(0,1) var dec = 0.1
const PUSH_FORCE = 100.0

@onready var player_animation: AnimatedSprite2D = $PlayerAnimation

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump + Wall Jump
	if Input.is_action_just_pressed("JUMP") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is RigidBody2D:
			# Apply impulse in the direction you are pushing
			body.apply_central_impulse(-collision.get_normal() * PUSH_FORCE)
	# Run / Walk Speed
	var speed
	if Input.is_action_pressed("RUN") and not is_on_wall():
		speed = Run_Speed
	else:
		speed = Walk_Speed

	# Movement Input
	var direction := Input.get_axis("LEFT", "RIGHT")
	if direction < 0:
		player_animation.flip_h = true
	elif direction > 0:
		player_animation.flip_h = false

	# ✅ Animation Priority Fix
	if is_on_wall() and not is_on_floor():
		player_animation.play("Wall")

	elif not is_on_floor():
		player_animation.play("Jump")

	elif direction == 0:
		player_animation.play("Idle")

	else:
		player_animation.play("Run")

	# Horizontal Movement (no animation override here ✅)
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, speed * acc)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * dec)

	move_and_slide()
