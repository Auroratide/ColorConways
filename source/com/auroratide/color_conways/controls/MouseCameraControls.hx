package com.auroratide.color_conways.controls;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

import com.auroratide.color_conways.LifeSimulator;

/**
 *  MouseCameraControls Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class MouseCameraControls extends FlxBasic {

/*  Constructor
 *  =========================================================================*/
    public function new(camera:FlxCamera, life:LifeSimulator) {
        super();
        this.cam = camera;
        this.life = life;
        
        previousClickPoint = new FlxPoint();
        screenCam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        cameraFollowObject = new FlxObject();
        
        cam.follow(cameraFollowObject);
    }
    
/*  Flixel API
 *  =========================================================================*/
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        updateCameraTranslation(elapsed);
        updateCameraZoom(elapsed);
    }
 
/*  Private Members
 *  =========================================================================*/
    private static inline var ZOOM_FACTOR = 30.0;
 
    private var cam:FlxCamera;
    private var life:LifeSimulator;
    
    private var previousClickPoint:FlxPoint;
    private var screenCam:FlxCamera;
    private var cameraFollowObject:FlxObject;
 
/*  Private Methods
 *  =========================================================================*/
    private function updateCameraTranslation(elapsed:Float):Void {
        if (FlxG.mouse.justPressedMiddle)
            FlxG.mouse.getScreenPosition(screenCam, previousClickPoint);
            
        if (FlxG.mouse.pressedMiddle) {
            var p = FlxG.mouse.getScreenPosition(screenCam);
            cameraFollowObject.x += previousClickPoint.x - p.x;
            cameraFollowObject.y += previousClickPoint.y - p.y;
            previousClickPoint.set(p.x, p.y);
            if(life.paused)
                life.render();
        }
    }
    
    private function updateCameraZoom(elapsed:Float):Void {
        cam.zoom = FlxMath.bound(cam.zoom + FlxG.mouse.wheel / ZOOM_FACTOR, 1.0, 2.0);
    }
}