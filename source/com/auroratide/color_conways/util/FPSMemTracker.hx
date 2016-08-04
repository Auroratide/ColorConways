package com.auroratide.color_conways.util;

import haxe.Timer;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 *  FPSMemTracker Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class FPSMemTracker extends FlxSpriteGroup {

/*  Constructor
 *  =========================================================================*/
    public function new() {
        super();
        
        fpsText = new FlxText();
        memText = new FlxText(0, 8);
        
        this.add(fpsText);
        this.add(memText);
        
        times = new Array<Float>();
        memItems = new Array<TrackableMemory>();
        
        totalTimeElapsed = 0;
    }
    
/*  Flixel API
 *  =========================================================================*/
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        totalTimeElapsed += elapsed;
        
        var fps = fps();
        if(totalTimeElapsed > 1) {
            fpsText.text = 'FPS: $fps';
            var memorySum:Float = Lambda.fold(memItems, function(item, sum) {
                return sum + item.memory();
            }, 0);
            memorySum = Math.round(memorySum / 1024 * 100) / 100;
            memText.text = 'Mem: $memorySum kB';
            
            totalTimeElapsed = 0;
        }
    }
 
/*  Public Methods
 *  =========================================================================*/
    public function addMemoryItem(item:TrackableMemory):Void {
        memItems.push(item);
    }
 
/*  Private Members
 *  =========================================================================*/
    private var fpsText:FlxText;
    private var memText:FlxText;
    
    private var times:Array<Float>;
    private var cacheCount:Int;
    
    private var memItems:Array<TrackableMemory>;
    
    private var totalTimeElapsed:Float;
 
/*  Private Methods
 *  =========================================================================*/
    private function fps():Int {
    //  Basically copied from OpenFL's FPS class
        var currentTime = Timer.stamp();
		times.push(currentTime);
		
		while (times[0] < currentTime - 1)
			times.shift();
		
		var currentCount = times.length;
        cacheCount = currentCount;
        
        return Math.round((currentCount + cacheCount) / 2);
    }
}