package logics
{
	import logics.Evaluator;
	import logics.GameLogic;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	
	public class UIMgr extends FlxGroup
	{
		private var m_time : FlxText;
		private var m_fps : FlxText;
		private var m_score : FlxText;
		private var m_notePercent : FlxText;
		public function UIMgr(MaxSize:uint=0)
		{
			super(MaxSize);
			m_time = new FlxText(0, 0, 200, "");
			m_fps = new FlxText(300, 0, 200, "");
			m_time.scale = new FlxPoint(1.0, 1.0);
			m_fps.scale = new FlxPoint(3.0, 3.0);
			
			m_score = new FlxText(500, 0, 200, "");
			m_score.scale = new FlxPoint(1.0, 1.0);
			
			m_notePercent = new FlxText(600, 0, 200, "");
			m_notePercent.scale = new FlxPoint(1.0, 1.0);
			
			add(m_time);
			add(m_fps);
			add(m_score);
			add(m_notePercent);
		}
		
		override public function preUpdate() : void
		{
			m_time.text = GameLogic.getInstance().getTime().toString();
			m_fps.text = (1 / FlxG.elapsed).toString();
			m_score.text = Evaluator.getInstance().score.toString();
			m_notePercent.text = Evaluator.getInstance().noteState.toFixed(2);
		}
	}
	
	
}