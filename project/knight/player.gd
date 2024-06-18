class_name Player
extends CharacterBody2D

signal HEALTH_LOST(total_percentage: float)

const _SPEED = 300.0
const _JUMP_VELOCITY = -600.0
const _MAX_HEALTH = 100.0
const _DAMAGE_AMOUNT = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _facing_left := false
var _health := _MAX_HEALTH

@onready var _hat : Sprite2D = $Hat
@onready var _sword : Sword = $Sword

func _ready():
	_sword.player = $"."

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)

	# Face direction
	if Input.is_action_just_pressed("move_left") and not _facing_left:
		_hat.position.x *= -1
		_sword.position.x *= -1
		_sword.facing_left = true
		_hat.flip_h = true
		_facing_left = true
	if Input.is_action_just_pressed("move_right") and _facing_left:
		_hat.position.x *= -1
		_sword.position.x *= -1
		_sword.facing_left = false
		_hat.flip_h = false
		_facing_left = false

	move_and_slide()



func _on_damage_area_area_entered(_area):
	_health -= _DAMAGE_AMOUNT
	var health_percentage : float = _health / _MAX_HEALTH
	HEALTH_LOST.emit(health_percentage)
	if _health <= 0:
		print ("auhhhh i die")
