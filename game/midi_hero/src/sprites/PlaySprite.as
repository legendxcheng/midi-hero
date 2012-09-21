package sprites
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	
	public class PlaySprite extends FlxGroup
	{
		private var m_pressTxt:FlxText;
		private var m_ptShowing :Boolean;
		
		public function PlaySprite(MaxSize:uint=0)
		{
			super(MaxSize);
			m_ptShowing = true;
			
			m_pressTxt = new FlxText(140, 430, 800, "Press J to Jump");
			m_pressTxt.size = 40;
			m_pressTxt.alignment = "left";
			add(m_pressTxt);
			
			
		}
		
		public override function preUpdate() :void
		{
			if (!m_ptShowing)
			{
				m_pressTxt.alpha -= 0.01;
				if (m_pressTxt.alpha == 0)
					m_ptShowing = true;
			}
			else
			{
				m_pressTxt.alpha += 0.05;
				if (m_pressTxt.alpha == 1)
					m_ptShowing = false;
			}
		}
	}
}