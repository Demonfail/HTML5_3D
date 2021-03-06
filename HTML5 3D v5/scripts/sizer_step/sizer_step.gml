if ( global.sizer_no_flip > 0 ) {
	
    global.sizer_no_flip--;
	
} else if ( global.on_browser ) {
	
	var _browser_w = browser_width;
	var _browser_h = browser_height;
	var _force = keyboard_check_pressed( ord( "J" ) );
	
	if ( js_call("resized") ) or ( global.sizer_last_room != room ) or ( global.sizer_do_refresh ) or ( _force ) {
		
	    global.sizer_do_refresh = false;
	    global.sizer_browser_width = _browser_w;
	    global.sizer_browser_height = _browser_h;
	    global.sizer_last_room = room;
		
	    var _game_w = game_width();
	    var _game_h = game_height();
	    var _game_w_old = _game_w;
	    var _game_h_old = _game_h;
		
	    global.sizer_do_flip = ( ( global.sizer_browser_width/global.sizer_browser_height > 1 ) != ( _game_w_old/_game_h_old > 1 ) );
    
		if ( ( global.on_mobile ) and ( global.sizer_do_flip ) ) or ( _force ) {
			
			if ( global.sizer_priority != 0 ) global.sizer_priority = 3 - global.sizer_priority;
			
			if ( room == rm_flip ) {
				room_goto( global.sizer_return_room );
			} else {
				instance_deactivate_all( true );
				global.sizer_return_room = room;
				room_persistent = true;
				room_goto( rm_flip );
			}
			
		}
		
	    var _x_scale = global.sizer_browser_width / _game_w;
	    var _y_scale = global.sizer_browser_height / _game_h;
	    if ( global.sizer_priority == 1 ) _y_scale = _x_scale;
	    if ( global.sizer_priority == 2 ) _x_scale = _y_scale;
    
	    if ( global.sizer_max_x_scale != 0 ) _x_scale = min( _x_scale, global.sizer_max_x_scale );
	    if ( global.sizer_min_x_scale != 0 ) _x_scale = max( _x_scale, global.sizer_min_x_scale );
	    if ( global.sizer_max_y_scale != 0 ) _y_scale = min( _y_scale, global.sizer_max_y_scale );
	    if ( global.sizer_min_y_scale != 0 ) _y_scale = max( _y_scale, global.sizer_min_y_scale );
	    _game_w *= _x_scale;
	    _game_h *= _y_scale;
	
	    if ( MAX_WIDTH  != 0 ) and ( _game_w > MAX_WIDTH  ) _game_w = MAX_WIDTH;
	    if ( MAX_HEIGHT != 0 ) and ( _game_h > MAX_HEIGHT ) _game_h = MAX_HEIGHT;
    
	    _x_scale = _game_w / _game_w_old;
	    _y_scale = _game_h / _game_h_old;
    
	    if ( PROPORTIONAL ) {
	        _x_scale = min( _x_scale, _y_scale );
	        _y_scale = _x_scale;
	    }
		
	    _game_w = round( _game_w_old * _x_scale );
	    _game_h = round( _game_h_old * _y_scale );
		
	    var _left = ALIGN_H*0.5*( browser_width - _game_w );
	    var _top = 1 + ALIGN_V*0.5*( browser_height - _game_h );
		
	    if ( RESTRICT_H > 0 ) _left = max( _left, 0 );
	    if ( RESTRICT_H < 0 ) _left = min( _left, global.sizer_browser_width - _game_w );
	    if ( RESTRICT_V > 0 ) _top = max( _top, 0 );
	    if ( RESTRICT_V < 0 ) _top = min( _top, global.sizer_browser_height - _game_h );
    
	    window_set_position( _left, _top );
		if ( global.on_browser ) global.sizer_dpi = js_call( "dpi_scale" );
		window_set_size( global.sizer_dpi*_game_w, global.sizer_dpi*_game_h );
		js_call3( "set_size", window_handle(), _game_w, _game_h );
	
	}

}
/*
if ( room == rm_audio ) {
	if ( global.on_mobile ) {
		
		if ( mouse_get_released(0) ) {
			audio_master_gain( mouse_get_x(0) < room_width div 2 );
			room_goto_next();
		}
		
	} else {
		
		audio_master_gain( 1 );
		room_goto_next();
		
	}
}
*/
if ( !global.on_mobile ) and ( global.on_browser ) {
	
    var _game_w = game_width();
    var _game_h = game_height();
    var _disp_w = display_get_width();
    var _disp_h = display_get_height();
	
    var _factor = min( _disp_w/_game_w, _disp_h/_game_h, SCALE_FACTOR );
    var _w = floor( _game_w*_factor );
    var _h = floor( _game_h*_factor );
	
    window_set_position( ( _disp_w - _w ) div 2, ( _disp_h - _h ) div 2 );
	global.sizer_dpi = js_call( "dpi_scale" );
	window_set_size( global.sizer_dpi*_game_w, global.sizer_dpi*_h );
	js_call3( "set_size", window_handle(), _w, _h );;
	
}
