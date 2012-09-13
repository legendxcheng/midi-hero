package states
{

	
	import org.flixel.FlxState;
	import sprites.VerdictGroup;
	
	public class VerdictState extends FlxState
	{
		private var m_vg : VerdictGroup;
		
		public function VerdictState()
		{
			super();
			m_vg = new VerdictGroup();
			add(m_vg);
			
		}
		
		
		
	}
	
	
}