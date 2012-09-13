package sprites
{
	import flash.display.BitmapData;
	
	import logics.Evaluator;
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	
	
	public class FinalBlock extends FlxSprite
	{
		public var m_color : int;	
		public function FinalBlock(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = 80;
			frameWidth = width = 640;
			frames = 1;
			frame = 0;
			_pixels = new BitmapData(640, 80, true, 0xAAFFFFFF);
			resetHelpers();
		}
		
	}
}