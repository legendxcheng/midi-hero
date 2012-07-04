package logics
{
	public class SoundMgr
	{
		public function SoundMgr()
		{
		}
		
		private var m_instance : SoundMgr = null;
		
		public function getInstance() : SoundMgr
		{
			if (m_instance == null)
				m_instance = new SoundMgr();
			return m_instance;
		}
		
		// call by ouside
		// to play a note with a given frequency and a given length
		public function playNote(name : String, len : Number) : void
		{
			
		}
		
		// given name of note, return its frequency
		private function getFreq(name : String) : Number
		{
			
		}
	}
}