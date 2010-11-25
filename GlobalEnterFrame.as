package  
{
	import common.TList.TList;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akkarin
	 */
	public class GlobalEnterFrame
	{
		private var updateMethods:TList;
		
		public function GlobalEnterFrame() 
		{
			this.updateMethods = new TList();
		}
		
		public function Add(func:Function) 
		{			
			this.updateMethods.Add(func);
		}
		
		public function Update(e:Event)
		{
			this.updateMethods.Walk(UpdateIteration);
		}
		
		private function UpdateIteration(obj:Object)
		{
			var func:Function = obj as Function;
			func.call();
		}
		
		public function Remove(func:Function)
		{
			updateMethods.Remove(func);
		}
		
	}

}