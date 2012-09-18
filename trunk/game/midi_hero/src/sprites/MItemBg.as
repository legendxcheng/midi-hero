package sprites
{
	import flash.display.BitmapData;
	
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class MItemBg extends FlxSprite
	{
		public function MItemBg(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = 300;
			frameWidth = width = 50;
			frames = 1;
			frame = 0;
			_pixels = new BitmapData(300, 50, true, 0xFFFFFFFF);
			resetHelpers();
		}
	}
}