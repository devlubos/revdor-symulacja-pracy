extends Node

onready var version_label: Label = get_node("CanvasMenu/VersionLabel")

func _ready():
	version_label.text = 'Version 1.0'

func _on_StartButton_pressed():
	get_tree().change_scene("res://main.tscn")


func _on_OptionsButton_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
