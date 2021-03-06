package Missles 
{
	import GameObjects.*;
	import common.TList.TList;
	import flash.display.MovieClip;
	import flash.events.Event;
	import common.TRegistry;
	import TmpObstacles.BaseTmpObstacle;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class BaseMissle extends GameObject
	{
		public static const UP:int = +1;
		public static const DOWN:int = -1;
		
		protected var speed:Number = 17;
		public var damage: Number = 10;
		protected var direction:int = 0;
		
		public function BaseMissle(x:Number, y:Number, direction:int) 
		{
			this.x = x;
			this.y = y;
			this.direction = direction;
			
			// Привязываемся к глобальному обновлятору
			TRegistry.instance.getValue("globalEnterFrame").Add(loop);
		}
		
		public function switchDirection() : void
		{
			this.direction *= -1;
		}
		
		protected function loop() : void
		{
			if (direction == DOWN && y < TRegistry.instance.getValue("groundPosition") + this.height / 2)
			{
				y += speed;//@BUGFIX: чтобы ракеты не отображались поверх защитных щитов, сначала изменяем координаты, потом делаем collision detection
				
				if (TRegistry.instance.getValue("tmp_obstacles").Walk(tmp_obstacles_collision_detection_callback) == null)
				TRegistry.instance.getValue("player").Walk(collision_detection_callback);
			} 
			else if (direction == UP && y > -70)
			{
				y -= speed;
				
				if (TRegistry.instance.getValue("tmp_obstacles").Walk(tmp_obstacles_collision_detection_callback) == null)
				TRegistry.instance.getValue("enemies").Walk(collision_detection_callback);
			}
			else 
			{
				this.hitGround();
				this.dispose();
			}
		}
		
		protected function hitGround()
		{
			this.Explode();
		}
		
		protected function hitTarget(targetObj: ControllableObject)
		{
			this.Explode();
			targetObj.hit(damage);
		}
		
		protected function tmp_obstacles_collision_detection_callback(obj: Object) : int
		{
			var targetObj : BaseTmpObstacle = obj as BaseTmpObstacle;
			
			if (this.hitTestObject(targetObj))
			{
				targetObj.handleMissle(this);
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		protected function collision_detection_callback(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			if (this.hitTestObject(targetObj))
			{
				hitTarget(targetObj);
				this.dispose();
				
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
		public override function dispose() : void
		{
			// Завершаем анимацию движения ракеты
			TRegistry.instance.getValue("globalEnterFrame").Remove(loop);
			
			super.dispose();
		}
		
		public function Explode() : void
		{
			new Explosion(x, y);
		}
		
	}

}