

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
		private var m_scoreDisplay : Number;
		
		private var m_notePercent : FlxText;
		private var m_missText : FlxText;
		private var m_cStart : int;
		private var m_cEnd : int;
		private var m_coverageTxt : Array;
		private var m_cNum : int;
		
		private var m_cStreakTxt : FlxText;
		private var m_lStreakTxt : FlxText;
		private var m_stkLColor : uint;
		private var m_stkCColor : uint;
		private var m_stkStep : uint;
		private var m_stkFlap : Boolean;

		
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
		
		public function addMissTxt(hy : int) : void
		{
			m_missText.y = hy - 20;
			m_missText.alpha = 1.0;
			m_missText.x = GameLogic.screenWidth / 2;
			
		}
		
		public function addStreakTxt(tc : uint, hy: int, stk : int) : void
		{
			m_cStreakTxt.text = m_lStreakTxt.text = "+" + (stk * 100).toString() + "% Streak " + stk.toString() + " !";
			m_stkFlap = !m_stkFlap;
			if (m_stkFlap)
			{
				//m_cStreakTxt.text = "+" + (stk * 100).toString() + "% Streak " + stk.toString() + " !";		
				m_cStreakTxt.color = tc;
				m_cStreakTxt.alpha = 0;
			}
			else
			{
						
				m_lStreakTxt.color = tc;
				m_lStreakTxt.alpha = 0;
			}
			
			
			
		}
		
		public function UIMgr(MaxSize:uint=0)
		{
			super(MaxSize);
			m_time = new FlxText(150, 0, 200, "");
			//m_fps = new FlxText(300, 0, 200, "");
			m_time.scale = new FlxPoint(2.5, 2.5);
			//m_fps.scale = new FlxPoint(3.0, 3.0);

			m_score = new FlxText(350, 0, 200, "");
			m_score.scale = new FlxPoint(2.5, 2.5);
			
			m_notePercent = new FlxText(600, 0, 200, "");
			m_notePercent.scale = new FlxPoint(1.0, 1.0);
			
			add(m_time);
			//add(m_fps);
			add(m_score);
			add(m_notePercent);
			
			m_cStart = 0;
			m_cEnd = -1;
			m_coverageTxt = new Array();
			m_cNum = 0;
			
			m_scoreDisplay = 0;
			
			for (var i : int = 0; i < 10; ++i)
			{
				var ft : FlxText = new FlxText(0, 0, 200, "");
				m_coverageTxt.push(ft);
				ft.alignment = "left";

			}
			
			m_cStreakTxt = new FlxText(435, 5, 200, "");
			m_cStreakTxt.size = 14;
			m_cStreakTxt.alignment = "right";
			add(m_cStreakTxt);
			m_lStreakTxt = new FlxText(435, 5, 200, "");
			m_lStreakTxt.size = 14;
			m_lStreakTxt.alignment = "right";
			add(m_lStreakTxt);
			
			m_missText = new FlxText(1000, 100, 200, "Miss");
			m_missText.size = 14;
			add(m_missText);
		
			m_stkFlap = false;
		}
		
		override public function preUpdate() : void
		{
			m_time.text = "Time: " + GameLogic.getInstance().getTime().toFixed(2);
			//m_fps.text = (1 / FlxG.elapsed).toString();
			
			var tmp : Number = Evaluator.getInstance().score;
			var step : Number = (tmp - m_scoreDisplay) / 60;
			if (step < 5) step = 5;
			m_scoreDisplay += step;
			if (m_scoreDisplay > Evaluator.getInstance().score)
				m_scoreDisplay = Evaluator.getInstance().score;
			m_score.text = "Score: " + m_scoreDisplay.toFixed(0) + "%";
			m_notePercent.text = Evaluator.getInstance().noteState.toFixed(2);
			
			// missText
			if (m_missText.alpha > 0)
			{
				m_missText.alpha -= 0.03;
				if (m_missText.alpha < 0)
					m_missText.alpha = 0;
				m_missText.x -= FlxG.elapsed / GameLogic.getInstance().timeScale;
				m_missText.y *= 0.99;
			}
			
			// color transform of streakText
			if (m_stkFlap)
			{
				m_cStreakTxt.alpha += 0.05;
				m_lStreakTxt.alpha -= 0.05;
			}
			else
			{
				m_cStreakTxt.alpha -= 0.05;
				m_lStreakTxt.alpha += 0.05;
			}

			
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