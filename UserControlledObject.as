package  
{
	import com.senocular.utils.KeyObject;
	import flash.display.Stage;
	import flash.events.Event;
	import common.TRegistry;
	import common.Debug;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserControlledObject extends ControllableObject
	{
		protected var key:KeyObject;
		private var stageRef:Stage;
		
		public function UserControlledObject() 
		{
			Debug.assert( TRegistry.instance.getValue("stage") != null, "В реестре TRegistry не установлено значение объекта сцены stage" );
			this.stageRef = TRegistry.instance.getValue("stage");
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