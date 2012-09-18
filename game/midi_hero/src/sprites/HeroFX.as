package sprites
{
	import flash.display.BitmapData;
	
	import logics.Evaluator;
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	
	
	public class HeroFX extends FlxSprite
	{
		public var m_color : int;	
		public function HeroFX(size : Number = 4, X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = size;
			frameWidth = width = size;
			frames = 1;
			frame = 0;
			_pixels = new BitmapData(size, size, true, 0xFFFFFFFF);
			resetHelpers();
		}
		
		public function changeColor(cc : Number) : void
		{
			m_color = cc;
			_pixels = new BitmapData(4, 4, true, cc);
			resetHelpers();
		}
		
	}
}