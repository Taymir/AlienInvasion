package UI 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Taymir
	 */
	public class ProtectionIcon extends UIIcon 
	{
		private const protection_offset: int = 360;
		
		public function ProtectionIcon(name:String, position:int, action: Function)
		{
			this._x_offset = protection_offset;
			super(name, position, action);
		}
		
	}

}