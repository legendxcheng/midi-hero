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
	}
}