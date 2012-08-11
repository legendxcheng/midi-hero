package logics
{
	import logics.SceneMgr;
	public class Evaluator
	{
		public function Evaluator()
		{
			m_score = 0;
			m_streak = 0;
		}
		
		private static var m_instance : Evaluator = null;
		private var m_score : int; // total percentage * 100
		private var m_noteEval : Array;
		private var m_noteState : Number;
		private var m_streak : int;
		private var m_lastNoteId : int;
		
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
		
		public function addCoverage(right : int, left : int, noteId : int, hy : int) : void
		{
			var tmp : int = Math.ceil(((right - left) * 100 / SceneMgr.getInstance().getCurrentNoteLength() ));
			if (tmp >= 95) tmp = 100;
			m_score += tmp;
			
			UIMgr.getInstance().addCoverageTxt(SceneMgr.getInstance().getCurrentNoteColor(), hy, tmp);
			var tmp : int = SceneMgr.getInstance().currentNoteId;
			if (tmp == m_lastNoteId + 1)
			{
				m_streak += 1;
				m_lastNoteId = tmp;
				if (m_streak >= 5)
				{
					UIMgr.getInstance().addStreakTxt(hy, m_streak);
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
			m_noteState = cover / SceneMgr.getInstance().getCurrentNoteLength();
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