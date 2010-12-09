package common 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Taymir
	 */
	public final class MathExtra
	{
		public static function rad2deg(rad:Number) : Number
		{
			return rad * 180 / Math.PI;
		}
		
		public static function deg2rad(deg:Number) : Number
		{
			return deg * Math.PI / 180;
		}
		
		public static function RandomInt(min: int, max: int): int
		{
			return Math.floor( (max - min) * Math.random() + min);
		}
		
		
		// Возвращает угол между граф. объектами
		public static function getAngleBetweenObjs(obj1:DisplayObject, obj2:DisplayObject) : Number
		{
			return Math.atan2(obj2.x - obj1.x, obj2.y - obj1.y);
		}
		
		// Возвращает расстояние между граф. объектами
		public static function getDistanceBetweenObjs(obj1:DisplayObject, obj2:DisplayObject) : Number
		{
			return Math.sqrt(Math.pow(obj2.x - obj1.x, 2) + Math.pow(obj2.y - obj1.y, 2));
		}
		
		public static function isDistanceMoreThen(x1: Number, y1: Number, x2: Number, y2: Number, distanceComparator: Number) : Boolean
		{
			// Чуть быстрее чем getDistanceBerweenObjs из-за того что не берем квадратный корень
			return (Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2)) > distanceComparator * distanceComparator;
		}
		
		public static function isDistanceLessThen(x1: Number, y1: Number, x2: Number, y2: Number, distanceComparator: Number) : Boolean
		{
			return !isDistanceMoreThen(x1, y1, x2, y2, distanceComparator);
		}
	}

}