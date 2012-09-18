package states
{
	import logics.GameLogic;
	import logics.MidiParser;
	
	import org.flixel.FlxState;
	
	import sprites.MusicListSprite;

	public class MusicListState extends FlxState
	{
		private var m_sprite :MusicListSprite;
		public function MusicListState()
		{
			super();
			MidiParser.getInstance().loadMusicList();
			m_sprite = new MusicListSprite();
			add(m_sprite);
		}
	}
}