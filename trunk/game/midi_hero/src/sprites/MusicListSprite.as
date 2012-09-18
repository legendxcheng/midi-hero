package sprites
{
	import logics.GameLogic;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	public class MusicListSprite extends FlxGroup
	{
		private var m_musicList : Array;
		private var m_focusID : int;
		private var m_inited :Boolean;
		public function MusicListSprite(MaxSize:uint=0)
		{
			super(MaxSize);
			m_focusID = 0;
			m_inited = false;
			// wait for load json
			
		}
		
		override public function preUpdate():void
		{
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
			}
			else
			{
			// handle keyboard
				if (FlxG.keys.any())
				{
					m_musicList[m_focusID].setFocus(false);
					
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