package com.alyssanicoll.view
{
	import com.alyssanicoll.events.MenuEvents;
	
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
			tabCenter.buttonMode = true;
			tabBottomLeft.buttonMode = true;
			tabBottomRight.buttonMode = true;
			tabFullscreen.buttonMode = true;
			
			tabTopLeft.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabTopRight.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabCenter.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabBottomLeft.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabBottomRight.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tabFullscreen.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			
			tabTopLeft.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabTopRight.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabCenter.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabBottomLeft.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabBottomRight.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tabFullscreen.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			tabTopLeft.addEventListener(MouseEvent.CLICK, onClick);
			tabTopRight.addEventListener(MouseEvent.CLICK, onClick);
			tabCenter.addEventListener(MouseEvent.CLICK, onClick);
			tabBottomLeft.addEventListener(MouseEvent.CLICK, onClick);
			tabBottomRight.addEventListener(MouseEvent.CLICK, onClick);
			tabFullscreen.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void{
			var	p:MenuEvents = new MenuEvents(MenuEvents.POSITION_CHANGE);
			p.newPos = MovieClip(event.currentTarget).name.slice(3,MovieClip(event.currentTarget).name.length);
			dispatchEvent(p);
		}
		
		private function onMouseOut(event:MouseEvent):void{
			if(event.currentTarget == tabTopLeft){
				tabTopLeft.gotoAndStop(1);
			}else if(event.currentTarget == tabTopRight){
				tabTopRight.gotoAndStop(1);
			}else if(event.currentTarget == tabCenter){
				tabCenter.gotoAndStop(1);
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
			}else if(event.currentTarget == tabCenter){
				tabCenter.gotoAndStop(2);
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
			tabCenter.gotoAndStop(1);
			tabBottomLeft.gotoAndStop(1);
			tabBottomRight.gotoAndStop(1);
			tabFullscreen.gotoAndStop(1);
		}
	}
}