extends Node

var score = 0
var served = 0
var playing = true
const TIME_LIMIT = 60
const SANDWICH_HEIGHT = 8

var breads = {
	"Bread": preload("res://scenes/ingredients/bread.tscn")
}

var ingredients = {
	"Cheese": preload("res://scenes/ingredients/cheese.tscn"),
	"Lettuce": preload("res://scenes/ingredients/lettuce.tscn"),
	"Meat": preload("res://scenes/ingredients/meat.tscn"),
	"Tomato": preload("res://scenes/ingredients/tomato.tscn"),
}

var order_patterns = {
	"1": {
		"points": 100,
		"scene": preload("res://scenes/patterns/pattern_001.tscn"),
		"ingredients": ["Bread", "Cheese", "Bread"]
	},
	"2": {
		"points": 100,
		"scene": preload("res://scenes/patterns/pattern_002.tscn"),
		"ingredients": ["Bread", "Lettuce", "Bread"]
	},
	"3": {
		"points": 100,
		"scene": preload("res://scenes/patterns/pattern_003.tscn"),
		"ingredients": ["Bread", "Meat", "Bread"]
	},
	"4": {
		"points": 100,
		"scene": preload("res://scenes/patterns/pattern_004.tscn"),
		"ingredients": ["Bread", "Tomato", "Bread"]
	},
	"5": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_005.tscn"),
		"ingredients": ["Bread", "Cheese", "Lettuce", "Meat", "Bread"]
	},
	"6": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_006.tscn"),
		"ingredients": ["Bread", "Cheese", "Cheese", "Meat", "Bread"]
	},
	"7": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_007.tscn"),
		"ingredients": ["Bread", "Cheese", "Meat", "Cheese", "Bread"]
	},
	"8": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_008.tscn"),
		"ingredients": ["Bread", "Cheese", "Tomato", "Tomato", "Bread"]
	},
	"9": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_009.tscn"),
		"ingredients": ["Bread", "Lettuce", "Tomato", "Cheese", "Bread"]
	},
	"10": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_010.tscn"),
		"ingredients": ["Bread", "Cheese", "Cheese", "Cheese", "Bread"]
	},
	"11": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_011.tscn"),
		"ingredients": ["Bread", "Cheese", "Tomato", "Cheese", "Bread"]
	},
	"12": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_012.tscn"),
		"ingredients": ["Bread", "Lettuce", "Meat", "Lettuce", "Bread"]
	},
	"13": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_013.tscn"),
		"ingredients": ["Bread", "Lettuce", "Lettuce", "Lettuce", "Bread"]
	},
	"14": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_014.tscn"),
		"ingredients": ["Bread", "Meat", "Meat", "Meat", "Bread"]
	},
	"15": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_015.tscn"),
		"ingredients": ["Bread", "Meat", "Lettuce", "Meat", "Bread"]
	},
	"16": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_016.tscn"),
		"ingredients": ["Bread", "Meat", "Bread", "Meat", "Bread"]
	},
	"17": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_017.tscn"),
		"ingredients": ["Bread", "Tomato", "Lettuce", "Lettuce", "Bread"]
	},
	"18": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_018.tscn"),
		"ingredients": ["Bread", "Tomato", "Lettuce", "Meat", "Bread"]
	},
	"19": {
		"points": 300,
		"scene": preload("res://scenes/patterns/pattern_019.tscn"),
		"ingredients": ["Bread", "Tomato", "Bread", "Lettuce", "Bread"]
	},
	"20": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_020.tscn"),
		"ingredients": ["Bread", "Cheese", "Lettuce", "Meat", "Cheese", "Tomato", "Bread"]
	},
	"21": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_021.tscn"),
		"ingredients": ["Bread", "Meat", "Lettuce", "Cheese", "Tomato", "Tomato", "Bread"]
	},
	"22": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_022.tscn"),
		"ingredients": ["Bread", "Cheese", "Lettuce", "Meat", "Meat", "Tomato", "Bread"]
	},
	"23": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_023.tscn"),
		"ingredients": ["Bread", "Cheese", "Cheese", "Lettuce", "Tomato", "Lettuce", "Bread"]
	},
	"24": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_024.tscn"),
		"ingredients": ["Bread", "Cheese", "Meat", "Tomato", "Meat", "Tomato", "Bread"]
	},
	"25": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_025.tscn"),
		"ingredients": ["Bread", "Lettuce", "Meat", "Lettuce", "Tomato", "Cheese", "Bread"]
	},
	"26": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_026.tscn"),
		"ingredients": ["Bread", "Lettuce", "Cheese", "Lettuce", "Bread", "Tomato", "Bread"]
	},
	"27": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_027.tscn"),
		"ingredients": ["Bread", "Lettuce", "Tomato", "Bread", "Meat", "Cheese", "Bread"]
	},
	"28": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_028.tscn"),
		"ingredients": ["Bread", "Lettuce", "Tomato", "Cheese", "Meat", "Lettuce", "Bread"]
	},
	"29": {
		"points": 500,
		"scene": preload("res://scenes/patterns/pattern_029.tscn"),
		"ingredients": ["Bread", "Lettuce", "Cheese", "Lettuce", "Lettuce", "Tomato", "Bread"]
	},
	"30": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_030.tscn"),
		"ingredients": ["Bread", "Cheese", "Cheese", "Cheese", "Cheese", "Cheese", "Cheese", "Bread"]
	},
	"31": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_031.tscn"),
		"ingredients": ["Bread", "Cheese", "Lettuce", "Tomato", "Meat", "Lettuce", "Tomato", "Bread"]
	},
	"32": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_032.tscn"),
		"ingredients": ["Bread", "Cheese", "Tomato", "Cheese", "Lettuce", "Meat", "Lettuce", "Bread"]
	},
	"33": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_033.tscn"),
		"ingredients": ["Bread", "Cheese", "Bread", "Lettuce", "Meat", "Bread", "Tomato", "Bread"]
	}, # 여기까지 개선완료
	"34": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_034.tscn"),
		"ingredients": ["Bread", "Lettuce", "Meat", "Tomato", "Lettuce", "Tomato", "Tomato", "Bread"]
	},
	"35": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_035.tscn"),
		"ingredients": ["Bread", "Lettuce", "Meat", "Lettuce", "Cheese", "Tomato", "Meat", "Bread"]
	},
	"36": {
		"points": 1000,
		"scene": preload("res://scenes/patterns/pattern_036.tscn"),
		"ingredients": ["Bread", "Meat", "Cheese", "Lettuce", "Tomato", "Cheese", "Meat", "Bread"]
	},
	"37": {
		"points": 100,
		"scene": preload("res://scenes/patterns/pattern_037.tscn"),
		"ingredients": ["Bread", "Tomato", "Cheese", "Meat", "Lettuce", "Tomato", "Cheese", "Bread"]
	},
	# ###################################################
	#"30": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_030.tscn"),
		#"ingredients": ["Bread", "Meat", "Cheese", "Cheese", "Tomato", "Lettuce", "Bread"]
	#},
	#"31": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_031.tscn"),
		#"ingredients": ["Bread", "Meat", "Cheese", "Tomato", "Lettuce", "Tomato", "Bread"]
	#},
	#"32": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_032.tscn"),
		#"ingredients": ["Bread", "Meat", "Lettuce", "Meat", "Tomato", "Meat", "Bread"]
	#},
	#"33": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_033.tscn"),
		#"ingredients": ["Bread", "Meat", "Meat", "Cheese", "Tomato", "Tomato", "Bread"]
	#},
	#"34": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_034.tscn"),
		#"ingredients": ["Bread", "Meat", "Tomato", "Meat", "Lettuce", "Cheese", "Bread"]
	#},
	#"35": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_035.tscn"),
		#"ingredients": ["Bread", "Tomato", "Cheese", "Cheese", "Lettuce", "Meat", "Bread"]
	#},
	#"36": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_036.tscn"),
		#"ingredients": ["Bread", "Tomato", "Lettuce", "Cheese", "Meat", "Cheese", "Bread"]
	#},
	#"37": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_037.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Meat", "Cheese", "Tomato", "Bread"]
	#},
	#"38": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_038.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Lettuce", "Cheese", "Meat", "Bread"]
	#},
	#"39": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_039.tscn"),
		#"ingredients": ["Bread", "Tomato", "Tomato", "Tomato", "Tomato", "Tomato", "Bread"]
	#},
	#"40": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_040.tscn"),
		#"ingredients": ["Bread", "Cheese", "Cheese", "Cheese", "Cheese", "Cheese", "Cheese", "Bread"]
	#},
	#"41": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_041.tscn"),
		#"ingredients": ["Bread", "Cheese", "Lettuce", "Tomato", "Meat", "Lettuce", "Tomato", "Bread"]
	#},
	#"42": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_042.tscn"),
		#"ingredients": ["Bread", "Cheese", "Tomato", "Cheese", "Lettuce", "Meat", "Lettuce", "Bread"]
	#},
	#"43": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_043.tscn"),
		#"ingredients": ["Bread", "Cheese", "Cheese", "Tomato", "Meat", "Tomato", "Cheese", "Bread"]
	#},
	#"44": {
		#"points": 500,
		#"scene": preload("res://scenes/patterns/pattern_044.tscn"),
		#"ingredients": ["Bread", "Cheese", "Lettuce", "Meat", "Cheese", "Tomato", "Meat", "Bread"]
	#},
	#"45": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_045.tscn"),
		#"ingredients": ["Bread", "Cheese", "Meat", "Meat", "Cheese", "Lettuce", "Tomato", "Bread"]
	#},
	#"46": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_046.tscn"),
		#"ingredients": ["Bread", "Cheese", "Meat", "Lettuce", "Tomato", "Meat", "Lettuce", "Bread"]
	#},
	#"47": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_047.tscn"),
		#"ingredients": ["Bread", "Cheese", "Tomato", "Lettuce", "Meat", "Meat", "Tomato", "Bread"]
	#},
	#"48": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_048.tscn"),
		#"ingredients": ["Bread", "Cheese", "Lettuce", "Cheese", "Lettuce", "Cheese", "Lettuce", "Bread"]
	#},
	#"49": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_049.tscn"),
		#"ingredients": ["Bread", "Cheese", "Meat", "Cheese", "Meat", "Cheese", "Lettuce", "Bread"]
	#},
	#"50": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_050.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Lettuce", "Lettuce", "Lettuce", "Lettuce", "Lettuce", "Bread"]
	#},
	#"51": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_051.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Cheese", "Meat", "Meat", "Lettuce", "Lettuce", "Bread"]
	#},
	#"52": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_052.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Cheese", "Tomato", "Lettuce", "Meat", "Tomato", "Bread"]
	#},
	#"53": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_053.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Lettuce", "Meat", "Cheese", "Lettuce", "Lettuce", "Bread"]
	#},
	#"54": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_054.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Meat", "Meat", "Meat", "Cheese", "Tomato", "Bread"]
	#},
	#"55": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_055.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Cheese", "Cheese", "Cheese", "Lettuce", "Lettuce", "Bread"]
	#},
	#"56": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_056.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Tomato", "Meat", "Lettuce", "Cheese", "Cheese", "Bread"]
	#},
	#"57": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_057.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Tomato", "Cheese", "Tomato", "Lettuce", "Tomato", "Bread"]
	#},
	#"58": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_058.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Meat", "Tomato", "Lettuce", "Tomato", "Tomato", "Bread"]
	#},
	#"59": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_059.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Meat", "Lettuce", "Cheese", "Tomato", "Meat", "Bread"]
	#},
	#"60": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_060.tscn"),
		#"ingredients": ["Bread", "Meat", "Meat", "Meat", "Meat", "Meat", "Meat", "Bread"]
	#},
	#"61": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_061.tscn"),
		#"ingredients": ["Bread", "Meat", "Cheese", "Lettuce", "Tomato", "Cheese", "Meat", "Bread"]
	#},
	#"62": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_062.tscn"),
		#"ingredients": ["Bread", "Meat", "Cheese", "Cheese", "Meat", "Cheese", "Cheese", "Bread"]
	#},
	#"63": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_063.tscn"),
		#"ingredients": ["Bread", "Meat", "Meat", "Lettuce", "Tomato", "Tomato", "Cheese", "Bread"]
	#},
	#"64": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_064.tscn"),
		#"ingredients": ["Bread", "Meat", "Meat", "Tomato", "Cheese", "Cheese", "Lettuce", "Bread"]
	#},
	#"65": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_065.tscn"),
		#"ingredients": ["Bread", "Meat", "Lettuce", "Meat", "Cheese", "Tomato", "Tomato", "Bread"]
	#},
	#"66": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_066.tscn"),
		#"ingredients": ["Bread", "Meat", "Lettuce", "Tomato", "Meat", "Meat", "Cheese", "Bread"]
	#},
	#"67": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_067.tscn"),
		#"ingredients": ["Bread", "Meat", "Tomato", "Cheese", "Lettuce", "Meat", "Lettuce", "Bread"]
	#},
	#"68": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_068.tscn"),
		#"ingredients": ["Bread", "Meat", "Tomato", "Lettuce", "Lettuce", "Lettuce", "Cheese", "Bread"]
	#},
	#"69": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_069.tscn"),
		#"ingredients": ["Bread", "Meat", "Tomato", "Tomato", "Cheese", "Cheese", "Meat", "Bread"]
	#},
	#"70": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_070.tscn"),
		#"ingredients": ["Bread", "Tomato", "Tomato", "Tomato", "Tomato", "Tomato", "Tomato", "Bread"]
	#},
	#"71": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_071.tscn"),
		#"ingredients": ["Bread", "Tomato", "Cheese", "Meat", "Lettuce", "Tomato", "Cheese", "Bread"]
	#},
	#"72": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_072.tscn"),
		#"ingredients": ["Bread", "Tomato", "Cheese", "Cheese", "Lettuce", "Meat", "Tomato", "Bread"]
	#},
	#"73": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_073.tscn"),
		#"ingredients": ["Bread", "Tomato", "Cheese", "Lettuce", "Lettuce", "Meat", "Meat", "Bread"]
	#},
	#"74": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_074.tscn"),
		#"ingredients": ["Bread", "Tomato", "Lettuce", "Tomato", "Meat", "Cheese", "Lettuce", "Bread"]
	#},
	#"75": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_075.tscn"),
		#"ingredients": ["Bread", "Tomato", "Lettuce", "Cheese", "Meat", "Cheese", "Meat", "Bread"]
	#},
	#"76": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_076.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Lettuce", "Cheese", "Tomato", "Tomato", "Bread"]
	#},
	#"77": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_077.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Cheese", "Lettuce", "Meat", "Lettuce", "Bread"]
	#},
	#"78": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_078.tscn"),
		#"ingredients": ["Bread", "Tomato", "Tomato", "Cheese", "Meat", "Cheese", "Lettuce", "Bread"]
	#},
	#"79": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_079.tscn"),
		#"ingredients": ["Bread", "Tomato", "Tomato", "Lettuce", "Cheese", "Tomato", "Lettuce", "Bread"]
	#},
	#"80": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_080.tscn"),
		#"ingredients": ["Bread", "Cheese", "Cheese", "Cheese", "Lettuce", "Tomato", "Tomato", "Lettuce", "Lettuce", "Bread"]
	#},
	#"81": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_081.tscn"),
		#"ingredients": ["Bread", "Cheese", "Meat", "Cheese", "Cheese", "Tomato", "Lettuce", "Meat", "Cheese", "Bread"]
	#},
	#"82": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_082.tscn"),
		#"ingredients": ["Bread", "Cheese", "Lettuce", "Lettuce", "Lettuce", "Meat", "Cheese", "Meat", "Cheese", "Bread"]
	#},
	#"83": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_083.tscn"),
		#"ingredients": ["Bread", "Cheese", "Meat", "Cheese", "Meat", "Cheese", "Meat", "Cheese", "Meat", "Bread"]
	#},
	#"84": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_084.tscn"),
		#"ingredients": ["Bread", "Cheese", "Lettuce", "Tomato", "Meat", "Meat", "Cheese", "Tomato", "Lettuce", "Bread"]
	#},
	#"85": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_085.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Lettuce", "Lettuce", "Lettuce", "Lettuce", "Cheese", "Meat", "Cheese", "Bread"]
	#},
	#"86": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_086.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Meat", "Meat", "Meat", "Cheese", "Tomato", "Tomato", "Lettuce", "Bread"]
	#},
	#"87": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_087.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Tomato", "Lettuce", "Meat", "Tomato", "Lettuce", "Cheese", "Lettuce", "Bread"]
	#},
	#"88": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_088.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Cheese", "Cheese", "Lettuce", "Meat", "Tomato", "Tomato", "Tomato", "Bread"]
	#},
	#"89": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_089.tscn"),
		#"ingredients": ["Bread", "Lettuce", "Tomato", "Meat", "Tomato", "Tomato", "Cheese", "Tomato", "Lettuce", "Bread"]
	#},
	#"90": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_090.tscn"),
		#"ingredients": ["Bread", "Meat", "Meat", "Lettuce", "Meat", "Meat", "Cheese", "Meat", "Tomato", "Bread"]
	#},
	#"91": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_091.tscn"),
		#"ingredients": ["Bread", "Meat", "Lettuce", "Lettuce", "Tomato", "Cheese", "Meat", "Cheese", "Meat", "Bread"]
	#},
	#"92": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_092.tscn"),
		#"ingredients": ["Bread", "Meat", "Cheese", "Tomato", "Lettuce", "Cheese", "Tomato", "Lettuce", "Meat", "Bread"]
	#},
	#"93": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_093.tscn"),
		#"ingredients": ["Bread", "Meat", "Lettuce", "Cheese", "Cheese", "Cheese", "Cheese", "Tomato", "Tomato", "Bread"]
	#},
	#"94": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_094.tscn"),
		#"ingredients": ["Bread", "Meat", "Cheese", "Meat", "Lettuce", "Lettuce", "Meat", "Cheese", "Lettuce", "Bread"]
	#},
	#"95": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_095.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Lettuce", "Cheese", "Cheese", "Meat", "Lettuce", "Cheese", "Bread"]
	#},
	#"96": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_096.tscn"),
		#"ingredients": ["Bread", "Tomato", "Lettuce", "Lettuce", "Lettuce", "Lettuce", "Tomato", "Tomato", "Tomato", "Bread"]
	#},
	#"97": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_097.tscn"),
		#"ingredients": ["Bread", "Tomato", "Lettuce", "Meat", "Cheese", "Lettuce", "Tomato", "Meat", "Cheese", "Bread"]
	#},
	#"98": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_098.tscn"),
		#"ingredients": ["Bread", "Tomato", "Tomato", "Tomato", "Cheese", "Cheese", "Meat", "Cheese", "Cheese", "Bread"]
	#},
	#"99": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_099.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Lettuce", "Cheese", "Tomato", "Tomato", "Lettuce", "Meat", "Bread"]
	#},
	#"100": {
		#"points": 100,
		#"scene": preload("res://scenes/patterns/pattern_100.tscn"),
		#"ingredients": ["Bread", "Tomato", "Meat", "Tomato", "Tomato", "Lettuce", "Cheese", "Cheese", "Meat", "Bread"]
	#}
}
