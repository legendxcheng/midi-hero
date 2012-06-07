// ActionScript file
package states
{
	import org.flixel.*;
	import logics.MidiParser;
	import sprites.Note;
	import logics.GameLogic;
	
	public class PlayState extends FlxState
	{
		private var m_gameLogic : GameLogic;
		override public function create():void
		{
			m_gameLogic = null;
			
			var mp : MidiParser = MidiParser.getInstance();
			mp.loadJson("f:\\test.jsn");
			//add(new FlxText(0,0,100,"Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			
		}
		
		override public function preUpdate():void
		{
			
			if (m_gameLogic == null)
			{
				m_gameLogic = GameLogic.getInstance();	
			}
			m_gameLogic.updateTimer();
		}
	}
}