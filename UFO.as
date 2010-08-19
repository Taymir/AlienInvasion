package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import com.senocular.utils.KeyObject;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import common.TRegistry;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class UFO extends MovieClip
	{
		private var stageRef:Stage;
		private var key:KeyObject;
		private var speed:Number = 1.5;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.93;
		private var maxspeed:Number = 15;
		
		private var current_sheep:Sheep = null;
		
			
		public function UFO() 
		{
			this.stageRef = TRegistry.instance.getValue("stage");
			key = new KeyObject(stageRef);
			
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function loop(e:Event) : void
		{
			// Обработка нажатий
			if (key.isDown(Keyboard.LEFT))
				vx -= speed;
			else if (key.isDown(Keyboard.RIGHT))
				vx += speed;
			else
				vx *= friction;
				
			if (key.isDown(Keyboard.UP))
				vy -= speed;
			else if (key.isDown(Keyboard.DOWN))
				vy += speed;
			else
				vy *= friction;
				
			// Корректировка малых значений vx и vy
			if (vx < .5 && vx > -.5)
				vx = 0;
			if (vy < .5 && vy > -.5)
				vy = 0;
				
			if (vx == 0 && vy == 0 && key.isDown(Keyboard.SPACE))
				fire();
			else 
				stopFire();
				
			// Обновление положения
			x += vx;
			y += vy;
			
			// Ограничение скорости
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx < -maxspeed)
				vx = -maxspeed;
			
			if (vy > maxspeed)
				vy = maxspeed;
			else if (vy < -maxspeed)
				vy = -maxspeed;
				
			rotation = vx;
			
			// Проверка на нахождение в пределах игрового экрана
			if (x > stageRef.stageWidth)
			{
				x = stageRef.stageWidth;
				vx = -vx;
			}
			else if (x < 0)
			{
				x = 0;
				vx = -vx;
			}
 
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y < 0)
			{
				y = 0;
				vy = -vy;
			}
		}
		
		public function fire () : void
		{
			if(currentFrameLabel == "idle")
				gotoAndPlay("abduction");
				
			// Если в области луча есть овца, начать поднимать её
			var sheep:Sheep = findSheepInFOV();
			if (sheep != null)
			{
				// начинаем поднимать овцу в корабль
				current_sheep = sheep;
				sheep.start_abduction(this);
			}
		}
		
		
		
		// Найти овцу в поле видимости
		private function findSheepInFOV() : Sheep
		{
			for (var i:int; i < TRegistry.instance.getValue("sheeps").length; i++)
			{
				var sheep:Sheep = TRegistry.instance.getValue("sheeps")[i];
				
				// Проверка попадания в область видимости
				var angle:Number = getAngleBetweenObjs(this, sheep);
				var distance:Number = getDistanceBetweenObjs(this, sheep);
				
				if (angle > -deg2rad(20) && angle < deg2rad(20) && distance <= 100)
				{
					return sheep;
				}
			}
			return null;
		}
		
		// Возвращает угол между граф. объектами
		private function getAngleBetweenObjs(obj1:DisplayObject, obj2:DisplayObject) : Number
		{
			return Math.atan2(obj2.x - obj1.x, obj2.y - obj1.y);
		}
		
		// Возвращает расстояние между граф. объектами
		private function getDistanceBetweenObjs(obj1:DisplayObject, obj2:DisplayObject) : Number
		{
			return Math.sqrt(Math.pow(obj2.x - obj1.x, 2) + Math.pow(obj2.y - obj1.y, 2));
		}
		
		//@DEBUG
		private function rad2deg(rad:Number) : Number
		{
			return rad * 180 / Math.PI;
		}
		
		private function deg2rad(deg:Number) : Number
		{
			return deg * Math.PI / 180;
		}
		
		public function stopFire() : void 
		{
			gotoAndStop("idle");
			if(current_sheep != null)
				current_sheep.abort_abduction();
		}
		
	}

}