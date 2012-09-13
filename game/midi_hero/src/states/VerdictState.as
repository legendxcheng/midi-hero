package states
{
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxState;
	
	import sprites.FinalBlock;
	import sprites.HeroFX;
	
	public class VerdictState extends FlxState
	{
		private var m_fb : FinalBlock =  new FinalBlock();
		public function VerdictState()
		{
			super();
			
			var tmp : HeroFX = new HeroFX();
			tmp.x = GameLogic.screenWidth / 2;
			tmp.y = GameLogic.finalFlorrHeight - 4;
			add(tmp);
			for (var i: int = 0; i < SceneMgr.getInstance().hfxNum; ++i)
			{
				var tmp2 : HeroFX = SceneMgr.getInstance().heroFx[i];
				tmp = new HeroFX();
				tmp.x = tmp2.x;
				tmp.y = tmp2.y;
				tmp.alpha = tmp2.alpha;
				add(tmp);
			}
			m_fb = new FinalBlock();
			m_fb.y = GameLogic.finalFlorrHeight;
			add(m_fb);
		}
	}
}