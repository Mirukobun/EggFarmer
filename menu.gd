extends Control

@onready var title: Label = $Center/Box/Title
@onready var result: Label = $Center/Box/Result
@onready var highscore: Label = $Center/Box/Highscore
@onready var start_button: Button = $Center/Box/StartButton
@onready var quit_button: Button = $Center/Box/QuitButton
@onready var instructions: Label = $Center/Box/Instructions


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	var instructions := Label.new()
	instructions.text = "Collect 5 eggs! Avoid the chickens!"
	instructions.add_theme_font_size_override("font_size", 32)
	instructions.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Center/Box.add_child(instructions)
	$Center/Box.move_child(instructions, title.get_index() + 1)

	highscore.text = "Highscore: " + str(Global.highscore)
	result.hide()

	if Global.played:
		instructions.hide()
		if Global.lose:
			title.text = "You lose!"
		else:
			title.text = "You win!"
		result.text = "Score: " + str(Global.last_score)
		result.show()
		start_button.text = "Try again"
		if Global.new_highscore:
			highscore.text = "New highscore: " + str(Global.highscore)
			highscore.add_theme_color_override("font_color", Color.RED)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://points.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
