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
		private var m_bx :int;
		private var m_by :int;
		public function MusicItem(tx:int, ty:int, name : String, diff : int, MaxSize:uint=0)
		{
			super(MaxSize);
			
			m_bx = tx;
			m_by = ty;
			
			
			m_bg = new MItemBg(m_bx, m_by);
			add(m_bg);
			m_bg.alpha = 0.1;
			m_focus = false;
			
			
			
			m_name = new FlxText(m_bx + 5, m_by + 5, 250, name);
			m_name.size = 16;
			add(m_name);
			
			m_difficulty = new FlxText(m_bx + 180, m_by + 25, 200, "Difficulty: " + diff.toString());
			m_difficulty.size = 14;
			add(m_difficulty);
			
			m_name.color = 0xFFAAAAAA;
			m_difficulty.color = 0xFFAAAAAA;
		}
		
		public function setFocus(flag :Boolean):void
		{
			m_focus = flag;
			if (m_focus)
			{
				m_bg.alpha = 0.75;
				m_name.color = 0xFF444444;
				m_difficulty.color = 0xFF444444;
			}
			else
			{
				m_bg.alpha = 0.15;
				m_name.color = 0xFFAAAAAA;
				m_difficulty.color = 0xFFAAAAAA;
			}
			m_bgShowing = true;
		}
		
		override public function preUpdate() : void
		{
			if (m_focus)
			{
				if (m_bgShowing)
				{
					m_bg.alpha += 0.004;
					trace(m_bg.alpha);
					if (m_bg.alpha >= 0.8)
						m_bgShowing = false;
				}
				else
				{
					m_bg.alpha -= 0.004;
					if (m_bg.alpha <= 0.6)
						m_bgShowing = true;
				}
			}
			else
			{
				if (m_bgShowing)
				{
					m_bg.alpha += 0.0005;
					if (m_bg.alpha >= 0.15)
						m_bgShowing = false;
				}
				else
				{
					m_bg.alpha -= 0.0005;
					if (m_bg.alpha <= 0.1)
						m_bgShowing = true;
				}
			}
		}
		
	}
}