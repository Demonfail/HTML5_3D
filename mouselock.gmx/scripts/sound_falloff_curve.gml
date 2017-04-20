///sound_falloff_volume( distance, min, max, bias )
//  
// With thanks to John Leffingwell (xot)

var _distance = argument0;
var _min      = argument1;
var _max      = argument2;
var _bias     = argument3;

var _volume = 1 - clamp( ( _distance - _min ) / ( _max - _min ), 0, 1 );
_volume = _volume / ( ( 1/_bias - 2 ) * ( 1 - _volume ) + 1);
return _volume;
