package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import common.TRegistry;
	import common.Debug;
	
	/**
	 * ...
	 * @author Taymir
	 */
	public class GameObject extends MovieClip
	{
		protected const autoShow : Boolean = true;
		protected var scene : MovieClip;
		
		public function GameObject() 
		{
			Debug.assert( TRegistry.instance.getValue("scene") != null, "В реестре TRegistry не установлено значение объекта сцены scene" );
			
			this.scene = TRegistry.instance.getValue("scene");
			
			if (autoShow)
				show();
		}
		
		protected function show() : void
		{
			scene.addChild(this);
		}
		
		protected function hide() : void
		{
			scene.removeChild(this);
		}
	}

}