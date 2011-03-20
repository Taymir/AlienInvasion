package Protections 
{
	import common.TRegistry;
	import common.TTimerEvent;
	import GameObjects.ControllableObject;
	import TmpEffects.TemporaryEffect;
	import UI.UserInterfaceManager;
	/**
	 * ...
	 * @author Taymir
	 */
	public class CommonProtection 
	{
		protected var UIIconName: String;
		
		private var effect: TemporaryEffect;
		private var protection_active: Boolean;
		
		public function CommonProtection(UIIconName: String, effect: TemporaryEffect) 
		{
			this.UIIconName = UIIconName;
			
			this.effect = effect;
			this.effect.progressAction = onProgress;
			this.effect.completeAction = onComplete;
			this.effect.progressRestoreAction = onProgressRestore;
			this.effect.restoreCompleteAction = onRestored;
			
			this.protection_active = false;
		}
		
		private function onProgress(e: TTimerEvent) : void
		{
			// Inform UIManager about delay progress
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, 1.0 - e.progress);
		}
		
		private function onProgressRestore(e: TTimerEvent) : void
		{
			// Inform UIManager about delay progress
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, e.progress);
		}
		
		private function onComplete(e: TTimerEvent)
		{
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, 1.0 - e.progress);
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).deactivateIcon(this.UIIconName);
		}
		
		private function onRestored(e: TTimerEvent)
		{
			(TRegistry.instance.getValue("UI") as UserInterfaceManager).updateProgress(this.UIIconName, e.progress);
			this.protection_active = false;
		}
		
		public function activateProtection(targetObj: ControllableObject)
		{
			if (!protection_active)
			{
				targetObj.applyEffect(this.effect);
				(TRegistry.instance.getValue("UI") as UserInterfaceManager).activateIcon(this.UIIconName);
				protection_active = true;
			}
		}
		
	}

}