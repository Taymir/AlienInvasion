package common 
{
	/**
	 * ...
	 * @author Taymir
	 */
	public final class Trigonometry
	{
		public static function rad2deg(rad:Number) : Number
		{
			return rad * 180 / Math.PI;
		}
		
		public static function deg2rad(deg:Number) : Number
		{
			return deg * Math.PI / 180;
		}
		
	}

}