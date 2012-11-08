package com.ca.view
{
	import flash.events.MouseEvent;

	public class Settings extends SettingsBase
	{
		public function Settings()
		{
			super();
			closeButton.addEventListener(MouseEvent.CLICK, onSettingsClose);
		}
		
		private function onSettingsClose(event:MouseEvent):void
		{
			removeChild(this);
		}
	}
}