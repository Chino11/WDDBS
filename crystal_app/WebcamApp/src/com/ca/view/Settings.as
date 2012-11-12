package com.ca.view
{
	import com.ca.vo.SettingsVO;
	
	import fl.events.ComponentEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Settings extends SettingsBase
	{
		private var _inFront:Boolean = true;
		
		private var _settingsVO:SettingsVO;
		public function Settings(){
			super();
			this.frontCheckBox.selected = true;
		//	this.frontCheckBox.addEventListener(ComponentEvent.BUTTON_DOWN, onUpFrontCheckBox);
			this.frontCheckBox.addEventListener(Event.CHANGE,proveAlyssaWrong);
		}
		
		private function proveAlyssaWrong(event:Event):void
		{
			trace("Checkbox Selection:",frontCheckBox.selected);
		}		
		
		// create a public getter/setter for settingsVO.  
		// this page will populate itself based on the set, and
		// query currently displayed values upon getting.
		
		public function get settingsVO():SettingsVO
		{
			return _settingsVO;
		}

		public function set settingsVO(value:SettingsVO):void
		{
			_settingsVO = value;
			frontCheckBox.selected = _settingsVO.inFront;
		}

		
		/*private function onUpFrontCheckBox(Event:ComponentEvent):void{
			
			trace('this.frontCheckBox.selected',this.frontCheckBox.selected)
			_inFront = false;
			if(!this.frontCheckBox.selected){
				_inFront = true;
			}
		}*/
	}
}