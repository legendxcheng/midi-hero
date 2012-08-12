

package logics
{
	import logics.Evaluator;
	import logics.GameLogic;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	
	//[Embed(source = 'F:\\MidiHero\\midi-hero\\trunk\\game\\midi_hero\\Adore64.ttf', fontName = "Adore64")]
	public class UIMgr extends FlxGroup
	{
		private var m_time : FlxText;
		private var m_fps : FlxText;
		private var m_score : FlxText;
		private var m_notePercent : FlxText;
		
		private var m_cStart : int;
		private var m_cEnd : int;
		private var m_coverageTxt : Array;
		private var m_cNum : int;
		
		private var m_streakTxt : FlxText;

		
		private static var m_instance : UIMgr = null;
		

		public static function getInstance() : UIMgr
		{
			if (m_instance == null)
				m_instance = new UIMgr();
			return m_instance;
		}
		
		private function getCoverageSize(pct : Number) : Number
		{
		
			return 12 + 0.08 * pct;
		}
		
		public function addCoverageTxt(co : Number, hy : Number, pct : Number) : void
		{
			++m_cNum;
			++m_cEnd;
			if (m_cEnd == m_coverageTxt.length)
				m_cEnd = 0;
			var ft : FlxText = m_coverageTxt[m_cEnd];
			ft.text = "+" + pct.toFixed(2) + "%";
			ft.x = GameLogic.screenWidth / 2;
			ft.y = hy - 20;
			ft.alpha = 1.0;
			ft.size = getCoverageSize(pct);
			ft.color = co;

			add(ft);
			
		}
		
		public function addStreakTxt(hy: int, stk : int) : void
		{
			
			m_streakTxt.text = "+" + (stk * 100).toString() + "% Streak " + stk.toString() + " !";
			m_streakTxt.x = GameLogic.screenWidth / 2;
			m_streakTxt.y = hy - 50;
			m_streakTxt.alpha = 1.0;
			m_streakTxt.size = 14;


			
		}
		
		public function UIMgr(MaxSize:uint=0)
		{
			super(MaxSize);
			m_time = new FlxText(150, 0, 200, "");
			m_fps = new FlxText(300, 0, 200, "");
			m_time.scale = new FlxPoint(2.5, 2.5);
			m_fps.scale = new FlxPoint(3.0, 3.0);

			m_score = new FlxText(450, 0, 200, "");
			m_score.scale = new FlxPoint(2.5, 2.5);
			
			m_notePercent = new FlxText(600, 0, 200, "");
			m_notePercent.scale = new FlxPoint(1.0, 1.0);
			
			add(m_time);
			add(m_fps);
			add(m_score);
			add(m_notePercent);
			
			m_cStart = 0;
			m_cEnd = -1;
			m_coverageTxt = new Array();
			m_cNum = 0;
			
			for (var i : int = 0; i < 10; ++i)
			{
				var ft : FlxText = new FlxText(0, 0, 200, "");
				m_coverageTxt.push(ft);
				ft.alignment = "left";

			}
			
			m_streakTxt = new FlxText(500, 50, 200, "");
			m_streakTxt.size = 20;
			add(m_streakTxt);
			
		}
		
		override public function preUpdate() : void
		{
			m_time.text = "Time: " + GameLogic.getInstance().getTime().toFixed(2);
			m_fps.text = (1 / FlxG.elapsed).toString();
			m_score.text = "Score: " + Evaluator.getInstance().score.toString() + "%";
			m_notePercent.text = Evaluator.getInstance().noteState.toFixed(2);
			
			
			// Move m_bonusTxt to left
			var ind : int = m_cStart;
			while(m_cNum > 0)
			{
				var ft : FlxText = m_coverageTxt[ind];
				ft.x -= FlxG.elapsed / GameLogic.getInstance().timeScale;
				ft.y *= 0.99;
				ft.alpha -= 0.02;
				if (ft.alpha <= 0)
				{
					remove(ft);
					if (m_cStart == m_cEnd)
					{
						--m_cNum;
						++m_cStart;
						if (m_cStart == m_coverageTxt.length)
							m_cStart = 0;
						break;
					}
					else
					{
						--m_cNum;
						++m_cStart;
						if (m_cStart == m_coverageTxt.length)
							m_cStart = 0;
					}
				}
				
				
				if (ind == m_cEnd)
					break;
				++ind;
				if (ind == m_coverageTxt.length)
				{
					ind = 0;
				}
				
			}
			
			
			
			
		}
	}
	
	
}