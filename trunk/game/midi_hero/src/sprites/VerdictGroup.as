package sprites
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	
	import sprites.FinalBlock;
	import sprites.HeroFX;
	import logics.Evaluator;
	import logics.GameLogic;
	import logics.SceneMgr;
	
	public class VerdictGroup extends FlxGroup
	{
		private var m_fb : FinalBlock =  new FinalBlock();
		private var m_heroFX : Array;
		private var m_timeTxt : FlxText;
		private var m_timeTxt2 : FlxText;
		private var m_scoreTxt : FlxText;
		private var m_scoreTxt2 : FlxText;
		private var m_maxStreakTxt : FlxText;
		private var m_maxStreakTxt2 : FlxText;
		private var m_noteHitTxt : FlxText;
		private var m_noteHitTxt2 : FlxText;
		private var m_rankTxt : FlxText;
		private var m_rankTxt2 : FlxText;
		private var m_frameCnt : int;
		
		public function VerdictGroup(MaxSize:uint=0)
		{
			super(MaxSize);
			m_frameCnt = 0;
			m_heroFX = new Array();
			var tmp : HeroFX = new HeroFX();
			tmp.x = GameLogic.screenWidth / 2;
			tmp.y = GameLogic.finalFlorrHeight - 4;
			add(tmp);
			m_heroFX.push(tmp);
			for (var i: int = 0; i < SceneMgr.getInstance().hfxNum; ++i)
			{
				var tmp2 : HeroFX = SceneMgr.getInstance().heroFx[i];
				tmp = new HeroFX();
				tmp.x = tmp2.x;
				tmp.y = tmp2.y;
				tmp.alpha = tmp2.alpha;
				add(tmp);
				m_heroFX.push(tmp);
			}
			m_fb = new FinalBlock();
			m_fb.y = GameLogic.finalFlorrHeight;
			add(m_fb);
			
			//m_score = new FlxText(320, 5, 200, "");
			m_timeTxt = new FlxText(10, 20, 300, "Time ");
			m_timeTxt.size = 32;
			m_timeTxt.alignment = "right";
			m_timeTxt2 = new FlxText(300, 20, 300, "Time ");
			m_timeTxt2.size = 32;
			m_timeTxt2.alignment = "center";
			
			m_scoreTxt = new FlxText(10, 60, 300, "Score ");
			m_scoreTxt.size = 32;
			m_scoreTxt.alignment = "right";
			m_scoreTxt2 = new FlxText(300, 60, 300, "Time ");
			m_scoreTxt2.size = 32;
			m_scoreTxt2.alignment = "center";
			
			
			m_maxStreakTxt = new FlxText(10, 100, 300, "Max Streak ");
			m_maxStreakTxt.size = 32;
			m_maxStreakTxt.alignment = "right";
			m_maxStreakTxt2 = new FlxText(300, 100, 300, Evaluator.getInstance().maxStreak.toString());
			m_maxStreakTxt2.size = 32;
			m_maxStreakTxt2.alignment = "center";
			
			
			m_noteHitTxt = new FlxText(10, 140, 300, "Notes Hit ");
			m_noteHitTxt.size = 32;
			m_noteHitTxt.alignment = "right";
			m_noteHitTxt2 = new FlxText(300, 140, 300, "Notes Hit ");
			m_noteHitTxt2.size = 32;
			m_noteHitTxt2.alignment = "center";
			
			
			m_rankTxt = new FlxText(10, 220, 300, "Rank ");
			m_rankTxt.size = 64;
			m_rankTxt.alignment = "right";
			m_rankTxt2 = new FlxText(300, 190, 300, "");
			m_rankTxt2.size = 120;
			m_rankTxt2.alignment = "center";
			m_rankTxt2.color = 0xFFFF0000;
			
			switch (Math.floor(Evaluator.getInstance().getResult() / 0.1))
			{
				case 0:
					m_rankTxt2.text = "H";
					break;
				case 1:
					m_rankTxt2.text = "G";
					//g
					break;
				case 2:
					//f
					m_rankTxt2.text = "F";
					break;
				case 3:
					//e
					m_rankTxt2.text = "E";
					break;
				case 4:
					//d
					m_rankTxt2.text = "D";
					break;
				case 5:
					//c
					m_rankTxt2.text = "C";
					break;
				case 6:
					//b
					m_rankTxt2.text = "B";
					break;
				case 7:
					//a
					m_rankTxt2.text = "A";
					break;
				case 8:
				//s
					m_rankTxt2.text = "S";
					break;
				case 9:
					m_rankTxt2.text = "SS";
					//ss
					break;
				case 10:
					m_rankTxt2.text = "SSS";
					//sss
					break;
			}
			
			add(m_scoreTxt);
			add(m_timeTxt);
			add(m_timeTxt2);
			add(m_scoreTxt2);
			add(m_maxStreakTxt);
			add(m_maxStreakTxt2);
			add(m_noteHitTxt);
			add(m_noteHitTxt2);
			add(m_rankTxt);
			add(m_rankTxt2);
			m_rankTxt2.alpha = 0;
		}
		
		override public function preUpdate() : void
		{
			
			if (m_frameCnt < 30)
			{
				++m_frameCnt;
				m_timeTxt2.text = (Evaluator.getInstance().time / 30 * m_frameCnt).toFixed(2);
				m_scoreTxt2.text = (Evaluator.getInstance().score / 30 * m_frameCnt).toFixed(0);
				m_maxStreakTxt2.alpha = m_frameCnt * m_frameCnt / 900;
				m_noteHitTxt2.text = (Evaluator.getInstance().noteHit  * m_frameCnt / 30).toFixed(0) + "/" + 
					(Evaluator.getInstance().noteTot.toString());
			}
			else if (m_frameCnt < 40)
			{
				++m_frameCnt;
				m_rankTxt2.alpha = (m_frameCnt - 30) * (m_frameCnt - 30) / 100;
				
			}
		}
	}
}