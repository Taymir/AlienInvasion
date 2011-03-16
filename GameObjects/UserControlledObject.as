package  GameObjects
{
	import com.senocular.utils.KeyObject;
	import flash.display.Stage;
	import flash.events.Event;
	import common.TRegistry;
	import common.Debug;
	import flash.text.TextField;
	import UI.UserInterfaceManager;
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
			// Добавляемся в список
			this.addToList("player");
			
			// Обновим UI
			this.updateUi();
			
			Debug.assert( TRegistry.instance.getValue("stage") != null, "В реестре TRegistry не установлено значение объекта сцены stage" );
			this.stageRef = TRegistry.instance.getValue("stage");
			key = new KeyObject(stageRef);
			
			// Привязываемся в глобальному обновлятору
			addToGlobalEnterFrame(keyHandler);
		}
		
		protected function keyHandler() : void
		{
			//@EMPTY: переопределяется в наследниках
		}
		
		public override function dispose() : void
		{
			//Удаляем ссылку на игрока
			this.removeFromList("player");
			
			//Отвязываем все события
			removeFromGlobalEnterFrame(keyHandler);
			key.deconstruct();
			
			//Уничтожение продолжается в родительском методе
			super.dispose();
			
			// Обнулям дополнительные переменные
			stageRef = null;
		}
		
		
		public override function kill() : void
		{
			//@TODO анимация смерти
			
			super.kill();
			
			// Проверка конца игры
			TRegistry.instance.getValue("gameStateManager").checkEndGame();
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