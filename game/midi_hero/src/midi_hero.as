package
{
	import states.*;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="768", height="480", backgroundColor="#FFF00F")] //Set the size and color of the Flash file
	
	public class midi_hero extends FlxGame
	{
		public function midi_hero()
		{
			super(768, 480, PlayState, 1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
		}
	}
}