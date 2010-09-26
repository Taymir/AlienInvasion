package  
{
	import com.senocular.utils.KeyObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserControlledObject extends ControllableObject
	{
		protected var key:KeyObject;
		
		public function UserControlledObject() 
		{
			key = new KeyObject(stageRef);
			
			addEventListener(Event.ENTER_FRAME, keyHandler, false, 0, true);

		}
		
		protected function keyHandler(e: Event) : void
		{
			//@EMPTY: переопределяется в наследниках
		}
		
		protected override function destroy() : void
		{
			//Отвязываем все события
			this.removeEventListener(Event.ENTER_FRAME, keyHandler);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
	}

}