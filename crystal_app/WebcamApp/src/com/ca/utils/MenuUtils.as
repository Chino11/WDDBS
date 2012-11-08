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
			
			var resolutionMenu:NativeMenuItem = new NativeMenuItem("Resolution");
			menu.addItem(resolutionMenu);
			
			positionMenu.submenu = new NativeMenu();
			resolutionMenu.submenu = new NativeMenu();
			
			var LeftSubItem:NativeMenuItem = new NativeMenuItem("Top Left");
			LeftSubItem.keyEquivalent = "l";
			LeftSubItem.data = TOP_LEFT;
			LeftSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_TOP_LEFT));});
			positionMenu.submenu.addItem(LeftSubItem);
			
			var RightSubItem:NativeMenuItem = new NativeMenuItem("Top Right");
			RightSubItem.keyEquivalent = "r";
			RightSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				menu.dispatchEvent(new MenuEvents(MenuEvents.REQUEST_TOP_RIGHT));});
			positionMenu.submenu.addItem(RightSubItem);
			
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
			
			return menu;
		}
	}
}