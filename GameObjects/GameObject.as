package  GameObjects
{
	import common.TList.TList;
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
			Debug.assert(scene.contains(this), "Попытка повторного удаление объекта со сцены");
			
			if (scene.contains(this))
				scene.removeChild(this);
		}
		
		public function dispose() : void
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
		
		protected function addToList(listname: String)
		{
			var list: TList = TRegistry.instance.getValue(listname);
			list.Add(this);
		}
		
		protected function removeFromList(listname: String)
		{
			TRegistry.instance.getValue(listname).Remove(this);
		}
	}

}