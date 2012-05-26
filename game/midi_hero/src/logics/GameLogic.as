package logics
{
	import org.flixel.FlxTimer;
	import org.flixel.FlxG;
	
	public class GameLogic
	{
		public function GameLogic()
		{
			//m_timer = new FlxTimer();
		}
		
		static private var m_instance : GameLogic = null;
		private var m_timeElapsed : Number;
		private var m_timer : FlxTimer;
		
		static public function getInstance() : GameLogic
		{
			if (m_instance == null)
				m_instance = new GameLogic();
			return m_instance;
		}
		
		public function resetTime() : void
		{
			m_timeElapsed = 0;
		}
		
		public function updateTimer() : void
		{
			m_timeElapsed += FlxG.elapsed;
		}
	}
}