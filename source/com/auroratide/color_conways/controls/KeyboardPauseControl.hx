package com.auroratide.color_conways.controls;

import flixel.FlxG;
import flixel.FlxBasic;

import com.auroratide.color_conways.LifeSimulator;

/**
 *  KeyboardPauseControl Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class KeyboardPauseControl extends FlxBasic {

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
        if (FlxG.keys.justPressed.SPACE)
            life.toggle();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var life:LifeSimulator;
}