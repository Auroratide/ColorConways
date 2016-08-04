package com.auroratide.color_conways.controls;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.math.FlxMath;

import com.auroratide.color_conways.ColorConwayGrid;
import com.auroratide.color_conways.GridCanvas;
import com.auroratide.color_conways.LifeSimulator;

/**
 *  MousePaintControls Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class MousePaintControls extends FlxBasic {

/*  Constructor
 *  =========================================================================*/
    public function new(grid:ColorConwayGrid, canvas:GridCanvas) {
        super();
        this.grid = grid;
        this.canvas = canvas;
        this.palette = new Palette();
        
        resetPrevMouseCoords();
    }
    
/*  Flixel API
 *  =========================================================================*/
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        
        if (FlxG.mouse.pressed || FlxG.mouse.pressedRight) {
            var x = gridX();
            var y = gridY();
            if (x != prevMouseX || y != prevMouseY) {
                var color = FlxG.mouse.pressed ? palette.next() : ColorConwayGrid.DEAD_COLOR;
                grid.revive(x, y, color);
                canvas.paint(x, y, color);
            }
            prevMouseX = x;
            prevMouseY = y;
        }
        if (FlxG.mouse.justReleased || FlxG.mouse.justReleasedRight)
            resetPrevMouseCoords();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var grid:ColorConwayGrid;
    private var canvas:GridCanvas;
    private var palette:Palette;
    
    private var prevMouseX:Int;
    private var prevMouseY:Int;
 
/*  Private Methods
 *  =========================================================================*/
    private function resetPrevMouseCoords():Void {
        this.prevMouseX = FlxMath.MAX_VALUE_INT;
        this.prevMouseY = FlxMath.MAX_VALUE_INT;
    }
 
    private inline function gridX():Int 
        return gridPosition(FlxG.mouse.x);
    
    private inline function gridY():Int 
        return gridPosition(FlxG.mouse.y);
    
    private inline function gridPosition(mouseCoord:Int):Int 
        return Math.floor(mouseCoord / GridCanvas.CELL_WIDTH);
}

private class Palette {
    private var colors:Array<Int>;
    private var position:Int;
    
    public function new() {
        colors = [0xFF0000, 0xFF8800, 0xFFFF00, 0x00FF00, 0x00FFFF, 0x0000FF, 0x880088];
        position = 0;
    }
    
    public function next():Int {
        var color = colors[position];
        position = (position + 1) % colors.length;
        return color;
    }
}