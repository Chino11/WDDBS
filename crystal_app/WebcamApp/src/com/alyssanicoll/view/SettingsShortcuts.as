package com.alyssanicoll.view
{
	import fl.controls.ListItem;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class SettingsShortcuts extends SettingsShortcutsBase
	{
		public function SettingsShortcuts(){
			super();
			stopFrame();
			
			tabTopLeft.buttonMode = true;
			tabTopRight.buttonMode = true;
			tabMiddle.buttonMode = true;
			tabBottomLeft.buttonMode = true;
			tabBottomRight.buttonMode = true;
			tabFullscreen.buttonMode = true;
			
			tabTopLeft.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabTopRight.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabMiddle.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabBottomLeft.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabBottomRight.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabFullscreen.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			
			tabTopLeft.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabTopRight.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabMiddle.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabBottomLeft.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabBottomRight.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabFullscreen.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			tabTopLeft.addEventListener(MouseEvent.CLICK, onClick);
			tabTopRight.addEventListener(MouseEvent.CLICK, onClick);
			tabMiddle.addEventListener(MouseEvent.CLICK, onClick);
			tabBottomLeft.addEventListener(MouseEvent.CLICK, onClick);
			tabBottomRight.addEventListener(MouseEvent.CLICK, onClick);
			tabFullscreen.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void{
			if(event.currentTarget == tabTopLeft){
				var	eventTopLeft:MouseEvent = new MouseEvent('topLeft');
				dispatchEvent(eventTopLeft);
			}else if(event.currentTarget == tabTopRight){
				var	eventTopRight:MouseEvent = new MouseEvent('topRight');
				dispatchEvent(eventTopRight);
			}else if(event.currentTarget == tabMiddle){
				var	eventMiddle:MouseEvent = new MouseEvent('middle');
				dispatchEvent(eventMiddle);
			}else if(event.currentTarget == tabBottomLeft){
				var	eventBottomLeft:MouseEvent = new MouseEvent('bottomLeft');
				dispatchEvent(eventBottomLeft);
			}else if(event.currentTarget == tabBottomRight){
				var	eventBottomRight:MouseEvent = new MouseEvent('bottomRight');
				dispatchEvent(eventBottomRight);
			}else if(event.currentTarget == tabFullscreen){
				var	eventFullscreen:MouseEvent = new MouseEvent('fullscreen');
				dispatchEvent(eventFullscreen);
			}
		}
		
		private function onMouseOut(event:MouseEvent):void{
			if(event.currentTarget == tabTopLeft){
				tabTopLeft.gotoAndStop(1);
			}else if(event.currentTarget == tabTopRight){
				tabTopRight.gotoAndStop(1);
			}else if(event.currentTarget == tabMiddle){
				tabMiddle.gotoAndStop(1);
			}else if(event.currentTarget == tabBottomLeft){
				tabBottomLeft.gotoAndStop(1);
			}else if(event.currentTarget == tabBottomRight){
				tabBottomRight.gotoAndStop(1);
			}else if(event.currentTarget == tabFullscreen){
				tabFullscreen.gotoAndStop(1);
			}
		}
		
		private function onMouseOver(event:MouseEvent):void{
			if(event.currentTarget == tabTopLeft){
				tabTopLeft.gotoAndStop(2);
			}else if(event.currentTarget == tabTopRight){
				tabTopRight.gotoAndStop(2);
			}else if(event.currentTarget == tabMiddle){
				tabMiddle.gotoAndStop(2);
			}else if(event.currentTarget == tabBottomLeft){
				tabBottomLeft.gotoAndStop(2);
			}else if(event.currentTarget == tabBottomRight){
				tabBottomRight.gotoAndStop(2);
			}else if(event.currentTarget == tabFullscreen){
				tabFullscreen.gotoAndStop(2);
			}
		}
		
		private function stopFrame():void{
			tabTopLeft.gotoAndStop(1);
			tabTopRight.gotoAndStop(1);
			tabMiddle.gotoAndStop(1);
			tabBottomLeft.gotoAndStop(1);
			tabBottomRight.gotoAndStop(1);
			tabFullscreen.gotoAndStop(1);
		}
	}
}