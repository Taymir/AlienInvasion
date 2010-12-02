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
		
		private var speed:Number = 17;
		private var direction:int = 0;
		
		private var explosion:Explosion;
		
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
				if (TRegistry.instance.getValue("debug_cannon_test"))
					TRegistry.instance.getValue("player").Walk(tank_cannon_collision_detection);
				else
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
				this.Explode();
			}
		}
		
		// Test method for Innet
		private function tank_cannon_collision_detection(obj: Object) : int
		{
			var targetObj: Tank = obj as Tank;
			
			if (this.hitTestObject(targetObj.cannon))
			{
				this.Explode();
				targetObj.hit(1);
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		private function collision_detection_callback(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			if (this.hitTestObject(targetObj))
			{
				this.Explode();
				targetObj.hit(1);
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		private function Explode() : void
		{
			// Завершаем анимацию движения ракеты
			//removeEventListener(TRegistry.instance.getValue("globalEnterFrame").Add, loop, false);
			TRegistry.instance.getValue("globalEnterFrame").Remove(loop);
			
			// Отображаем анимацию взрыва по координатам ракеты
			this.explosion = new Explosion();
			explosion.x = x;
			explosion.y = y;
			
			// Проигрываем анимацию взрыва
			explosion.addFrameScript(explosion.totalFrames - 1, stopExplosion);
			scene.addChild(explosion);
			
			// Прячем саму ракету
			this.hide();
		}
		
		private function stopExplosion() : void
		{
			explosion.stop();
			
			scene.removeChild(explosion);
		}
		
	}

}