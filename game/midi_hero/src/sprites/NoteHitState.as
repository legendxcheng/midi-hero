package sprites
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxSprite;
	
	public class NoteHitState extends FlxSprite
	{
		private var m_width : int;
		private var m_height : int;
		private var m_color : Number;
		private var m_hitInfo : Array;
		public function NoteHitState(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			height = frameHeight = m_height = 20;
			width = frameWidth = m_width = 100;
			frames = 1;
			
			frame = 0;
			m_color = 0x272822;
			_pixels = new BitmapData(100, 20, true, 0x272822);
			 
			resetHelpers();
			
			
			
			
			m_hitInfo = new Array();

			this.active = true;
			
		}
		
		public function newNote(co : Number) : void
		{
			m_color = co;
			m_hitInfo = new Array();
		}
		
		public function updateHitArea(rpct : Number) : void
		{
			if (m_hitInfo.length > 0)
				m_hitInfo[m_hitInfo.length - 1].r = rpct;
		}
		
		public function addHitArea(lpct : Number, rpct : Number) : void
		{
			var tmp = new Object();
			tmp.l = lpct;
			tmp.r = rpct;
			m_hitInfo.push(tmp);
		}
		
		override public function preUpdate():void
		{
			_pixels.lock();
			var rectb : Rectangle = new Rectangle(0, 0, m_width, m_height);
			var ddd : Number = SceneMgr.getInstance().getCurrentNoteColor();
			if (ddd == 0)
				_pixels.fillRect(rectb, m_color);
			else
				_pixels.fillRect(rectb, SceneMgr.getInstance().getCurrentNoteColor() + 0xAA000000);
			
			for (var i : int = 0; i < m_hitInfo.length; ++i)
			{
				var trect : Rectangle = new Rectangle(m_hitInfo[i].l, 0, m_hitInfo[i].r - m_hitInfo[i].l, m_height);
				_pixels.fillRect(trect, SceneMgr.getInstance().getCurrentNoteColor());
				
			}
			
			_pixels.unlock();
			resetHelpers();
		}
	}
}