package sprites
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import states.MusicListState;
	import logics.SceneMgr;
	public class PlaySprite extends FlxGroup
	{
		private var m_pressTxt:FlxText;
		private var m_ptShowing :Boolean;
		
		public function PlaySprite(MaxSize:uint=0)
		{
			super(MaxSize);
			m_ptShowing = true;
			
			m_pressTxt = new FlxText(70, 430, 800, "Press J to Jump   Press R to Return");
			m_pressTxt.size = 20;
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
			
			if (FlxG.keys.justPressed("R"))
			{
				SceneMgr.getInstance().stopSound();
				FlxG.switchState(new MusicListState());			
				
			}
		}
	}
}