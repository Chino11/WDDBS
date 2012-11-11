package com.ca.view
{
	import fl.controls.ListItem;
	
	import flash.events.MouseEvent;

	public class SettingsShortcuts extends SettingsShortcutsBase
	{
		public function SettingsShortcuts()
		{
			super();
			stopFrame();
		}
		
		private function stopFrame():void
		{
			tabTopLeft.gotoAndStop(1);
			tabTopRight.gotoAndStop(1);
			tabMiddle.gotoAndStop(1);
			tabBottomLeft.gotoAndStop(1);
			tabBottomRight.gotoAndStop(1);
			tabFullscreen.gotoAndStop(1);
		}
	}
}