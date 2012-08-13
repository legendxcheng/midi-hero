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
		}
		
		private static var m_instance : Evaluator = null;
		private var m_score : int; // total percentage * 100
		private var m_noteEval : Array;
		private var m_noteState : Number;
		private var m_streak : int;
		private var m_lastNoteId : int;
		private var m_noteTot;
		private var m_noteHit;
		
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
			var tmp : int = SceneMgr.getInstance().currentNoteId;
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
					m_score += 100 * m_streak; 
				}
			}
			else if (tmp > m_lastNoteId + 1)
			{
				m_streak = 1;
				m_lastNoteId = tmp;
			}
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
		
		public function sendNewNote()
		{
			
		}
	}
}