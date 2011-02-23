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
		
		public function UserControlledObject() 
		{
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
			key.deconstruct();
			
			//Уничтожение продолжается в родительском методе
			super.destroy();
			
			// Обнулям дополнительные переменные
			stageRef = null;
		}
		
		private function updateUi() : void
		{
			// Обновляем информацию о жизни
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).setHitPoints(this.hitPoints);
		}
		
		public override function hit(hits : int) : void
		{
			super.hit(hits);
			updateUi();
		}
	}
}