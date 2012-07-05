package logics
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import sprites.Note;

	// class that controls note sprite
	public class SceneMgr extends FlxGroup
	{
		private var m_startIndex : int; // the start index of the note sprites in scene
		private var m_endIndex : int; // the end index of the note sprites in scene
		private var m_iStartIndex : int; // the start index of the note info in scene
		private var m_iEndIndex : int; // the end index of the note info in scene
		
		private var m_noteSprite : Array;
		private var m_isPlaying : Boolean;
		private var m_noteInfo : Array;
		private var m_colorList : Array;
		
		
		
		
		
		
		public function SceneMgr()
		{	
			
			FlxG.framerate = 30;
			
			m_noteSprite = new Array();
			// insert 100 notes for future use
			for (var i: int = 0; i < 100; ++i)
			{
				var note : Note = new Note();
				m_noteSprite.push(note);
			}
			
			/*
			var tn : Note = m_noteSprite[0];
			tn.changeNote(0xFF00FFFf, 200);
			add(tn);
			*/
			resetScore();
			
			m_colorList = new Array();
			m_colorList.push(0xFF8CC540);
			m_colorList.push(0xFF009F5D);
			m_colorList.push(0xFF019FA0);
			m_colorList.push(0xFF019FDE);
			m_colorList.push(0xFF007CDC);
			m_colorList.push(0xFF887DDD);
			m_colorList.push(0xFFCD7BDD);
			m_colorList.push(0xFFFF5675);
			m_colorList.push(0xFFFF1244);
			m_colorList.push(0xFFFF8345);
			m_colorList.push(0xFFf8BD0B);
			m_colorList.push(0xFFD1D2D4);
			
			
			
			
		}
		
		/*
			starts the score
			move the note sprites leftward
		*/
		
		
		public function startScore() : void
		{
			resetScore();
			m_isPlaying = true;	
		}
		
		private function resetScore() : void
		{
			m_startIndex = 0;
			m_endIndex = -1;
			m_iStartIndex = 0;
			m_iEndIndex = -1;	
		}
		
		// used only in note sprite array
		// for conveniently get next or previous index
		private function nextIndex(k : int) : int
		{
			if (k == 99)
				return 0;
			return k + 1;
		}
		
		private function prevIndex(k : int) : int
		{
			if (k == 0)
				return 99;
			return k - 1;
		}
		
		
		
		override public function preUpdate() : void
		{
			if (!m_isPlaying)
				return;
			
			
			var timeElap : Number = GameLogic.getInstance().getTime();
			var timeScale : Number = GameLogic.getInstance().timeScale;
			// first check info array to add and remove notes
			// change iStartIndex and iEndIndex
			var lx : Number;
			var rx : Number;
			while (true)
			{
				//var lx : Number = ((m_noteInfo[m_iStartIndex].start - timeElap) / timeScale + 768);
				rx = ((m_noteInfo[m_iStartIndex].end - timeElap) / timeScale + 768);
				if (rx < 0)	// remove a note sprite
				{
					++m_iStartIndex;
					remove(m_noteSprite[m_startIndex]);
					m_startIndex = nextIndex(m_startIndex);
				}
				else 
					break;
				
			}
			
			while (m_iEndIndex < m_noteInfo.length - 1)
			{
				lx = ((m_noteInfo[m_iEndIndex + 1].start - timeElap) / timeScale + 768);
				if (lx < 768)	// add a note sprite
				{
					++m_iEndIndex;
					m_endIndex = nextIndex(m_endIndex);
					add(m_noteSprite[m_endIndex]);
					
					// initialize note's figure
					var note : Note = m_noteSprite[m_endIndex];
					note.resetNoteWidth((m_noteInfo[m_iEndIndex].end - m_noteInfo[m_iEndIndex].start) / timeScale);
					//note.resetNoteWidth(100);
					//note.changeNote(0xFFFFFF00, 300);
					var nco : uint = m_colorList[m_noteInfo[m_iEndIndex].high % 12];
					note.changeNote(nco, m_noteInfo[m_iEndIndex].high * 10 - 120);
					
					/*
						Here I play the note sound.
					*/
					var sndMgr : SoundMgr = SoundMgr.getInstance();
					sndMgr.changeNote(m_noteInfo[m_iEndIndex].name, m_noteInfo[m_iEndIndex].end - m_noteInfo[m_iEndIndex].start);
					
				}
				else
					break;
			}
			
			
			//	secondly, modify each note's position
			var si : int = m_startIndex;
			var ii : int = m_iStartIndex;
			while (m_endIndex != -1)
			{
				
				var flag : Boolean;
				if (si == m_endIndex)
					flag = true;
				else flag = false;
				
				m_noteSprite[si].x = Math.round(768 + (m_noteInfo[ii].start - timeElap) / timeScale);
				
				// loop end
				si = nextIndex(si);
				++ii;
				
				if (flag)
					break;
			}
			
		}
		
		private static var m_instance : SceneMgr = null;
		
		public function setNoteInfo(ni : Array) : void
		{
			m_noteInfo = ni;
			startScore();
		}
		
		
		public static function getInstance() : SceneMgr
		{
			if (m_instance == null)
				m_instance = new SceneMgr();
			return m_instance;
		}
		
		
	}
}