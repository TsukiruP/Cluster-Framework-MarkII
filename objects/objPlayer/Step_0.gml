/// @description Behave
state(PHASE.STEP);
if (state_changed) state_changed = false;

// Direct camera
with (objCamera)
{
	x = other.x div 1;
	y = other.y div 1;
}