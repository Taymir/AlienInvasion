package  
{
	import com.senocular.utils.KeyObject;
	import flash.display.Stage;
	import flash.events.Event;
	import common.TRegistry;
	import common.Debug;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Taymir
	 */
	public class UserControlledObject extends ControllableObject
	{
		protected var key:KeyObject;
		private var stageRef:Stage;
		private var userHp : TextField;
		
		public function UserControlledObject() 
		{
			userHp = TRegistry.instance.getValue("userHp");
			this.updateUi();
			
			Debug.assert( TRegistry.instance.getValue("stage") != null, "В реестре TRegistry не установлено значение объекта сцены stage" );
			this.stageRef = TRegistry.instance.getValue("stage");
							
			key = new KeyObject(stageRef);
			
			addToGlobalEnterFrame(keyHandler);
		}
		
		protected function keyHandler() : void
		{
			//@EMPTY: переопределяется в наследниках
		}
		
		public override function destroy() : void
		{
			//Отвязываем все события
			removeFromGlobalEnterFrame(keyHandler);
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
		}
		
		private function updateUi() : void
		{
			// Выводим на экран хп юзера
			this.userHp.text = hitPoints.toString();
		}
		
		public override function hit(hits : int) : void
		{
			super.hit(hits);
			updateUi();
		}
	}
}