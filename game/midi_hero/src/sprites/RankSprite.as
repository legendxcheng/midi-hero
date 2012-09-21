package sprites
{
	import logics.GameLogic;
	
	import states.MusicListState;
	import states.PlayState;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;

	public class RankSprite extends FlxGroup
	{
		private var m_titleTxt :FlxText;
		private var m_pressTxt:FlxText;
		private var m_ptShowing :Boolean;
		public function RankSprite(MaxSize:uint=0)
		{
			super(MaxSize);
			var mn :String = GameLogic.getInstance().musicList[GameLogic.getInstance().midiID].name;
			m_titleTxt = new FlxText(50, 20, 500, "Ranklis of " + mn);
			m_titleTxt.size = 30;
			add(m_titleTxt);
			
			m_ptShowing = true;
			
			m_pressTxt = new FlxText(70, 430, 800, "Press J to Start   Press R to return");
			m_pressTxt.size = 20;
			m_pressTxt.alignment = "left";
			add(m_pressTxt);
			
			var i:int;
			for (i = 0; i < GameLogic.getInstance().rankList.length; ++i)
			{
					
				var t1 :FlxText = new FlxText(50, 100 + i * 25, 500, (i+1).toString() + ". " +
					GameLogic.getInstance().rankList[i].player);
				t1.size = 15;
				add(t1);
				var t2:FlxText = new FlxText(300, 100 + i * 25, 500, GameLogic.getInstance().rankList[i].score);
				t2.size = 15;
				add(t2);
			}
		}
		
		override public function preUpdate():void
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
				FlxG.switchState(new MusicListState());			
			
			}
			if (FlxG.keys.justPressed("J"))
			{
				FlxG.switchState(new PlayState());
			}
			
		}
	}
}