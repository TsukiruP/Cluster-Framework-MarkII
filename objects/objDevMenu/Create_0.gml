/// @description Initialize
image_speed = 0;
menu_index = undefined;
menu_history = [];
wip_option = new dev_option("Work in Progress!");

// Menus
home_menu = new dev_menu();

character_menu = new dev_menu([wip_option]);
sonic_menu = new dev_menu([wip_option]);
miles_menu = new dev_menu();
knuckles_menu = new dev_menu([wip_option]);
amy_menu = new dev_menu();
cream_menu = new dev_menu([wip_option]);

config_menu = new dev_menu();

// Options
var n = 0;
repeat (16) event_user(n++);