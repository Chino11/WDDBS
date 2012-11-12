package com.ca.view
{
	import fl.controls.ComboBox;
	import fl.events.ComponentEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Settings extends SettingsBase
	{
		private var _inFront:Boolean = true;
		public function Settings(){
			super();
						
			this.frontCheckBox.selected = true;
			this.frontCheckBox.addEventListener(ComponentEvent.BUTTON_DOWN, onUpFrontCheckBox);
			
//			this.resolutionDropDown.addEventListener(Event.CHANGE, onResolutionChange);
		}
		
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
		
		public function get inFront():Boolean{
			return _inFront;
		}
		
		public function set inFront(value:Boolean):void{
			_inFront = value;
		}
		
		private function onUpFrontCheckBox(Event:ComponentEvent):void{
			
			trace('this.frontCheckBox.selected',this.frontCheckBox.selected)
			_inFront = false;
			if(!this.frontCheckBox.selected){
				_inFront = true;
			}
			var	event:MouseEvent = new MouseEvent('checkBox');
			dispatchEvent(event);
		}
	}
}