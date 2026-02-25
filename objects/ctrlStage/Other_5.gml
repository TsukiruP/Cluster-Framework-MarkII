/// @description Finish
if (not (ctrlGame.game_flags & GAME_FLAG_KEEP_SCORE)) global.score_count = 0;
global.ring_count = 0;
global.ring_life_threshold = RING_LIFE_BASE_THRESHOLD;