package  GameObjects
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Taymir
	 */
	public class CommonGameObject extends GameObject 
	{
		private var listname:String = null;
		
		public function CommonGameObject(graphics: DisplayObject, listname: String = null) 
		{
			this.listname = listname;
			this.addChild(graphics);
			super();
			if (listname != null)
				this.addToList(listname);
		}
		
		override public function dispose():void 
		{
			super.dispose();
			if (listname != null)
				this.removeFromList(listname);
		}
		
	}

}