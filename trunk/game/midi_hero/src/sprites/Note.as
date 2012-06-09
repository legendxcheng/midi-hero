package sprites
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxCamera;
	import org.flixel.FlxSprite;

	public class Note extends FlxSprite
	{
		// this sprite class represents a note
		// and the note's width is being set when the sprite is generated
		// so we only need to change it's height
		private var m_color : uint;
		private var m_height : int;
		private var m_width : int;
		private var m_needUpdate : Boolean;
		
		public function Note()
		{
			super();
			frames = 1;
			frame = 0;
			//m_width = this.width = width;
			
			frameHeight = 480;
			height = 768;
			
			//_pixels = new BitmapData(m_width, 480, true, 0x00000000);

			resetHelpers();
			this.active = true;
			
		}
		
		public function resetNoteWidth(kwidth : int) : void
		{
			
			m_width = this.width = frameWidth = kwidth;
			//m_width = width;
			_pixels = new BitmapData(m_width, 480, true, 0x00000000);
			resetHelpers();
		}
		
		public function changeNote(color : uint, height : int) : void
		{
			
			m_color = color;
			m_height = height;
			m_needUpdate = true;			
		}
		
		override public function update() :void 
		{
			if (m_needUpdate)
			{
				var rectb : Rectangle = new Rectangle(0, 0, m_width, m_height);
				var rect : Rectangle = new Rectangle(0, 480 - m_height, m_width, m_height - 50);
				_pixels.lock();
				_pixels.fillRect(rectb, 0x000000);
				_pixels.fillRect(rect, m_color);
				_pixels.unlock();
				resetHelpers();
				m_needUpdate = false;
			}
		}
	}
}