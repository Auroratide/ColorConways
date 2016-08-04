package com.auroratide.color_conways;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.math.FlxRect;

/**
 *  LifeSimulator Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class LifeSimulator extends FlxBasic {
    public var paused(default, null):Bool;

/*  Constructor
 *  =========================================================================*/
    public function new(grid:ColorConwayGrid, canvas:GridCanvas) {
        super();
        this.paused = true;
        this.grid = grid;
        this.canvas = canvas;
        this.life = new ConwaysGameOfLife(grid);
        
        this.delay = new Delay();
        this.delayCounter = 0;
    }
    
/*  Flixel API
 *  =========================================================================*/
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        ++delayCounter;
        if (canProceed()) {
            life.next();
            render();
        }
    }
 
 
/*  Public Methods
 *  =========================================================================*/
    public function play():Void {
        paused = false;
    }
    
    public function pause():Void {
        paused = true;
    }
    
    public function toggle():Void {
        paused = !paused;
    }
    
    public function render():Void {
        canvas.reset();
        var bounds = new FlxRect(
            FlxG.camera.scroll.x / GridCanvas.CELL_WIDTH,
            FlxG.camera.scroll.y / GridCanvas.CELL_WIDTH,
            FlxG.camera.width / GridCanvas.CELL_WIDTH,
            FlxG.camera.height / GridCanvas.CELL_WIDTH
        );
        
        var f = Math.floor; // shorthand
        for (i in f(bounds.x)...f(bounds.x + bounds.width))
            for (j in f(bounds.y)...f(bounds.y + bounds.height))
                if (grid.isAlive(i, j))
                    canvas.paint(i, j, grid.colorOf(i, j));
    }
    
    public function increaseDelay():Void {
        delay.prev();
    }
    
    public function decreaseDelay():Void {
        delay.next();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var grid:ColorConwayGrid;
    private var canvas:GridCanvas;
    private var life:ConwaysGameOfLife;
    
    private var delay:Delay;
    private var delayCounter:Int;
 
/*  Private Methods
 *  =========================================================================*/
    private function canProceed():Bool {
        return !paused && delayCounter % delay.delay() == 0;
    }
}

private class Delay {
    private var current:Int;
    private var notches:Array<Int>;
    
    public function new() {
        current = 4;
        notches = [1, 2, 4, 7, 11, 16, 23, 31, 39, 48, 58]; // quadratic progression (.5x^2+.5x+1)
    }
    
    public function next():Int {
        current -= current > 0 ? 1 : 0;
        return delay();
    }
    
    public function delay():Int {
        return notches[current];
    }
    
    public function prev():Int {
        current += current < notches.length - 1 ? 1 : 0;
        return delay();
    }
}