package sprites
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.osmf.traits.MediaTraitBase;
	
	public class MusicItem extends FlxGroup
	{
		private var m_focus : Boolean;
		private var m_id;
		
		private var m_name :FlxText;
		private var m_difficulty :FlxText;
		private var m_bg : MItemBg;
		private var m_bgShowing :Boolean;
		public function MusicItem(name : String, diff : int, MaxSize:uint=0)
		{
			super(MaxSize);
			m_bg = new MItemBg;
			m_focus = false;
			
			m_name = new FlxText(10, 20, 200, name);
			m_name.size = 20;
			add(m_name);
			
			m_difficulty = new FlxText(100, 30, 200, "Difficulty: " + diff.toString());
			m_difficulty.size = 20;
			add(m_difficulty);
		}
		
		public function setFocus(flag :Boolean):void
		{
			m_focus = flag;
		}
		
		override public function preUpdate() : void
		{
			if (m_focus)
			{
				if (m_bgShowing)
				{
					m_bg.alpha += 0.01;
					if (m_bg.alpha >= 0.9)
						m_bgShowing = false;
				}
				else
				{
					m_bg.alpha -= 0.01;
					if (m_bg.alpha <= 0.7)
						m_bgShowing = true;
				}
			}
			else
			{
				if (m_bgShowing)
				{
					m_bg.alpha += 0.01;
					if (m_bg.alpha >= 0.6)
						m_bgShowing = false;
				}
				else
				{
					m_bg.alpha -= 0.01;
					if (m_bg.alpha <= 0.4)
						m_bgShowing = true;
				}
			}
		}
		
	}
}