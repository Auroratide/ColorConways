package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
      #if js
        untyped {
            document.oncontextmenu = document.body.oncontextmenu = function() {  return false; }
        }
      #end
		addChild(new FlxGame(640, 480, com.auroratide.color_conways.PlayState));
	}
}