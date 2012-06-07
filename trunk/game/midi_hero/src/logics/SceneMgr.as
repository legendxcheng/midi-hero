package logics
{
	import org.flixel.FlxSprite;
	
	import sprites.Note;

	// class that controls note sprite
	public class SceneMgr extends FlxSprite
	{
		
		public function SceneMgr()
		{	
			m_noteSprite = new Array();
			// insert 100 notes for future use
			for (var i: int = 0; i < 100; ++i)
			{
				var note : Note = new Note(100);
				m_noteSprite.push(note);
			}
			m_startIndex = 0;
			m_endIndex = -1;
		}
		
		
		
		private static var m_instance : SceneMgr = null;
		
		public function setNoteInfo(ni : Array) : void
		{
			m_noteInfo = ni;
		}
		
		private var m_startIndex : int; // the start index of the notes in scene
		private var m_endIndex : int; // the end index of the notes in scene
		private var m_noteSprite : Array;
		
		private var m_noteInfo : Array;
		
		public static function getInstance() : SceneMgr
		{
			if (m_instance == null)
				m_instance = new SceneMgr();
			return m_instance;
		}
	}
}