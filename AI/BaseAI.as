package AI 
{
	import FSM.FSM;
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseAI 
	{
		protected var fsm : FSM;
		public var enabled: Boolean = true;
		
		public function update()
		{
			if(enabled)
				fsm.update();
		}
		
	}

}