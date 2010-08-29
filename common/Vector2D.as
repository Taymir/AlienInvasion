package common 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public class Vector2D
	{
		private var vx: Number;
		private var vy: Number;
		
		public function Vector2D()
		{
			vx = 0;
			vy = 0;
		}
		
		public function get x() : Number
		{
			return vx;
		}
		
		public function get y() : Number
		{
			return vy;
		}
		
		public function set x(value: Number) : void
		{
			vx = value;
		}
		
		public function set y(value: Number) : void
		{
			vy = value;
		}
	}

}