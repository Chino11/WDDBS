package com.alyssanicoll.utils
{
	import com.alyssanicoll.events.MenuEvents;
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
		public static function makeAppMenu(p:NativeMenu):NativeMenu{
	
			for each(var mi:NativeMenuItem in p.items){
				if(mi.label == "Edit"){
					p.removeItem(mi);
				}
			}
			var positionMenu:NativeMenuItem = new NativeMenuItem("Position");
			p.addItem(positionMenu);
			
			positionMenu.submenu = new NativeMenu();
			
			var leftSubItem:NativeMenuItem = new NativeMenuItem("Top Left");
			leftSubItem.keyEquivalent = "l";
			leftSubItem.data = TOP_LEFT;
			leftSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				p.dispatchEvent(new MenuEvents(MenuEvents.POSITION_CHANGE));});
			positionMenu.submenu.addItem(leftSubItem);
			
			var rightSubItem:NativeMenuItem = new NativeMenuItem("Top Right");
			rightSubItem.keyEquivalent = "r";
			rightSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				p.dispatchEvent(new MenuEvents(MenuEvents.POSITION_CHANGE));});
			positionMenu.submenu.addItem(rightSubItem);
			
			var bLeftSubItem:NativeMenuItem = new NativeMenuItem("Bottom Left");
			bLeftSubItem.keyEquivalentModifiers = [];
			bLeftSubItem.keyEquivalent = "L";
			bLeftSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				p.dispatchEvent(new MenuEvents(MenuEvents.POSITION_CHANGE));});
			positionMenu.submenu.addItem(bLeftSubItem);
			
			var bRightSubItem:NativeMenuItem = new NativeMenuItem("Bottom Right");
			bRightSubItem.keyEquivalentModifiers = [];
			bRightSubItem.keyEquivalent = "R";
			bRightSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				p.dispatchEvent(new MenuEvents(MenuEvents.POSITION_CHANGE));});
			positionMenu.submenu.addItem(bRightSubItem);
			
			var middleSubItem:NativeMenuItem = new NativeMenuItem("Center");
			middleSubItem.keyEquivalent = "c";
			middleSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				p.dispatchEvent(new MenuEvents(MenuEvents.POSITION_CHANGE));});
			positionMenu.submenu.addItem(middleSubItem);
			
			var fullscreenSubItem:NativeMenuItem = new NativeMenuItem("FullScreen");
			fullscreenSubItem.keyEquivalent = "f";
			fullscreenSubItem.addEventListener(Event.SELECT, function(event:Event):void{ 
				p.dispatchEvent(new MenuEvents(MenuEvents.POSITION_CHANGE));});
			positionMenu.submenu.addItem(fullscreenSubItem);
			
			
			var resolutionMenu:NativeMenuItem = new NativeMenuItem("Resolution");
			p.addItem(resolutionMenu);
			
			resolutionMenu.submenu = new NativeMenu();
			
			var smallSubItem:NativeMenuItem = new NativeMenuItem("320x240");
			smallSubItem.keyEquivalent = "1";
			smallSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				var e:MenuEvents = new MenuEvents(MenuEvents.REQUEST_RESOLUTION_CHANGE);
				e.width = 320;
				e.height = 240;
				e.index = 0;
				p.dispatchEvent(e);});
			resolutionMenu.submenu.addItem(smallSubItem);
			
			var wideSubItem:NativeMenuItem = new NativeMenuItem("640x480");
			wideSubItem.keyEquivalent = "2";
			wideSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				var e:MenuEvents = new MenuEvents(MenuEvents.REQUEST_RESOLUTION_CHANGE);
				e.width = 640;
				e.height = 480;
				e.index = 1;
				p.dispatchEvent(e);});
			resolutionMenu.submenu.addItem(wideSubItem);
			
			var bigSubItem:NativeMenuItem = new NativeMenuItem("800x600");
			bigSubItem.keyEquivalent = "3";
			bigSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				var e:MenuEvents = new MenuEvents(MenuEvents.REQUEST_RESOLUTION_CHANGE);
				e.width = 800;
				e.height = 600;
				e.index = 2;
				p.dispatchEvent(e);});
			resolutionMenu.submenu.addItem(bigSubItem);
			
			var fullSubItem:NativeMenuItem = new NativeMenuItem("1024x768");
			fullSubItem.keyEquivalent = "4";
			fullSubItem.addEventListener(Event.SELECT, function(event:Event):void{
				var e:MenuEvents = new MenuEvents(MenuEvents.REQUEST_RESOLUTION_CHANGE);
				e.width = 1024;
				e.height = 768;
				e.index = 3;
				p.dispatchEvent(e);});
			resolutionMenu.submenu.addItem(fullSubItem);

			
			return p;
		}
	}
}