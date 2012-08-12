package logics
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Note
	{
		// this sprite class represents a note
		// and the note's width is being set when the sprite is generated
		// so we only need to change it's height
		private var m_color : uint;
		private var m_height : int;
		private var m_width : int;
		private var m_needUpdate : Boolean;
		public  var x : Number;
		public	var y : Number;

		
		public function Note()
		{

	
			
		}
		
		public function get width():int
		{
			return m_width;
		}

		public function set width(value:int):void
		{
			m_width = value;
		}

		public function get height():int
		{
			return m_height;
		}

		public function set height(value:int):void
		{
			m_height = value;
		}

		public function get color():uint
		{
			return m_color;
		}

		public function set color(value:uint):void
		{
			m_color = value;
		}

		public function resetNoteWidth(kwidth : int) : void
		{
			
			m_width = kwidth;
	
		}
		
		public function changeNote(color : uint, height : int) : void
		{

			m_color = color;
			m_height = height;
			m_needUpdate = true;			
		}
		
	}
}