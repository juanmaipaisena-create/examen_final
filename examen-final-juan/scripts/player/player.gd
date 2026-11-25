extends CharacterBody2D

# Movimiento
@export var speed: float = 150.0
@export var jump_velocity: float = -320.0

# Gravedad
var gravity: float = 980.0

@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Obtener dirección horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Orientar personaje
	if direction != 0:
		sprite.flip_h = direction < 0

	# Actualizar animación
	update_animation()

	# Aplicar movimiento
	move_and_slide()

func update_animation() -> void:
	#si no esta en el suelo
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("Jump")
		else:
			sprite.play("Fall")
	elif abs(velocity.x) > 0:
		sprite.play("Run")
	else:
		sprite.play("Idle")
