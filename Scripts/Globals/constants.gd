extends Node

var menuSpeed: float = 5.0
var baseSpeed: float = 12.0;
var currentSpeed: float = 100.0;
var enemyDeadCallback: Callable;
var gameStateChangedCallback: Callable;
var gameActive: bool = false;
var gameDirector: Node;
var uiManager: Node;
var player: Node;
var selectedAttack1: PackedScene = null;
var selectedAttack2: PackedScene = null;
var selectedAttack3: PackedScene = null;
var worldTimeScale: int = 1;

func LoadScenesInFile(path: String) -> Array[PackedScene]:
	var array: Array[PackedScene];
	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin();
		var fileName = dir.get_next();
		while fileName != "":
			if !dir.current_is_dir():
				if fileName.get_extension() == "tscn":
					var fullPath = path.path_join(fileName);
					array.append(load(fullPath))
			fileName = dir.get_next();
	
	return array;
