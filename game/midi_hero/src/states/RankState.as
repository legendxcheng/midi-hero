package states
{
	import org.flixel.FlxState;
	import sprites.RankSprite;
	public class RankState extends FlxState
	{
		private var m_sprite :RankSprite;
		
		public function RankState()
		{
			super();
			m_sprite = new RankSprite();
			add(m_sprite);
		}
		
		
	}
}