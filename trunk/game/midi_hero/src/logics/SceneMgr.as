package logics
{
	public class SceneMgr
	{
		public function SceneMgr()
		{
		}
		
		private var m_instance : SceneMgr = null;
		
		public function getInstance() : SceneMgr
		{
			if (m_instance == null)
				m_instance = new SceneMgr();
			return m_instance;
		}
	}
}