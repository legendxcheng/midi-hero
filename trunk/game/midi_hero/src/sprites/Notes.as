package sprites
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxSprite;
	
	
	
	public class Notes extends FlxSprite
	{
		
		private var m_rectFx : Array;
		
		public function Notes(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = GameLogic.screenHeight;
			frameWidth = width = GameLogic.screenWidth;
			frames = 1;
			frame = 0;
			_pixels = new BitmapData(GameLogic.screenWidth, GameLogic.screenHeight, true, 0x272822);
			resetHelpers();
			
			m_rectFx = new Array();
			
			this.active = true;

		}
		public function addRectFx(noteId : int) : void
		{
			var tmp = new Object();
			tmp.alp = 0;
			tmp.nid = noteId;
			tmp.pct = 0;
			m_rectFx.push(tmp);
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
						a_color += 0x99000000;
						break;
					case 1:
						a_color += 0xFF000000;
						break;
					case 2:
						a_color += 0x44000000;
						break;
				}
				
				
				_pixels.fillRect(trect, a_color);
				/*
				if (fxi < m_rectFx.length && ii == m_rectFx[fxi].nid) // showing fx
				{
					var hStep : Number;
					
					var tkk : Number = 0xFF * m_rectFx[fxi].alp;
					var ttrect = new Rectangle(trect.x+ trect.width / 2, trect.y + trect.height / 2, 0,  0);
					
					if (m_rectFx[fxi].pct < 1)
					{
						ttrect.inflate(m_rectFx[fxi].pct * trect.width / 2, m_rectFx[fxi].pct * trect.height / 2);
						m_rectFx[fxi].pct += 0.10;
						m_rectFx[fxi].alp += 0.10;
					}
					else
					{
						ttrect.inflate(m_rectFx[fxi].pct * trect.width  / 2, m_rectFx[fxi].pct * trect.height / 2);
						m_rectFx[fxi].pct += 0.001;
						m_rectFx[fxi].alp -= 0.001;
					}
					

					//_pixels.fillRect(ttrect, t_color  + tkk << 24);
					_pixels.fillRect(ttrect, tkk << 24 + 0xFFFFFF);
					
					
					if (m_rectFx[fxi].alp <= 0)
					{
						m_rectFx.splice(fxi, 1);		
					}
					++fxi;
				}
				*/
				
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