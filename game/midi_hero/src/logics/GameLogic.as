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
		public static var finalFlorrHeight : int = 350;
		private var m_musicEnd :Boolean;
		private var m_canGoToVerdictState : Boolean;
		private var m_musicList : Array;
		private var m_midiAddr :String;
		
		public function GameLogic()
		{
			//m_timer = new FlxTimer();
			m_timeElapsed = 0;
			m_timeScale = 0.0075;
			m_musicEnd = false;
			m_canGoToVerdictState = false;
			m_musicList = null;
		}
				
		public function get midiAddr():String
		{
			return m_midiAddr;
		}

		public function set midiAddr(value:String):void
		{
			m_midiAddr = value;
		}

		public function set musicList(value:Array):void
		{
			m_musicList = value;
		}

		public function get musicList():Array
		{
			return m_musicList;
		}

		public function get canGoToVerdictState():Boolean
		{
			return m_canGoToVerdictState;
		}

		public function set canGoToVerdictState(value:Boolean):void
		{
			m_canGoToVerdictState = value;
		}

		public function get musicEnd():Boolean
		{
			return m_musicEnd;
		}

		public function set musicEnd(value:Boolean):void
		{
			m_musicEnd = value;
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