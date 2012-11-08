package com.ca.view
{
	import flash.events.MouseEvent;

	public class Settings extends SettingsBase
	{
		public function Settings()
		{
			super();
			onUpFrontCheckBox();
		}
		
		private function onUpFrontCheckBox():void
		{
			trace(this.frontCheckBox);
			
		}
	}
}