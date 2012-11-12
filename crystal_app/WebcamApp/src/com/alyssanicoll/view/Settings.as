package com.alyssanicoll.view
{
	import com.alyssanicoll.events.SettingsEvent;
	import com.alyssanicoll.vo.SettingsVO;
	
	import fl.controls.ComboBox;
	import fl.events.ComponentEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Settings extends SettingsBase
	{
		private var _inFront:Boolean = true;
		
		private var _settingsVO:SettingsVO = new SettingsVO();
		
		public function Settings(){
			super();
			
			//this.frontCheckBox.selected = true;
			this.frontCheckBox.addEventListener(Event.CHANGE,onUpFrontCheckBoxChange);
			this.resolutionDropDown.addEventListener(Event.CHANGE,onResChange);
		}
		
		private function onResChange(event:Event):void
		{
			_settingsVO.resolution = ComboBox(event.currentTarget).selectedItem.label;
			
			dispatchEvent(new SettingsEvent(SettingsEvent.SETTINGS_CHANGE));
		}
		
		private function onUpFrontCheckBoxChange(event:Event):void
		{
			trace("Checkbox Selection:",frontCheckBox.selected);
			_settingsVO.inFront = frontCheckBox.selected;
			
			dispatchEvent(new SettingsEvent(SettingsEvent.SETTINGS_CHANGE));
		}		
			
		
//			this.resolutionDropDown.addEventListener(Event.CHANGE, onResolutionChange);
		
//		private function onResolutionChange(event:Event):void{
//			if(ComboBox(event.target).selectedItem.label == "320 X 240"){
//				trace("this is the small resolution");
//				var	eventSmall:MouseEvent = new MouseEvent('smallDisplay');
//				dispatchEvent(eventSmall);
//			}else if(ComboBox(event.target).selectedItem.label == "360 X 240"){
//				trace("this is the wide resolution");
//				var	eventWide:MouseEvent = new MouseEvent('wideDisplay');
//				dispatchEvent(eventWide);
//			}else if(ComboBox(event.target).selectedItem.label == "720 X 480"){
//				trace("this is the fullscreen resolution");
//				var	eventFullscreen:MouseEvent = new MouseEvent('fullscreenDisplay');
//				dispatchEvent(eventFullscreen);
//			}
//		}
		
	/*	public function get inFront():Boolean{
			return _inFront;
		}*/
		
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