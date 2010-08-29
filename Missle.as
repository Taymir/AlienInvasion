package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class Missle extends GameObject
	{
		private var speed:Number = 7.5;
		private var direction:int = 0;
		public static const UP:int = 0;
		public static const DOWN:int = 1;
		
		public function Missle(x:Number, y:Number, direction:int) 
		{
			this.x = x;
			this.y = y;
			this.direction = direction;
			
			addEventListener(Event.ENTER_FRAME, keyHandler, false, 0, true);
			
			stageRef.addChild(this);
		}
		
		protected function keyHandler(e: Event) : void
		{
			if (direction == DOWN && y < stageRef.stageHeight)
			{
				y += speed;
			} 
			else if (direction == UP && y > 0)
			{
				y -= speed;
			}
			else 
			{
				removeEventListener(Event.ENTER_FRAME, keyHandler, false);
				stageRef.removeChild(this);
			}
		}
		
	}

}