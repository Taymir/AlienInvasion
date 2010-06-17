package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Sheep extends MovieClip
	{
		private var original_y:int;
		private var aim_x:int;
		private var aim_y:int;

		private var is_abducting = false;
		
		public function Sheep() 
		{
			
		}
		
		public function start_abduction(obj:DisplayObject) : void
		{
			if (!is_abducting)
			{
				this.aim_x = obj.x;
				this.aim_y = obj.y;
				
				this.original_y = this.y;
				
				addEventListener(Event.ENTER_FRAME, process_abduction);
			}
			is_abducting = true;
		}
		
		private function process_abduction(e:Event) : void
		{
			if (this.x > this.aim_x)
				this.x--;
			else if (this.x < this.aim_x)
				this.x++;
				
			this.y--;
			
			this.scaleX -= .01;
			this.scaleY -= .01;
			
			if (this.y < this.aim_y || this.scaleX < 0.01)
			{
				stage.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, process_abduction);
				is_abducting = false;
			}
		}
		
		public function abort_abduction() : void
		{
			if (is_abducting)
			{
				//trace("tick");
				is_abducting = false;
				removeEventListener(Event.ENTER_FRAME, process_abduction);
				addEventListener(Event.ENTER_FRAME, process_falling);
			}
		}
		
		private function process_falling(e:Event) : void
		{
			if (this.y < original_y && this.scaleX < 1.0) {
				this.y+=4;
				this.scaleX += .04;
				this.scaleY += .04;
			} else {
				removeEventListener(Event.ENTER_FRAME, process_falling);
			}
		}
		
	}

}