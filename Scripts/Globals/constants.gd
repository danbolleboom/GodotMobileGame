extends Node

var menuSpeed: float = 5.0
var baseSpeed: float = 15.0;
var currentSpeed: float = 100.0;
var enemyDeadCallback: Callable;
var gameStateChangedCallback: Callable;
var gameActive: bool = false;
var gameDirector: Node;
var uiManager: Node;
