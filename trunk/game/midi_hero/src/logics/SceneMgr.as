package logics
{
	import flash.geom.Rectangle;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	import sprites.Hero;
	import sprites.Notes;
	

	// class that controls note sprite
	public class SceneMgr extends FlxGroup
	{
		private var m_startIndex : int; // the start index of the note sprites in scene
		private var m_endIndex : int; // the end index of the note sprites in scene
		private var m_iStartIndex : int; // the start index of the note info in scene
		private var m_iEndIndex : int; // the end index of the note info in scene
		private var m_soundPlayX : int; // the x coor where a note is played
		private var m_soundPlayFloor : int; // sound play floor y coor
		private var m_noteSprite : Array;
		private var m_isPlaying : Boolean;
		private var m_noteInfo : Array;
		private var m_colorList : Array;
		private var m_currentNoteId : int;
		private var m_currentNoteX : int;
		private var m_currentNoteColor : uint;
		private var m_currentNoteHeight : int;
		private var m_notes : Notes;
		
		public function getCurrentNoteColor() : uint
		{
			return m_currentNoteColor;
		}
		
		public function get currentNoteId():int
		{
			return m_currentNoteId;
		}

		public function getCurrentNoteLength() : int
		{
			return Math.floor(
				(m_noteInfo[m_currentNoteId].end - m_noteInfo[m_currentNoteId].start) 
					/ GameLogic.getInstance().timeScale);
		}
		
		public function getCurrentNoteX() : int
		{
			return m_currentNoteX;
		}
		
		public function getFirstNoteX() : int
		{
			if (m_noteSprite[0].x > 0)
				return m_noteSprite[0].x;
			return 2000;
		}
		
		public function getFirstNoteY() : int
		{
			return GameLogic.screenHeight - 50 - m_noteSprite[0].height - 4;
		}
		

		
		public function getHeightOffset() : int
		{
			if (m_currentNoteId + 1 <m_noteInfo.length)
				return m_noteInfo[m_currentNoteId + 1].high - m_noteInfo[m_currentNoteId].high;
			return 0;
		}
		
		public function getWidthOffset() : Number
		{
			if (m_currentNoteId + 1 <m_noteInfo.length)
				return m_noteInfo[m_currentNoteId + 1].start - m_noteInfo[m_currentNoteId].end;
			return 0;
		}
		
		public function playSound() : void
		{
			
			/*
			Here I play the note sound.
			*/
			var sndMgr : SoundMgr = SoundMgr.getInstance();
			sndMgr.changeNote(m_noteInfo[m_currentNoteId].name, 20.0);
			noteInfo[m_currentNoteId].hit = 1;
				//m_noteInfo[m_currentNoteId].end - m_noteInfo[m_currentNoteId].start);
			
		}
		
		public function stopSound() : void
		{
			var sndMgr : SoundMgr = SoundMgr.getInstance();
			sndMgr.stopSound();
		}
		
		public function SceneMgr()
		{	
			


			FlxG.framerate = 60;
			
			m_soundPlayX = GameLogic.screenWidth / 2;
			m_soundPlayFloor = GameLogic.screenHeight;
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
			
			
			m_notes = new Notes();
			add(m_notes);
			
		}
		
		/*
			starts the score
			move the note sprites leftward
		*/
		
		
		public function get soundPlayX():int
		{
			return m_soundPlayX;
		}

		public function get soundPlayFloor():int
		{
			return m_soundPlayFloor;
		}

		public function get notes():Notes
		{
			return m_notes;
		}

		public function get iEndIndex():int
		{
			return m_iEndIndex;
		}

		public function get iStartIndex():int
		{
			return m_iStartIndex;
		}

		public function get colorList():Array
		{
			return m_colorList;
		}

		public function get noteInfo():Array
		{
			return m_noteInfo;
		}

		public function get noteSprite():Array
		{
			return m_noteSprite;
		}

		public function get endIndex():int
		{
			return m_endIndex;
		}

		public function get startIndex():int
		{
			return m_startIndex;
		}

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
		public function nextIndex(k : int) : int
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
			
			var notePlayId : Number;
			
			while (m_iStartIndex < m_noteInfo.length)
			{
				//var lx : Number = ((m_noteInfo[m_iStartIndex].start - timeElap) / timeScale + GameLogic.screenWidth);
				rx = ((m_noteInfo[m_iStartIndex].end - timeElap) / timeScale + GameLogic.screenWidth);
				//trace(m_iStartIndex);
				if (rx < 0)	// remove a note sprite
				{
					++m_iStartIndex;
					
					m_startIndex = nextIndex(m_startIndex);
				}
				else 
					break;
				
			}
			
			while (m_iEndIndex < m_noteInfo.length - 1)
			{
				lx = ((m_noteInfo[m_iEndIndex + 1].start - timeElap) / timeScale + GameLogic.screenWidth);
				if (lx < GameLogic.screenWidth)	// add a note sprite
				{
					++m_iEndIndex;
					m_endIndex = nextIndex(m_endIndex);
				
					
					// initialize note's figure
					var note : Note = m_noteSprite[m_endIndex];
					note.resetNoteWidth((m_noteInfo[m_iEndIndex].end - m_noteInfo[m_iEndIndex].start) / timeScale);
					//note.resetNoteWidth(100);
					//note.changeNote(0xFFFFFF00, 300);
					var nco : uint = m_colorList[m_noteInfo[m_iEndIndex].high % 12];
					note.changeNote(nco, m_noteInfo[m_iEndIndex].high * 4);
					
					
					
				}
				else
					break;
			}
			
			
			//	secondly, modify each note's position
			var si : int = m_startIndex;
			var ii : int = m_iStartIndex;
			m_soundPlayFloor = GameLogic.screenHeight;
			
			while (m_endIndex != -1 && ii < m_noteInfo.length)
			{
				
				var flag : Boolean;
				if (si == m_endIndex)
					flag = true;
				else flag = false;
				
				var tox : int = m_noteSprite[si].x;
				m_noteSprite[si].x = Math.round(GameLogic.screenWidth + (m_noteInfo[ii].start - timeElap) / timeScale);
				
				if ( m_noteSprite[si].x + m_noteSprite[si].width >= m_soundPlayX)
				{
					if (m_noteSprite[si].x <= m_soundPlayX)
					{
						m_soundPlayFloor = GameLogic.screenHeight - 50 - 4 - m_noteSprite[si].height;
						m_currentNoteColor = m_noteSprite[si].color;
						m_currentNoteId = ii;
						m_currentNoteX = m_noteSprite[si].x;
						m_currentNoteHeight = m_soundPlayFloor;
					}
					
					
				}
				
				else if (m_noteSprite[si].x + m_noteSprite[si].width < m_soundPlayX)
				{
					switch (m_noteInfo[ii].hit)
					{
						case 0:
							m_noteInfo[ii].hit = 2;
							Evaluator.getInstance().addMiss(m_currentNoteHeight);
							break;
						case 1:
							break;
						case 2:
							break;
					}
				}
				
				

				
				// now draw each note on m_notes
				
				
				// loop end
				si = nextIndex(si);
				++ii;
				
				if (flag)
					break;
			}
			
		}
		
		
		public function drawNotes() : void
		{
			// update m_notes
			
			
			
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