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
		
		public function destroy() : void
		{
			// Прячем со сцены
			hide();
		}
		
		protected function addToGlobalEnterFrame(f: Function)
		{
			Debug.assert( TRegistry.instance.getValue("globalEnterFrame") != null, "В реестре TRegistry не установлена ссылка на глобальный обновлятор" );
			
			(TRegistry.instance.getValue("globalEnterFrame") as GlobalEnterFrame).Add(f);
		}
		
		protected function removeFromGlobalEnterFrame(f: Function)
		{
			Debug.assert( TRegistry.instance.getValue("globalEnterFrame") != null, "В реестре TRegistry не установлена ссылка на глобальный обновлятор" );
			
			(TRegistry.instance.getValue("globalEnterFrame") as GlobalEnterFrame).Remove(f);
		}
	}

}