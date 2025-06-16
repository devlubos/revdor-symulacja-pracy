extends ProgressBar

onready var red_theme = preload("res://Themes/stamina_fg_red.tres")
onready var yellow_theme = preload("res://Themes/stamina_fg_yellow.tres")


func _ready():
	self.max_value = PlayerStats.Stamina.get_max_stamina()
	self.value = PlayerStats.Stamina.get_stamina()

func _process(delta):
	if PlayerStats.Stamina.is_stamina_bar_visible():
		self.visible = true
		self.value = PlayerStats.Stamina.get_stamina()
		tint_progress_bar()
	else:
		self.visible = false

func tint_progress_bar():
	if PlayerStats.Stamina.get_stamina() < PlayerStats.Stamina.get_max_stamina() * 0.3:
		add_stylebox_override("fg",red_theme)
	else:
		add_stylebox_override("fg",yellow_theme)
