/// @description Hitboxes
with (objZoneObject) draw_hitboxes();
with (objSpring) draw_text(x, y, angle_difference(direction, global.players[0].gravity_direction));