extends Control

@export var character_scenes: Array[PackedScene] = []
@export var character_names: Array[String] = ["Penguin", "Fox"]
@export var character_portraits: Array[Texture2D] = []

var current_index: int = 0

@onready var title_screen: Control = $TitleScreen
@onready var character_select: Control = $CharacterSelect
@onready var character_image: TextureRect = $CharacterSelect/CharacterImage
@onready var character_name: Label = $CharacterSelect/CharacterName

func _ready() -> void:
	title_screen.visible = true
	character_select.visible = false
	update_display()

func update_display() -> void:
	if character_names.size() > current_index:
		character_name.text = character_names[current_index]
	if character_portraits.size() > current_index:
		character_image.texture = character_portraits[current_index]

func _on_start_button_pressed() -> void:
	title_screen.visible = false
	character_select.visible = true

func _on_left_button_pressed() -> void:
	current_index -= 1
	if current_index < 0:
		current_index = character_names.size() - 1
	update_display()

func _on_right_button_pressed() -> void:
	current_index += 1
	if current_index >= character_names.size():
		current_index = 0
	update_display()

func _on_play_button_pressed() -> void:
	if character_scenes.size() > current_index:
		Global.selected_character = character_scenes[current_index]
	get_tree().change_scene_to_file("res://level_1.tscn")
	
	#hello world
