package com.auroratide.color_conways.controls;

import com.auroratide.color_conways.LifeSimulator;
import flixel.FlxG;
import flixel.FlxBasic;

/**
 *  KeyboardSpeedControls Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class KeyboardSpeedControls extends FlxBasic {

/*  Constructor
 *  =========================================================================*/
    public function new(life:LifeSimulator) {
        super();
        this.life = life;
    }
    
/*  Flixel API
 *  =========================================================================*/
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if (FlxG.keys.justPressed.V)
            life.increaseDelay();
        if (FlxG.keys.justPressed.B)
            life.decreaseDelay();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var life:LifeSimulator;
 
}