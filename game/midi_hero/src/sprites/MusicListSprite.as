package sprites
{
	import logics.GameLogic;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	public class MusicListSprite extends FlxGroup
	{
		private var m_musicList : Array;
		private var m_focusID : int;
		public function MusicListSprite(MaxSize:uint=0)
		{
			super(MaxSize);
			m_focusID = 0;
			
			// wait for load json
			var gl :GameLogic = GameLogic.getInstance();
			while (gl.musicList == null)
				;
			
			m_musicList = new Array();
			var i: int;
			for (i = 0; i < gl.musicList.length; ++i)
			{
				if (i % 2 == 0)
				{
					var tmp :MusicItem = new MusicItem(gl.musicList[i].id.toString() + ". " +  gl.musicList[i].name,
						gl.musicList[i].difficulty);
					m_musicList.push(tmp);
					add(tmp);
				}
			}
		}
		
		override public function preUpdate():void
		{
			// handle keyboard
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
			m_musicList[m_focusID].setFocus(true);
			
			if (FlxG.keys.justPressed("J"))
			{
				// select music	
			}
		}
	}
}