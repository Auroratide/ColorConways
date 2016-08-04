package com.auroratide.color_conways;

import com.auroratide.color_conways.util.ColorAverager;

/**
 *  ConwaysGameOfLife Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class ConwaysGameOfLife {

/*  Constructor
 *  =========================================================================*/
    public function new(grid:ColorConwayGrid) {
        this.grid = grid;
    }
 
/*  Public Methods
 *  =========================================================================*/
//  Should be refactored, but it's a small project
//  Also very inefficient for game of life, but since we're simulating data structures, it's fine
    public function next():Void {
        var bounds = grid.bounds();
        var commands = new Array<Void->Void>();
        
        for (x in (bounds.minX - 1)...(bounds.maxX + 1)) {
            for (y in (bounds.minY - 1)...(bounds.maxY + 1)) {
                var neighbors = neighbors(x, y);
                if (!grid.isAlive(x, y)) {
                    if(neighbors.count == 3)
                        commands.push(grid.revive.bind(x, y, neighbors.color));
                }
                else {
                    if (!(neighbors.count == 2 || neighbors.count == 3))
                        commands.push(grid.kill.bind(x, y));
                }
            }
        }
        for (command in commands)
            command();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var grid:ColorConwayGrid;
 
/*  Private Methods
 *  =========================================================================*/
    private function neighbors(x:Int, y:Int):Neighbors {
        var neighbors = new Neighbors(0, 0xFFFFFF);
        var colors = new ColorAverager();
        
        for (i in -1...2) for (j in -1...2) {
            if (grid.isAlive(x + i, y + j) && !(i == 0 && j == 0)) {
                neighbors.count = neighbors.count + 1;
                colors.add(grid.colorOf(x + i, y + j));
            }
        }
        
        neighbors.color = colors.average();
        return neighbors;
    }
}

/**
 *  Since neighbor count is bounded by [0, 8] and color is bounded by [0, 0xFFFFFF],
 *  we can actually store them into the same integer.  It's just a little more
 *  efficient than needing a whole class, and since Haxe has abstracts, we can
 *  still abstract the concept so it behaves like a class would.
 */
private abstract Neighbors(Int) from Int to Int {
    public var count(get, set):Int;
    public var color(get, set):Int;
    
    public inline function new(?count = 0, ?color = 0)
        this = (count << 24) | (color & 0xFFFFFF);
    
    private inline function get_count():Int
        return this >> 24;
    private inline function set_count(value:Int):Int {
        this = (this & 0xFFFFFF) | (value << 24);
        return value;
    }
    
    private inline function get_color():Int
        return this & 0xFFFFFF;
    private inline function set_color(value:Int):Int {
        this = (this & 0xFF000000) | value;
        return value;
    }
}