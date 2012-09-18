package states
{
	import logics.GameLogic;
	
	import org.flixel.FlxState;
	
	import sprites.MenuSprite;
	import sprites.MusicItem;
	
	public class MenuState extends FlxState
	{
		
		private var m_sprites : MenuSprite;
		public function MenuState()
		{
			super();
			var gl :GameLogic = GameLogic.getInstance();
			m_sprites = new MenuSprite();
			add(m_sprites);
			
			
		}
	}
}