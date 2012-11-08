package com.ca.view
{
	import flash.events.MouseEvent;

	public class Settings extends SettingsBase
	{
		private var frontCheckBoxChecked:Boolean;
		public function Settings()
		{
			super();
			onUpFrontCheckBox();
		}
		
		private function onUpFrontCheckBox():void
		{
			if(this.frontCheckBox.selected){
				frontCheckBoxChecked = true;
			}
			
		}
	}
}