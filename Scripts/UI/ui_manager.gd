extends Node

@onready var menu: Node = $MainMenu
@onready var game: Node = $GameUI
@onready var end: Node = $GameOver
@onready var director: Node = get_tree().root.get_node("World/GameDirector")

var initialised: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.process_mode = Node.PROCESS_MODE_DISABLED;
	game.hide();
	Constants.uiManager = self;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_up() -> void:
	menu.hide();
	game.show();
	game.process_mode = Node.PROCESS_MODE_INHERIT;
	director.StartGame();

func PlayerDie() -> void:
	game.hide();
	end.show();

func _on_retry_button_up() -> void:
	end.hide();
	game.show();
	director.StartGame();


func _on_to_menu_button_up() -> void:
	end.hide();
	menu.show();
