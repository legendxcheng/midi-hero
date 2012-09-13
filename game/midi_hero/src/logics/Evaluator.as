package logics
{
	import logics.SceneMgr;
	public class Evaluator
	{
		public function Evaluator()
		{
			m_noteTot = 0;
			m_noteHit = 0;
			m_score = 0;
			m_streak = 0;
			m_maxStreak = 0;
		}
		
		private static var m_instance : Evaluator = null;
		private var m_score : int; // total percentage * 100
		private var m_noteEval : Array;
		private var m_noteState : Number;
		private var m_streak : int;
		private var m_maxStreak : int;
		private var m_lastNoteId : int;
		private var m_noteTot : int;
		private var m_noteHit : int;
		private var m_time : Number;
		
		public function getResult() : Number
		{
			return m_score / (m_noteTot * 100 + m_noteTot * (m_noteTot + 1) / 2);	
		}
		
		public function get noteHit():int
		{
			return m_noteHit;
		}

		public function set noteHit(value:int):void
		{
			m_noteHit = value;
		}

		public function get noteTot():int
		{
			return m_noteTot;
		}

		public function set noteTot(value:int):void
		{
			m_noteTot = value;
		}

		public function get maxStreak():int
		{
			return m_maxStreak;
		}

		public function get time():Number
		{
			return m_time;
		}

		public function set time(value:Number):void
		{
			m_time = value;
		}

		public function get noteState():Number
		{
			return m_noteState;
		}

		public function set noteState(value:Number):void
		{
			m_noteState = value;
		}

		public function get score():int
		{
			return m_score;
		}

		public static function getInstance() : Evaluator
		{
			if (m_instance == null)
				m_instance = new Evaluator();
			return m_instance;
		}
		
		public function addMiss(hy : int) : void
		{
			++m_noteTot;
			UIMgr.getInstance().resetHitMiss(false, m_noteHit, m_noteTot);
			UIMgr.getInstance().addMissTxt(hy);			
		}
		
		public function addCoverage(right : int, left : int, noteId : int, hy : int) : void
		{
			var tmp : int = Math.ceil(((right - left) * 100 / SceneMgr.getInstance().getCurrentNoteLength() ));
			var stx : int = 
				Math.ceil(((left - SceneMgr.getInstance().currentNoteX) * 100 / SceneMgr.getInstance().getCurrentNoteLength()));
			if (tmp >= 95) tmp = 100;
			m_score += tmp;
			var tc : uint  = SceneMgr.getInstance().getCurrentNoteColor();
			if (tmp >= 30)
			{
			
				UIMgr.getInstance().addCoverageTxt(tc, hy, stx, tmp);
			}
			tmp  = SceneMgr.getInstance().currentNoteId;
			if (tmp == m_lastNoteId + 1)
			{
				++m_noteHit;
				++m_noteTot;
				UIMgr.getInstance().resetHitMiss(true, m_noteHit, m_noteTot);
				m_streak += 1;
				m_lastNoteId = tmp;
				if (m_streak >= 5)
				{
					UIMgr.getInstance().addStreakTxt(tc, hy, m_streak);
					m_score += m_streak; 
					
				}
			}
			else if (tmp > m_lastNoteId + 1)
			{
				m_streak = 1;
				m_lastNoteId = tmp;
			}
			
			SceneMgr.getInstance().setFXNum(m_streak / 2); 
			if (m_streak > m_maxStreak)
				m_maxStreak = m_streak;
		}
		
		public function setNoteState(cover : int) : void
		{
			var kk : Number = cover / SceneMgr.getInstance().getCurrentNoteLength();
			if (m_noteState < kk)
			{
				var tmp : Number = Math.floor((GameLogic.screenWidth / 2 - SceneMgr.getInstance().currentNoteX) * 100
					/ SceneMgr.getInstance().getCurrentNoteLength());
				UIMgr.getInstance().updateNoteHitStateArea(tmp);
			}
			else
			{
				var rpct : Number = Math.floor((GameLogic.screenWidth / 2 - SceneMgr.getInstance().currentNoteX) * 100
					/ SceneMgr.getInstance().getCurrentNoteLength());
				var lpct : Number = Math.floor((GameLogic.screenWidth / 2 - SceneMgr.getInstance().currentNoteX - cover) * 100
					/ SceneMgr.getInstance().getCurrentNoteLength());
				UIMgr.getInstance().addNoteHitStateArea(lpct, rpct);
			}
			m_noteState = kk;
			if (m_noteState > 0.95)
				m_noteState = 1.00;
			
		}
		
		public function sendCoverage() : void // call by Hero calss
		{
			
		}
		
		public function sendNewNote() : void
		{
			
		}
	}
}