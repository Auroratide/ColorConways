package com.auroratide.color_conways;

import com.auroratide.color_conways.util.FPSMemTracker;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import com.auroratide.color_conways.grid.ArrayGrid;
import com.auroratide.color_conways.grid.LinkedListGrid;
import com.auroratide.color_conways.grid.ChunkListGrid;
import com.auroratide.color_conways.controls.MousePaintControls;
import com.auroratide.color_conways.controls.MouseCameraControls;
import com.auroratide.color_conways.controls.KeyboardPauseControl;
import com.auroratide.color_conways.controls.KeyboardSpeedControls;
import com.auroratide.color_conways.util.TrackableMemory;

private typedef GridType = ArrayGrid<Int>
//private typedef GridType = LinkedListGrid<Int>
//private typedef GridType = ChunkListGrid<Int>

/**
 *  PlayState Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class PlayState extends FlxState {
    
/*  Flixel API
 *  =========================================================================*/
    override public function create():Void {
        super.create();
        this.grid = new GridType(ColorConwayGrid.DEAD_COLOR);
        
        this.canvas = new GridCanvas();
        this.life = new LifeSimulator(this.grid, this.canvas);
        this.add(life);
        this.add(canvas);

        this.addControls();
        this.addFPSMemTracker();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var grid:ColorConwayGrid;
    private var life:LifeSimulator;
    private var canvas:GridCanvas;
 
/*  Private Methods
 *  =========================================================================*/
    private function addControls():Void {
        add(new MousePaintControls(grid, canvas));
        add(new MouseCameraControls(FlxG.camera, life));
        add(new KeyboardPauseControl(life));
        add(new KeyboardSpeedControls(life));
    }
    
    private function addFPSMemTracker():FPSMemTracker {
        var tracker = new FPSMemTracker();
        tracker.scrollFactor.set();
        tracker.addMemoryItem(cast(grid, TrackableMemory));
        add(tracker);
        return tracker;
    }
}