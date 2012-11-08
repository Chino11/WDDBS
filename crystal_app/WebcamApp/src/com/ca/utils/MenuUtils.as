package com.ca.utils
{
	import com.ca.events.MenuEvents;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;

	public class MenuUtils
	{
		public static const TOP_LEFT:String = "screenTopLeft"
		public static const TOP_RIGHT:String = "screenTopRight";
		
		public function MenuUtils()
		{
		}
		public static function makeAppMenu(menu:NativeMenu):NativeMenu{
	
			for each(var mi:NativeMenuItem in menu.items){
				if(mi.label == "Edit"){
					menu.removeItem(mi);
				}
			}
			var positionMenu:NativeMenuItem = new NativeMenuItem("Position");
			menu.addItem(positionMenu);
			
			positionMenu.submenu = new NativeMenu();
			
			var leftSubItem:NativeMenuItem = new NativeMenuItem("Top Left");
			leftSubItem.keyEquivalent = "l";
			leftSubItem.data = TOP_LEFT;
			leftSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_TOP_LEFT));});
			positionMenu.submenu.addItem(leftSubItem);
			
			var rightSubItem:NativeMenuItem = new NativeMenuItem("Top Right");
			rightSubItem.keyEquivalent = "r";
			rightSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_TOP_RIGHT));});
			positionMenu.submenu.addItem(rightSubItem);
			
			var bLeftSubItem:NativeMenuItem = new NativeMenuItem("Bottom Left");
			bLeftSubItem.keyEquivalentModifiers = [];
			bLeftSubItem.keyEquivalent = "L";
			bLeftSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_BOTTOM_LEFT));});
			positionMenu.submenu.addItem(bLeftSubItem);
			
			var bRightSubItem:NativeMenuItem = new NativeMenuItem("Bottom Right");
			bRightSubItem.keyEquivalentModifiers = [];
			bRightSubItem.keyEquivalent = "R";
			bRightSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_BOTTOM_RIGHT));});
			positionMenu.submenu.addItem(bRightSubItem);
			
			var middleSubItem:NativeMenuItem = new NativeMenuItem("Center");
			middleSubItem.keyEquivalent = "c";
			middleSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_CENTER));});
			positionMenu.submenu.addItem(middleSubItem);
			
			var fullscreenSubItem:NativeMenuItem = new NativeMenuItem("FullScreen");
			fullscreenSubItem.keyEquivalent = "f";
			fullscreenSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_FULL_SCREEN));});
			positionMenu.submenu.addItem(fullscreenSubItem);
			
			
			var resolutionMenu:NativeMenuItem = new NativeMenuItem("Resolution");
			menu.addItem(resolutionMenu);
			
			resolutionMenu.submenu = new NativeMenu();
			
			var smallSubItem:NativeMenuItem = new NativeMenuItem("320x240");
			smallSubItem.keyEquivalent = "1";
			//smallSubItem.data = SMALL;
			smallSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_SMALL));});
			resolutionMenu.submenu.addItem(smallSubItem);
			
			var wideSubItem:NativeMenuItem = new NativeMenuItem("360x240");
			wideSubItem.keyEquivalent = "2";
			//wideSubItem.data = SMALL;
			wideSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_WIDE));});
			resolutionMenu.submenu.addItem(wideSubItem);
			
			var fullSubItem:NativeMenuItem = new NativeMenuItem("720x480");
			fullSubItem.keyEquivalent = "3";
			//fullSubItem.data = SMALL;
			fullSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_FULLSCREEN));});
			resolutionMenu.submenu.addItem(fullSubItem);

			
			return menu;
		}
	}
}