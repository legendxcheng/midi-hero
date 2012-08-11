package logics
{
	import logics.SceneMgr;
	public class Evaluator
	{
		public function Evaluator()
		{
			m_score = 0;
		}
		
		private static var m_instance : Evaluator = null;
		private var m_score : int; // total percentage * 100
		private var m_noteEval : Array;
		private var m_noteState : Number;
		
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