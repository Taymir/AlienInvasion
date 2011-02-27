package Missles 
{
	import common.MathExtra;
	import common.TList.TList;
	import common.TRegistry;
	import common.Vector2D;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class rocket_missle extends BaseMissle 
	{
		private var detection_distance: int = 400;
		private const angular_velocity: Number = 2;
		private const max_rotation: int = 40;
		
		public function rocket_missle(x:Number, y:Number, direction:int) 
		{
			this.speed = 22;
			this.damage = 15;
			
			super(x, y, direction);
		}
		
		protected override function loop() : void
		{
			if (direction == DOWN && y < TRegistry.instance.getValue("groundPosition") + this.height / 2)
			{
				//@EMPTY Пока движение ракеты вниз недопустимо
			}
			else if (direction == UP && y > -70)
			{
				// 1) Изменяем координаты в соответствии с velocity
				// 2) Ищем в окрестностях врагов
				// 3) Если находим, то цель = заданный враг
				TRegistry.instance.getValue("enemies").Walk(enemies_detection_callback);
				
				var fi: Number = MathExtra.deg2rad(this.rotation);
				x += Math.cos(fi) * 1 - Math.sin(fi) * (-speed);
				y += Math.sin(fi) * 1 + Math.cos(fi) * (-speed);
				
				TRegistry.instance.getValue("enemies").Walk(collision_detection_callback);
			}
			else 
			{
				this.dispose();
			}
		}
		
		protected function enemies_detection_callback(obj: Object) : int
		{
			var targetObj: ControllableObject = obj as ControllableObject;
			
			// Если расстояние между ракетой и targetObj меньше заданного, то
			if (MathExtra.isDistanceLessThen(this.x, this.y, targetObj.x, targetObj.y, detection_distance))
			{
				var angle: Number = MathExtra.rad2deg(MathExtra.getAngleBetweenObjs(this, targetObj));
				
				if (rotation > angle && rotation <= max_rotation)
					rotation -= this.angular_velocity;
				else if (rotation < angle && rotation >= -max_rotation)
					rotation += this.angular_velocity;
				
				return TList.STOP_WALKING;
			}
			
			return TList.CONTINUE_WALKING;
		}
		
	}

}