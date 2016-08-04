package com.auroratide.color_conways.util;

/**
 *  ColorAverager Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class ColorAverager {

/*  Constructor
 *  =========================================================================*/
    public function new() {
        colors = new Array<Color>();
    }
    
/*  Public Methods
 *  =========================================================================*/
    public function add(color:Int):Void {
        colors.push(color);
    }
    
    public function average():Int {
        var rsum = 0;
        var gsum = 0;
        var bsum = 0;
        for (color in colors) {
            rsum += color.r * color.r;
            gsum += color.g * color.g;
            bsum += color.b * color.b;
        }
        var newR = Math.round(Math.sqrt(rsum / colors.length));
        var newG = Math.round(Math.sqrt(gsum / colors.length));
        var newB = Math.round(Math.sqrt(bsum / colors.length));
        return Color.fromRGB(newR, newG, newB);
    }
 
/*  Private Members
 *  =========================================================================*/
    private var colors:Array<Color>;
}

private abstract Color(Int) from Int to Int {
    public var r(get, never):Int;
    public var g(get, never):Int;
    public var b(get, never):Int;
    
    public static function fromRGB(r:Int, g:Int, b:Int):Color
        return (r << 16) | (g << 8) | b;
    
    private inline function get_r():Int
        return shift(16);
    private inline function get_g():Int
        return shift(8);
    private inline function get_b():Int
        return shift(0);
    
    private inline function shift(by:Int):Int
        return (this >> by) & 0xFF;
    
}