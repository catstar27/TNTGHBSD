extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
@onready var screen_size = get_viewport_rect().size
var fuel = 100
var velocity
var is_alive = true
signal hit
signal fuel_amount(fuel)

func start(pos):
	is_alive = true
	scale = Vector2(2.5,2.5)
	fuel = 100
	position = pos
	$Explosion.hide()
	show()
	$CollisionPolygon2D.disabled = false
	$FuelUseTimer.start()

func _physics_process(delta):
	if is_alive != false:
		velocity = Vector2.ZERO
		if Input.is_action_pressed("move_up"):
			velocity.y += -1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_left"):
			velocity.x += -1
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		if velocity != Vector2(0,0):
			$MovingSprite.show()
			$StillSprite.hide()
			look_at(Vector2(position.x-velocity.y,position.y+velocity.x))
		elif velocity == Vector2(0,0):
			$StillSprite.show()
			$MovingSprite.hide()
		fuel_amount.emit(fuel)

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
		is_alive = false
		$Explosion.show()
		$Explosion/ExplosionAnimation.play("explode")
		$DeathSound.play()

func refuel():
	fuel = 100

func fuel_use():
	if fuel > 1:
		fuel -= 10
	else:
		is_alive = false
		$Explosion.show()
		$Explosion/ExplosionAnimation.play("explode")
		$DeathSound.play()

func death():
	hide()
	hit.emit()
	$CollisionPolygon2D.set_deferred("disabled", true)
	$FuelUseTimer.stop()
