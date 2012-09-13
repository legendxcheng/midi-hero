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
		public function HeroFX(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = 4;
			frameWidth = width = 4;
			frames = 1;
			frame = 0;
			_pixels = new BitmapData(4, 4, true, 0xFFFFFFFF);
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