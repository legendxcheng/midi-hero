package sprites
{
	import logics.GameLogic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import states.MusicListState;

	public class MenuSprite extends FlxGroup
	{
		private var m_floorHeight : int;
		private var m_heros : Array;
		private var m_heroY : Array;
		private var m_heroYk : int;
		private var m_G : Number;
		private var m_ySpeed : Number;
		private var m_tickToJump : int;
		private var m_rising:Boolean;
		private var m_tickToRush : int;
		private var m_txtM :FlxText;
		private var m_txtI :FlxText;
		private var m_txtD :FlxText;
		private var m_txtI2 :FlxText;
		private var m_txtH :FlxText;
		private var m_txtE :FlxText;
		private var m_txtR :FlxText;
		private var m_txtO :FlxText;
		private var m_txtArr : Array;
		private var m_pressTxt : FlxText;
		private var m_ptShowing : Boolean;
		
		
		public function MenuSprite(MaxSize:uint=0)
		{
		
			super(MaxSize);
			
			m_pressTxt = new FlxText(140, 400, 800, "Press J to Play");
			m_pressTxt.size = 40;
			m_pressTxt.alignment = "left";
			add(m_pressTxt);
			m_ptShowing = false;
			
			m_txtArr = new Array();
			
			var fntY : int = 40;
			m_txtM = new FlxText(50, fntY, 100, "M");
			m_txtM.size = 80;
			add(m_txtM);
			m_txtM.color = 0xFFAED637;
			m_txtI = new FlxText(130, fntY, 100, "i");
			m_txtI.size = 80;
			m_txtI.color = 0xFFFF1111;
			add(m_txtI);
			m_txtI.color = 0xFF47ffff;
			m_txtD = new FlxText(160, fntY, 100, "d");
			m_txtD.size = 80;
			m_txtD.color = 0xff007cdc;
			add(m_txtD);
			m_txtI2 = new FlxText(220, fntY, 100, "i");
			m_txtI2.size = 80;
			m_txtI2.color = 0xFF887DDD;
			add(m_txtI2);
			
			m_txtH = new FlxText(250, fntY, 100, "H");
			m_txtH.size = 100;
			m_txtH.color = 0xFFFF1244;
			add(m_txtH);
			m_txtE = new FlxText(320, fntY, 100, "e");
			m_txtE.size = 100;
			m_txtE.color = 0xFFFF8345;
			add(m_txtE);
			m_txtR = new FlxText(390, fntY, 100, "r");
			m_txtR.size = 100;
			m_txtR.color = 0xFFF8BD0B;
			add(m_txtR);
			m_txtO = new FlxText(450, fntY, 100, "o");
			m_txtO.size = 100;
			m_txtH.color = 0xFFD1D2D4;
			add(m_txtO);
			
			m_txtArr.push(m_txtM);
			m_txtArr.push(m_txtI);
			m_txtArr.push(m_txtD);
			m_txtArr.push(m_txtI2);
			m_txtArr.push(m_txtH);
			m_txtArr.push(m_txtE);
			m_txtArr.push(m_txtR);
			m_txtArr.push(m_txtO);
			
			
			m_G = 2;
			m_floorHeight = 300;
			var i : int;
			m_heros = new Array();
			m_heroY = new Array();
			for (i = 0; i < 120; ++i)
			{
				m_heroY.push(m_floorHeight);
			}
			
			for (i = 0; i < 10; ++i)
			{
				var tmp : HeroFX = new HeroFX(50);
				tmp.alpha = 1 - i * 0.1;
				m_heros.push(tmp);
				
				add(tmp);
			}
			m_heros[0].x = GameLogic.screenWidth / 2;
			m_ySpeed = 0;
			m_heroYk = 0;
			m_tickToJump = 100;
		}
		
		override public function preUpdate() : void
		{
			if (FlxG.keys.J)
			{
				FlxG.switchState(new MusicListState());
			}
			
			
			if (!m_ptShowing)
			{
				m_pressTxt.alpha -= 0.01;
				if (m_pressTxt.alpha == 0)
					m_ptShowing = true;
			}
			else
			{
				m_pressTxt.alpha += 0.05;
				if (m_pressTxt.alpha == 1)
					m_ptShowing = false;
			}
			
			m_ySpeed += m_G;
			if (m_ySpeed < 0)
				m_rising = true;
			
			if (m_rising && m_ySpeed >=0)
			{
				// change floorHeight
				m_floorHeight = m_heros[0].y + Math.random() * 500;
				if (m_floorHeight > 350)
					m_floorHeight = 350;
				if (m_floorHeight < 200)
					m_floorHeight = 200;
				
			}
			
			if (m_ySpeed >= 0)
				m_rising = false;
			
			if (m_rising)
			{
				m_heros[0].x += -m_ySpeed / 3;
				if (m_heros[0].x > 550)
					m_heros[0].x = 550;
			}
			else
			{
				m_heros[0].x -= 1;
				if (m_heros[0].x < 200)
					m_heros[0].x = 200;
			}
			
			var tmp : HeroFX = m_heros[0];
			tmp.y += m_ySpeed;
			if (tmp.y > m_floorHeight)
			{
				m_ySpeed = 0;
				tmp.y = m_floorHeight;
			}
			
			m_heroY[m_heroYk] = tmp.y; 
			++m_heroYk;
			if (m_heroYk == 120)
				m_heroYk = 0;
			
			var i : int;
			for (i = 1; i < 10; ++i)
			{
				var tmp2 : HeroFX = m_heros[i];
				var kk = m_heroYk - i * (i + 1) / 2;
				if (kk < 0) 
					kk += 120;
				tmp2.x = m_heros[0].x - i * (i+1) * 1.5;
				tmp2.y = m_heroY[kk];
			}
			
			if (m_ySpeed == 0)
			{
				--m_tickToJump;
				if (m_tickToJump <= 0)
				{
					m_ySpeed = -Math.random() * 15 - 20;
					m_tickToJump = Math.floor(Math.random() * 100);
				}
			}
			
		}
	}
}