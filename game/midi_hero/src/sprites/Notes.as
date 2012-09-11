package sprites
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxSprite;
	
	
	
	public class Notes extends FlxSprite
	{
		private var m_curHitNode : int;
		private var m_curHitNodeSi : int;
		private var m_rectFxPct : Number;
		private var m_rectFxColor;
		private var m_rectFxFrame : int;
		private var m_alphaList : Array;

		
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
			
			m_rectFxPct = 0;
			m_rectFxColor = 0;
			m_curHitNode = -1;
			
			this.active = true;
			
			m_alphaList = new Array();
			m_alphaList.push(0x22000000);
			m_alphaList.push(0x44000000);
			m_alphaList.push(0x66000000);
			m_alphaList.push(0x88000000);
			m_alphaList.push(0xAA000000);
			m_alphaList.push(0xCC000000);
			m_alphaList.push(0xEE000000);
			m_alphaList.push(0xFF000000);
			m_alphaList.push(0xCC000000);
			m_alphaList.push(0x88000000);
			m_alphaList.push(0x44000000);
			m_alphaList.push(0x00000000);

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
						a_color += 0x66000000;
						// rectFx logic
						if (m_curHitNode < ii)// new node hit
						{
							m_curHitNodeSi = si;
							m_curHitNode = ii;
							m_rectFxPct = 0;
							m_rectFxFrame = 0;
							
							//m_rectFxColor = sm.noteSprite[si].color;
						}
						
						break;
					case 2:
						a_color = 0x11FFFFFF;
						//a_color += 0x11000000;
						break;
					case 3:
						a_color += 0xAA000000;
				}
				
				
				_pixels.fillRect(trect, a_color);
				
				// draw rectFx
				if (ii == m_curHitNode && m_rectFxFrame < 12 && m_curHitNode >= 0)
				{
					++m_rectFxFrame;
					
					m_rectFxColor = sm.noteSprite[m_curHitNodeSi].color; // todo alpha
					
					if (m_rectFxFrame <= 8)
						m_rectFxPct = m_rectFxFrame * 1.0 / 8;
					else
						m_rectFxPct = 1 + (m_rectFxFrame - 8) / 20;
					var fxRect : Rectangle  =new Rectangle(trect.x + (1 - m_rectFxPct) * trect.width / 2,
						trect.y + (1 - m_rectFxPct) * trect.height /2, trect.width * m_rectFxPct, trect.height * m_rectFxPct);
					_pixels.fillRect(fxRect, m_rectFxColor);
					if (m_rectFxFrame == 8)
					{
						sm.noteInfo[m_curHitNode].hit = 3;
					}
				}
				

				
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