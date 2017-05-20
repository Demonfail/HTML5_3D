/// @description gamepad_button_check_pressed_any()
/// @function gamepad_button_check_pressed_any

var _button = argument0;

for( var _i = 0; _i < 12; _i++ ) {
	if ( !gamepad_is_connected( _i ) ) continue;
	if ( gamepad_button_check_pressed( _i, _button ) ) return true;
}

return false;
