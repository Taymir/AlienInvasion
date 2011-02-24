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
		
		public function update()
		{
			fsm.update();
		}
		
	}

}