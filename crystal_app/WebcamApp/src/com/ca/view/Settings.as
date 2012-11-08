package com.ca.view
{
	import flash.events.MouseEvent;

	public class Settings extends SettingsBase
	{
		private var _inFront:Boolean;
		public function Settings()
		{
			super();
			onUpFrontCheckBox();
		}
		
		public function get inFront():Boolean
		{
			return _inFront;
		}

		public function set inFront(value:Boolean):void
		{
			_inFront = value;
		}

		private function onUpFrontCheckBox():void
		{
			if(this.frontCheckBox.selected){
				inFront = true;
			}
			
		}
	}
}