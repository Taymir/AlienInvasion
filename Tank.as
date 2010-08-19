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
	
	public class Tank extends MovieClip
	{
		private var stageRef:Stage;
		private var key:KeyObject;
		private var speed:Number = 1.5;
		private var vx:Number = 0;
		private var friction:Number = 0.93;
		private var maxspeed:Number = 15;
		
		public function Tank(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function loop(e:Event) : void
		{
			// Обработка нажатий
			if (key.isDown(65))
				vx -= speed;
			else if (key.isDown(68))
				vx += speed;
			else
				vx *= friction;
				
			/*if (key.isDown(Keyboard.UP))
				vy -= speed;
			else if (key.isDown(Keyboard.DOWN))
				vy += speed;
			else
				vy *= friction;*/
				
			// Корректировка малых значений vx и vy
			if (vx < .5 && vx > -.5)
				vx = 0;
			//if (vy < .5 && vy > -.5)
			//	vy = 0;
				
			//if (vx == 0 && vy == 0 && key.isDown(Keyboard.SPACE))
			//	fire();
			//else 
			//	stopFire();
				
			// Обновление положения
			x += vx;
			//y += vy;
			
			// Ограничение скорости
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx < -maxspeed)
				vx = -maxspeed;
			
			//if (vy > maxspeed)
			//	vy = maxspeed;
			//else if (vy < -maxspeed)
			//	vy = -maxspeed;
				
			//rotation = vx;
			trace(rotation);
			
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
 
			/*if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y < 0)
			{
				y = 0;
				vy = -vy;
			}*/
		}
	}
}