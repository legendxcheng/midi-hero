package logics
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	
	public class GameLogic extends FlxBasic
	{
		static private var m_instance : GameLogic = null;
		private var m_timeElapsed : Number;
		private var m_timer : FlxTimer;
		private var m_timeScale : Number;	// how much time coresponds to 1 pixel
		public static var screenWidth : int = 640;
		public static var screenHeight : int = 480;
		
		public function GameLogic()
		{
			//m_timer = new FlxTimer();
			m_timeElapsed = 0;
			m_timeScale = 0.0075;
		}
				
		public function get timeScale():Number
		{
			return m_timeScale;
		}

		public function set timeScale(value:Number):void
		{
			m_timeScale = value;
		}

		static public function getInstance() : GameLogic
		{
			if (m_instance == null)
				m_instance = new GameLogic();
			
			return m_instance;
		}
		
		
		public function getTime() : Number
		{
			return m_timeElapsed;	
		}
		
		public function resetTime() : void
		{
			m_timeElapsed = 0;
		}
		
		public function updateTimer() : void
		{
			m_timeElapsed += FlxG.elapsed;
		}
		
		override public function preUpdate() : void
		{
			// do all the updates
			updateTimer();
		}
		

	}
}