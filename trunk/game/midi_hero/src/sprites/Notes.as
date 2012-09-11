package sprites
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxSprite;
	
	
	
	public class Notes extends FlxSprite
	{
		

		
		public function Notes(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = GameLogic.screenHeight;
			frameWidth = width = GameLogic.screenWidth;
			frames = 1;
			frame = 0;
			_pixels = new BitmapData(GameLogic.screenWidth, GameLogic.screenHeight, true, 0x272822);
			resetHelpers();
			
			//m_rectFx = new Array();
			
			this.active = true;

		}

			
		public function resetNotes() : void
		{
			var rectb : Rectangle = new Rectangle(0, 0, GameLogic.screenWidth, GameLogic.screenHeight);
			
			//_pixels.fillRect(rectb, 0xFF272822);
			
			//resetHelpers();
		}
		
		public function drawNote(rect : Rectangle, c : Number) : void
		{
			
			_pixels.lock();
			
			_pixels.unlock();
		}
		
		private function brighter(oc : uint) : uint
		{
			return oc + 0x050505;
		}
		
		private function darker(oc : uint) : uint
		{
			return oc - 0x050505;
		}
		
		override public function update() : void
		{
			_pixels.lock();
			var rectb : Rectangle = new Rectangle(0, 0, GameLogic.screenWidth, GameLogic.screenHeight);
			
			_pixels.fillRect(rectb, 0x272822);
			//resetNotes();
			
			var trect : Rectangle = new Rectangle();
			var sm : SceneMgr = SceneMgr.getInstance();			
			
			var si : int = sm.startIndex;
			var ii : int = sm.iStartIndex;
			var fxi : int = 0;
			
			while (sm.endIndex != -1  && sm.iStartIndex != sm.noteInfo.length)
			{
				
				var flag : Boolean;
				if (si == sm.endIndex)
					flag = true;
				else flag = false;
				
				
				
				trect.width = sm.noteSprite[si].width;
				trect.height = sm.noteSprite[si].height;
				trect.x = sm.noteSprite[si].x;
				trect.y = GameLogic.screenHeight - 50 - trect.height;//sm.noteSprite[si].y;
				var a_color : Number = sm.noteSprite[si].color;
				var t_color : Number = a_color;
				switch (sm.noteInfo[ii].hit)
				{
					case 0:
						a_color = 0x55FFFFFF;
						//a_color += 0x66000000;
						break;
					case 1:
						a_color += 0xFF000000;
						break;
					case 2:
						a_color = 0x11FFFFFF;
						//a_color += 0x11000000;
						break;
				}
				
				
				_pixels.fillRect(trect, a_color);
				

				
				// loop end
				si = sm.nextIndex(si);
				++ii;
				if (ii == sm.noteInfo.length) 
					break;
				
				if (flag)
					break;
			}
			
			_pixels.unlock();
			resetHelpers();
		}
	}
}