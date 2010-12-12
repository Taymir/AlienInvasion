package Missles 
{
	import common.TList.TList;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import common.TRegistry;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseMissle extends GameObject
	{
		public static const UP:int = 0;
		public static const DOWN:int = 1;
		
		protected var speed:Number = 17;
		protected var damage: Number = 10;
		protected var direction:int = 0;
		
		public function BaseMissle(x:Number, y:Number, direction:int) 
		{
			this.x = x;
			this.y = y;
			this.direction = direction;
			
			// Привязываемся к глобальному обновлятору
			TRegistry.instance.getValue("globalEnterFrame").Add(loop);
		}
		
		private function loop() : void
		{
			if (direction == DOWN && y < TRegistry.instance.getValue("groundPosition") + this.height / 2)
			{
				TRegistry.instance.getValue("player").Walk(collision_detection_callback);
				
				y += speed;
			} 
			else if (direction == UP && y > -70)
			{
				TRegistry.instance.getValue("enemies").Walk(collision_detection_callback);
				
				y -= speed;
			}
			else 
			{
				this.groundExplosion();
			}
		}
		
		protected function groundExplosion()
		{
			this.Explode();
		}
		
		protected function collision_detection_callback(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			if (this.hitTestObject(targetObj))
			{
				this.Explode();
				targetObj.hit(damage);
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		protected function Explode() : void
		{
			// Завершаем анимацию движения ракеты
			TRegistry.instance.getValue("globalEnterFrame").Remove(loop);
			
			new Explosion(x, y);
			
			// Прячем саму ракету
			this.hide();
		}
		
	}

}