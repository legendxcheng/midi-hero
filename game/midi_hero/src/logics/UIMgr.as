package logics
{
	import logics.GameLogic;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	
	public class UIMgr extends FlxGroup
	{
		private var m_time : FlxText;
		private var m_fps : FlxText;
		public function UIMgr(MaxSize:uint=0)
		{
			super(MaxSize);
			m_time = new FlxText(0, 0, 200, "");
			m_fps = new FlxText(300, 0, 200, "");
			m_time.scale = new FlxPoint(1.0, 1.0);
			m_fps.scale = new FlxPoint(3.0, 3.0);
			add(m_time);
			add(m_fps);
		}
		
		override public function preUpdate() : void
		{
			m_time.text = GameLogic.getInstance().getTime().toString();
			m_fps.text = (1 / FlxG.elapsed).toString();
		}
	}
	
	
}