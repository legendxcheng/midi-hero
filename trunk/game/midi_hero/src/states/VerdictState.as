package states
{
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	import sprites.FinalBlock;
	import sprites.HeroFX;
	
	public class VerdictState extends FlxState
	{
		private var m_fb : FinalBlock =  new FinalBlock();
		private var m_heroFX : Array;
		private var m_timeTxt : FlxText;
		private var m_scoreTxt : FlxText;
		private var m_maxStreakTxt : FlxText;
		private var m_noteHitTxt : FlxText;
		private var m_rankTxt : FlxText;
		private var m_frameCnt : int;
		
		public function VerdictState()
		{
			super();
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
			m_scoreTxt = new FlxText(10, 60, 300, "Score ");
			m_scoreTxt.size = 32;
			m_scoreTxt.alignment = "right";
			m_maxStreakTxt = new FlxText(10, 100, 300, "Max Streak ");
			m_maxStreakTxt.size = 32;
			m_maxStreakTxt.alignment = "right";
			m_noteHitTxt = new FlxText(10, 140, 300, "Notes Hit ");
			m_noteHitTxt.size = 32;
			m_noteHitTxt.alignment = "right";
			m_rankTxt = new FlxText(10, 220, 300, "Rank ");
			m_rankTxt.size = 64;
			m_rankTxt.alignment = "right";
			
			
			add(m_scoreTxt);
			add(m_timeTxt);
			add(m_maxStreakTxt);
			add(m_noteHitTxt);
			add(m_rankTxt);
		}
		
	}
}