

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
		
		private var m_iStart : int;
		private var m_iEnd : int;
		private var m_bonusTxt : Array;
		private static var m_instance : UIMgr = null;
		public static function getInstance() : UIMgr
		{
			if (m_instance == null)
				m_instance = new UIMgr();
			return m_instance;
		}
		
		private function getCoverageScale(pct : Number) : Number
		{
		
			return 12 + 0.08 * pct;
		}
		
		public function addCoverageTxt(co : Number, hy : Number, pct : Number) : void
		{
			++m_iEnd;
			if (m_iEnd == m_bonusTxt.length)
				m_iEnd = 0;
			var ft : FlxText = m_bonusTxt[m_iEnd];
			ft.text = "+" + pct.toFixed(2) + "%";
			ft.x = GameLogic.screenWidth / 2;
			ft.y = hy - 20;
			ft.alpha = 1.0;
			ft.size = getCoverageScale(pct);
			ft.color = co;
			//ft.size = new FlxPoint(tmp, tmp);
			
		}
		
		public function UIMgr(MaxSize:uint=0)
		{
			super(MaxSize);
			m_time = new FlxText(150, 0, 200, "");
			//m_fps = new FlxText(300, 0, 200, "");
			m_time.scale = new FlxPoint(2.5, 2.5);
			//m_fps.scale = new FlxPoint(3.0, 3.0);

			m_score = new FlxText(450, 0, 200, "");
			m_score.scale = new FlxPoint(2.5, 2.5);
			
			m_notePercent = new FlxText(600, 0, 200, "");
			m_notePercent.scale = new FlxPoint(1.0, 1.0);
			
			add(m_time);
			//add(m_fps);
			add(m_score);
			add(m_notePercent);
			
			m_iStart = 0;
			m_iEnd = -1;
			m_bonusTxt = new Array();
			
			for (var i : int = 0; i < 50; ++i)
			{
				var ft : FlxText = new FlxText(0, 0, 200, "");
				m_bonusTxt.push(ft);
				ft.alignment = "left";
				add(ft);
			}
		}
		
		override public function preUpdate() : void
		{
			m_time.text = "Time: " + GameLogic.getInstance().getTime().toFixed(2);
			//m_fps.text = (1 / FlxG.elapsed).toString();
			m_score.text = "Score: " + Evaluator.getInstance().score.toString() + "%";
			m_notePercent.text = Evaluator.getInstance().noteState.toFixed(2);
			
			// Move m_bonusTxt to left
			var ind : int = m_iStart;
			while(m_iEnd >= 0)
			{
				var ft : FlxText = m_bonusTxt[ind];
				ft.x -= FlxG.elapsed / GameLogic.getInstance().timeScale;
				ft.y -= 1.0;
				ft.alpha -= 0.01;
				if (ft.alpha <= 0)
				{
					if (m_iStart == m_iEnd)
					{
						++m_iStart;
						if (m_iStart == m_bonusTxt.length)
							m_iStart = 0;
						break;
					}
					else
					{
						++m_iStart;
						if (m_iStart == m_bonusTxt.length)
							m_iStart = 0;
					}
				}
				
				
				if (ind == m_iEnd)
					break;
				++ind;
				if (ind == m_bonusTxt.length)
				{
					ind = 0;
				}
				
			}
		}
	}
	
	
}