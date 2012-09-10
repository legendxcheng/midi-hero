package sprites
{
	import flash.display.BitmapData;
	
	import logics.Evaluator;
	import logics.GameLogic;
	import logics.SceneMgr;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	
	
	public class Hero extends FlxSprite
	{
		private var c_GJumping : Number;
		private var c_GFalling : Number;
		private var c_upForce : int;
		private var m_G : Number;
		private var m_xSpd : int;
		private var m_upForce : Number;
		private var m_ySpd : Number;
		
		private static var m_maxYSpd : Number;
		private static var m_minYSpd : Number;
		private var m_onNote : Boolean; // if hero is on the note block
		private var m_isJumping : Boolean;
		private var m_begin : Boolean;
		private var m_timeToDrop : Number;

		private var m_lastOnNote : Boolean;
		private var m_noteBeginX : int;
		private var m_noteEndX : int;
		
		private var m_color : uint;
		private var m_noteMiss : Boolean;
		
		private var m_minY : Number;
		
		public function Hero(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			frameHeight =height = 4;
			frameWidth = width = 4;
			frames = 1;
			frame = 0;
			m_color = 0xFFFFFFFF;
			_pixels = new BitmapData(4, 4, true, m_color);
			resetHelpers();
			
			c_GJumping = 0.8;
			c_GFalling = 1.6;
			m_xSpd = Math.round(1 / GameLogic.getInstance().timeScale);
			m_G = 0.8;
			m_ySpd = 0;
			m_upForce = 3.0;
			
			m_minYSpd = -3.0;
			m_maxYSpd = 5.0;
			
			m_onNote = false;
			
			m_timeToDrop = 0;
			m_begin = false;
			
			m_noteMiss = false;
			m_minY = 100;
			
			
		}
		
		public static function get maxYSpd():Number
		{
			return m_maxYSpd;
		}

		override public function preUpdate():void
		{
			SceneMgr.getInstance().addHeroY(y);
			m_lastOnNote = m_onNote;
			if (!m_begin)
			{
				x = SceneMgr.getInstance().getFirstNoteX();
				y = SceneMgr.getInstance().getFirstNoteY();
				if (x <= GameLogic.screenWidth / 2)
				{
					x = GameLogic.screenWidth / 2;
					m_begin = true;
				}
				else
					return;
			}
			
			var sm : SceneMgr = SceneMgr.getInstance();
			if (!m_onNote)
				m_ySpd += m_G;
			else 
				m_ySpd = 0;
			
			if (FlxG.keys.J)
			{
				if (m_isJumping)
				{
					m_ySpd -= m_upForce;
					m_upForce /= (1 + 0.01 / sm.getWidthOffset());
				}
				else if (m_onNote)
				{
					var tmp : int = SceneMgr.getInstance().getHeightOffset();
					if (tmp > 0)
					{
						c_upForce = tmp * 10;
					}
					else 
					{
						c_upForce = 2.5;
					}
					
					m_upForce = c_upForce;
					m_ySpd -= m_upForce;
					var tmp2 : Number = sm.getWidthOffset();
					if (tmp2 != 0)
						m_upForce /= (1 + 0.001 / tmp2);
					else
					{
						m_upForce = 0;
						m_ySpd = 0;
					}
					m_isJumping = true;
					m_G = c_GJumping;
				}
			}
				
				
			else if (!FlxG.keys.J && m_isJumping)
			{
				m_isJumping = false;
				m_G = c_GFalling;
			}
			
			
			
			if (m_ySpd > m_maxYSpd)
				m_ySpd = m_maxYSpd;
			
			if (m_ySpd < m_minYSpd)
				m_ySpd = m_minYSpd;
			
			
			y += m_ySpd;
			if (y < m_minY)
				y = m_minY;
			
			
			if (y > SceneMgr.getInstance().soundPlayFloor)
			{
				if (y - SceneMgr.getInstance().soundPlayFloor >= 10)
				{
					m_noteMiss = true;
					//Evaluator.getInstance().addMiss(SceneMgr.getInstance().soundPlayFloor);
				}
				else
					m_noteMiss = false;
				
				m_noteBeginX = SceneMgr.getInstance().getCurrentNoteX();
				y = SceneMgr.getInstance().soundPlayFloor;
				m_ySpd = 0;
				if (m_onNote == false && this.y < GameLogic.screenHeight)
				{
					// play sound
					m_isJumping = false;
					
					
					
					if (!m_noteMiss)
						SceneMgr.getInstance().heroHitNote();
					m_onNote = true;
					
				}
				
				
			}
			else if (y < SceneMgr.getInstance().soundPlayFloor)
			{
				if (m_onNote)
				{
					// stop sound
					SceneMgr.getInstance().stopSound();
				}
				m_onNote = false;
				
				
			}
			
			if (m_onNote && !m_noteMiss)
			{
				m_noteEndX = SceneMgr.getInstance().getCurrentNoteX();
				Evaluator.getInstance().setNoteState(m_noteBeginX - m_noteEndX);
			}
				
			
			// set onNote or not onNote
			if (m_lastOnNote && !m_onNote && !m_noteMiss)
			{
				m_noteEndX = SceneMgr.getInstance().getCurrentNoteX();
				Evaluator.getInstance().addCoverage(m_noteBeginX, m_noteEndX, SceneMgr.getInstance().currentNoteId, y);
				
			}
			if (!m_lastOnNote && m_onNote)
			{
				m_noteBeginX = SceneMgr.getInstance().getCurrentNoteX();
			}
			
			SceneMgr.getInstance().addHeroY(this.y);


		}
	}
}