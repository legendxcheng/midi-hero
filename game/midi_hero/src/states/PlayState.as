// ActionScript file
package states
{
	import org.flixel.*;
	import logics.MidiParser;
	import sprites.Note;
	import logics.GameLogic;
	import logics.UIMgr;
	import logics.SceneMgr;
	public class PlayState extends FlxState
	{
		
		private var m_uiMgr : UIMgr;
		private var m_gameLogic : GameLogic;
		override public function create():void
		{
			m_gameLogic = GameLogic.getInstance();
			add(m_gameLogic);
			
			var mp : MidiParser = MidiParser.getInstance();
			mp.loadJson("f:\\test.jsn");		
			
			m_uiMgr = new UIMgr();
			add(m_uiMgr);
			
			add(SceneMgr.getInstance());
		}
		
	}
}