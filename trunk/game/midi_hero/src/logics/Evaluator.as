package logics
{
	public class Evaluator
	{
		public function Evaluator()
		{
		}
		
		private var m_instance : Evaluator = null;
		
		public function getInstance() : Evaluator
		{
			if (m_instance == null)
				m_instance = new Evaluator();
			return m_instance;
		}
	}
}