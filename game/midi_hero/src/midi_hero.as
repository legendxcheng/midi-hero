package
{
	import logics.JsonParser;
	
	import org.flixel.*;
	
	import states.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#272822", frameRate="30")] //Set the size and color of the Flash file
	
	public class midi_hero extends FlxGame
	{
		public function midi_hero()
		{	
			
			super(640, 480, MenuState, 1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			FlxG.bgColor = 0x272822;
		}
		
		
	}
}