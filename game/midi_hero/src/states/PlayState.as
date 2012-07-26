// ActionScript file
package states
{
	import logics.GameLogic;
	import logics.MidiParser;
	import logics.Note;
	import logics.SceneMgr;
	import logics.SoundMgr;
	import logics.UIMgr;
	
	import org.flixel.*;
	
	import sprites.Hero;

	public class PlayState extends FlxState
	{
		private var m_soundMgr : SoundMgr;
		private var m_uiMgr : UIMgr;
		private var m_gameLogic : GameLogic;
		private var m_hero : Hero;
		
		override public function create():void
		{
			add(SceneMgr.getInstance());
			
			m_gameLogic = GameLogic.getInstance();
			add(m_gameLogic);
			
			var mp : MidiParser = MidiParser.getInstance();
			mp.loadJson("f:\\test.jsn");		
			
			m_uiMgr = new UIMgr();
			add(m_uiMgr);
			
			m_hero = new Hero();			
			add(m_hero);
			m_hero.x = SceneMgr.getInstance().soundPlayX;
			m_hero.y = 50;
			
			m_soundMgr = SoundMgr.getInstance();
			m_soundMgr.loadNoteFreq();
		}
		
	}
}