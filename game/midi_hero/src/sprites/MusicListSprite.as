package sprites
{
	import logics.GameLogic;
	import states.PlayState;	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;

	
	public class MusicListSprite extends FlxGroup
	{
		private var m_musicList : Array;
		private var m_focusID : int;
		private var m_inited :Boolean;
		private var m_titleTxt :FlxText;
		private var m_pressTxt:FlxText;
		private var m_ptShowing :Boolean;
		public function MusicListSprite(MaxSize:uint=0)
		{
			super(MaxSize);
			
			m_ptShowing = true;
			
			m_pressTxt = new FlxText(140, 430, 800, "Press J to Start");
			m_pressTxt.size = 40;
			m_pressTxt.alignment = "left";
			add(m_pressTxt);
			
			m_focusID = 0;
			m_inited = false;
			// wait for load json
			m_titleTxt = new FlxText(20, 10, 640, "Select a midi to play");
			m_titleTxt.size = 40;
			add(m_titleTxt);
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
			
			
			if (!m_inited)
			{
				var gl :GameLogic = GameLogic.getInstance();
				if (gl.musicList == null)
					return;
				m_inited = true;
				m_musicList = new Array();
				var i: int;
				for (i = 0; i < gl.musicList.length; ++i)
				{
					var tx:int;
					var ty:int;
					if (i % 2 == 0)
					{
						tx = 15;
						ty = 100 + 55 * i / 2;
					}
					else
					{
						tx = 325;
						ty = 100 + 55 * (i - 1) / 2;
					}
					var tmp :MusicItem = new MusicItem(tx, ty, gl.musicList[i].id.toString() + ". " +  gl.musicList[i].name,
						gl.musicList[i].difficulty);
					m_musicList.push(tmp);
					add(tmp);
					
				}
				m_musicList[0].setFocus(true);
			}
			else
			{
			// handle keyboard
				if (FlxG.keys.any())
				{
					m_musicList[m_focusID].setFocus(false);
					
					if (FlxG.keys.justPressed("J"))
					{
						trace(GameLogic.getInstance().musicList[m_focusID].addr);
						GameLogic.getInstance().midiAddr = GameLogic.getInstance().musicList[m_focusID].addr;
						FlxG.switchState(new PlayState());
					}
					
					if (FlxG.keys.justPressed("LEFT"))
					{
						m_focusID -= 1;
					}
					if (FlxG.keys.justPressed("UP"))
					{
						m_focusID -= 2;
					}
					if (FlxG.keys.justPressed("DOWN"))
					{
						m_focusID += 2;
					}
					if (FlxG.keys.justPressed("RIGHT"))
					{
						m_focusID += 1;
					}
					if (m_focusID < 0)
						m_focusID = 0;
					if (m_focusID >= m_musicList.length)
						m_focusID = m_musicList.length - 1;
					m_musicList[m_focusID].setFocus(true);
					
					if (FlxG.keys.justPressed("J"))
					{
						// select music	
					}

				}
			}
		}
	}
}