extends CharacterBody2D

@export var speed : float = 300.0

@onready var run_sprite: AnimatedSprite2D = $run
@onready var idle_sprite: AnimatedSprite2D = $idle

var posToGoTo : Vector2

func _ready() -> void:
	posToGoTo = global_position
	run_sprite.hide()
	idle_sprite.show()
	idle_sprite.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var area := Global.view_rect().grow(-40)
		posToGoTo = get_global_mouse_position().clamp(area.position, area.end)

func _physics_process(delta: float) -> void:
	var to_target = posToGoTo - global_position

	if to_target.length() > 5.0:
		velocity = to_target.normalized() * speed

		idle_sprite.hide()
		run_sprite.show()
		run_sprite.play()

		if abs(velocity.x) > 0.1:
			run_sprite.flip_h = velocity.x < 0
			idle_sprite.flip_h = velocity.x < 0
	else:
		velocity = Vector2.ZERO

		run_sprite.hide()
		idle_sprite.show()
		idle_sprite.play()

	move_and_slide()
