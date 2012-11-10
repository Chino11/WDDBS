package com.ca.view
{
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
		}
		
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