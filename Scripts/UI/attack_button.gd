extends Control

var attackTscn: PackedScene;

func SetAttack(_attack: PackedScene) -> void:
	var attackTemp = load(_attack.resource_path).instantiate();
	
	var nameText: Label = $NameText;
	
	var data = attackTemp.get_node("AttackData");
	nameText.text = data.attackName;
	
	attackTscn = _attack;
	
	attackTemp.queue_free();


func _on_button_button_up() -> void:
	Constants.selectedAttack = attackTscn;
