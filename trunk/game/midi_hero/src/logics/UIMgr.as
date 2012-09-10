

package logics
{
	import logics.Evaluator;
	import logics.GameLogic;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	import sprites.NoteHitState;
	
	
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
		private var m_cNum : int;
		
		private var m_cStreakTxt : FlxText;
		private var m_lStreakTxt : FlxText;
		
		private var m_hitMiss : FlxText;
		private var m_hitMissFx : FlxText;
		private var m_hmFxShowing : Boolean;
		
		
		private var m_stkLColor : uint;
		private var m_stkCColor : uint;
		private var m_stkStep : uint;
		private var m_stkFlap : Boolean;
	
		private var m_coverageTxt : Array;
		private var m_noteHitState : NoteHitState;
		
		private static var m_instance : UIMgr = null;
		
		public function resetHitMiss(isHit : Boolean, hit : int, tot : int) : void
		{
			
			m_hitMissFx.text = m_hitMiss.text = "Hit: " + hit.toString() + "/" + tot.toString();
			if (isHit)
				m_hitMissFx.color = 0x71e62e; // set green
			else 
				m_hitMissFx.color = 0xff0000;
			m_hmFxShowing = true;
		}

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
		
		public function addCoverageTxt(co : Number, hy : Number, stx : Number, pct : Number) : void
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
			m_missText.x = GameLogic.screenWidth / 2 - 40;
			
		}
		
		public function addStreakTxt(tc : uint, hy: int, stk : int) : void
		{
			m_cStreakTxt.text = m_lStreakTxt.text = "+" + (stk).toString() + "% Streak " + stk.toString() + " !";
			m_stkFlap = !m_stkFlap;
			if (m_stkFlap)
			{
				//m_cStreakTxt.text = "+" + (stk * 100).toString() + "% Streak " + stk.toString() + " !";		
				m_cStreakTxt.color = tc;
				m_cStreakTxt.alpha = 0;
				m_lStreakTxt.alpha = 1.0;
			}
			else
			{
						
				m_lStreakTxt.color = tc;
				m_lStreakTxt.alpha = 0;
				m_cStreakTxt.alpha = 1.0;
			}
			
			
			
		}
		
		public function resetNoteHitState(co : Number) : void
		{
			m_noteHitState.newNote(co);
		}
		
		public function updateNoteHitStateArea(rpct : Number) : void
		{
			m_noteHitState.updateHitArea(rpct);
		}
		public function addNoteHitStateArea(lpct : Number, rpct : Number) : void
		{
			m_noteHitState.addHitArea(lpct, rpct);
		}
		
		
		
		public function UIMgr(MaxSize:uint=0)
		{
			super(MaxSize);
			
			
			
			m_hitMiss = new FlxText(435, 0, 200, "");
			m_hitMiss.alignment = "right";
			m_hitMiss.size = 14;
			m_hitMiss.text = "Hit: 0/0";
			add(m_hitMiss);
			m_hitMissFx = new FlxText(435, 0, 200, "");
			m_hitMissFx.alignment = "right";
			m_hitMissFx.size = 14;
			m_hitMissFx.alpha = 0;
			m_hitMissFx.text = "Hit: 0/0";
			add(m_hitMissFx);
			
			m_time = new FlxText(150, 5, 200, "");
			//m_fps = new FlxText(300, 0, 200, "");
			m_time.scale = new FlxPoint(2.5, 2.5);
			//m_fps.scale = new FlxPoint(3.0, 3.0);

			m_score = new FlxText(320, 5, 200, "");
			m_score.scale = new FlxPoint(2.5, 2.5);
			
			m_notePercent = new FlxText(600, 80, 200, "");
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
			
			m_cStreakTxt = new FlxText(435, 20, 200, "");
			m_cStreakTxt.size = 14;
			m_cStreakTxt.alignment = "right";
			add(m_cStreakTxt);
			m_lStreakTxt = new FlxText(435, 20, 200, "");
			m_lStreakTxt.size = 14;
			m_lStreakTxt.alignment = "right";
			add(m_lStreakTxt);
			
			m_missText = new FlxText(1000, 100, 200, "Miss");
			m_missText.size = 18;
			
			add(m_missText);
			
		
			m_stkFlap = false;
			
			m_noteHitState = new NoteHitState();
			m_noteHitState.x = 370;
			m_noteHitState.y = 10;
			add(m_noteHitState);
			
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
			if (m_hmFxShowing)
			{
				m_hitMissFx.alpha += 0.05;
				if (m_hitMissFx.alpha >= 1)
				{
					m_hmFxShowing = false;
				}
			}
			else if (m_hitMissFx.alpha > 0)
			{
				m_hitMissFx.alpha -= 0.02;	
			}
			
			
			
			// color transform of streakText
			if (m_stkFlap)
			{
				m_cStreakTxt.alpha += 0.02;
				m_lStreakTxt.alpha -= 0.02;
				if (m_lStreakTxt.alpha == 0)
				{
					m_lStreakTxt.text = "";
					m_stkFlap = !m_stkFlap;
				}
			}
			else
			{
				m_cStreakTxt.alpha -= 0.01;
				m_lStreakTxt.alpha += 0.01;
				if (m_cStreakTxt.alpha == 0)
				{
					m_cStreakTxt.text = "";
					m_stkFlap = !m_stkFlap;
				}
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