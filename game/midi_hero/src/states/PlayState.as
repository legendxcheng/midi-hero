// ActionScript file
package states
{
	import logics.GameLogic;
	import logics.JsonParser;
	import logics.Note;
	import logics.SceneMgr;
	import logics.SoundMgr;
	import logics.UIMgr;
	
	import org.flixel.*;
	
	import sprites.Hero;
	import sprites.PlaySprite;

	public class PlayState extends FlxState
	{
		private var m_soundMgr : SoundMgr;
		private var m_uiMgr : UIMgr;
		private var m_gameLogic : GameLogic;
		private var m_hero : Hero;
		private var m_sprite :PlaySprite;
		
		override public function create():void
		{
			FlxG.bgColor = 0xFF272822;
			add(SceneMgr.getInstance());
			
			m_gameLogic = GameLogic.getInstance();
			add(m_gameLogic);
			
			var mp : JsonParser = JsonParser.getInstance();
			mp.loadJson(GameLogic.getInstance().midiAddr);		
			
			m_uiMgr = UIMgr.getInstance();
			add(m_uiMgr);
			
			m_hero = new Hero();			
			add(m_hero);
			m_hero.x = 200000;
			m_hero.y = 50;
			
			m_soundMgr = SoundMgr.getInstance();
			m_soundMgr.loadNoteFreq();
			m_sprite = new PlaySprite();
			add(m_sprite);
		}
		
	}
}