package com.auroratide.color_conways;

import com.auroratide.color_conways.grid.Grid;

/**
 *  ColorConwayGrid Abstraction
 *  @author Timothy Foster (tfAuroratide)
 * 
 *  An abstraction of a grid to represent the color Conway grid.
 * 
 *  @usage var grid:ColorConwayGrid = new GridChunkList<Null<Int>>();
 */
@:forward(bounds)
abstract ColorConwayGrid(Grid<Int>) from Grid<Int> to Grid<Int> {
    public static inline var DEAD_COLOR = 0;

    public inline function isAlive(x:Int, y:Int):Bool
        return this.exists(x, y);
    
    public inline function colorOf(x:Int, y:Int):Int
        return this.get(x, y);
    
    public inline function kill(x:Int, y:Int):Void
        this.remove(x, y);
    
    public inline function revive(x:Int, y:Int, color:Int):Void
        this.set(x, y, color);
}
