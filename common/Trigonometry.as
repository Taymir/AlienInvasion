package common 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public final class Trigonometry
	{
		public function rad2deg(rad:Number) : Number
		{
			return rad * 180 / Math.PI;
		}
		
		public function deg2rad(deg:Number) : Number
		{
			return deg * Math.PI / 180;
		}
		
	}

}