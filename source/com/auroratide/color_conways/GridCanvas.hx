package com.auroratide.color_conways;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 *  GridCanvas Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class GridCanvas extends FlxTypedGroup<FlxSprite> {
    public static inline var CELL_WIDTH = 8;

/*  Constructor
 *  =========================================================================*/
    public function new() {
        super();
        buffer = new Array<FlxSprite>();
        position = 0;
    }
    
/*  Class Methods
 *  =========================================================================*/
    
 
/*  Public Methods
 *  =========================================================================*/
    public function reset():Void {
        position = 0;
        
    //  Done this way since buffer is a queue
    //  After the first dead cell, all other cells afterward are dead, and so we don't need to kill them
        var i = 0;
        while (i < buffer.length && buffer[i].alive)
            buffer[i++].kill();
    }
 
    public function paint(x:Int, y:Int, color:Int):Void {
        var cell = next();
        cell.makeGraphic(CELL_WIDTH, CELL_WIDTH, color | 0xFF000000);
        cell.x = x * CELL_WIDTH;
        cell.y = y * CELL_WIDTH;
    }
 
/*  Private Members
 *  =========================================================================*/
    private var buffer:Array<FlxSprite>;
    private var position:Int;
 
/*  Private Methods
 *  =========================================================================*/
    private function next():FlxSprite {
        if (position >= buffer.length)
            createCell();
        var cell = buffer[position++];
        cell.reset(0, 0);
        return cell;
    }
 
    private function createCell():FlxSprite {
        var cell = new FlxSprite();
        buffer.push(cell);
        this.add(cell);
        return cell;
    }
}