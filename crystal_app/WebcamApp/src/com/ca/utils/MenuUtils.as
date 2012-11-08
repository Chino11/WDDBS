package com.ca.utils
{
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
	
			
			var positionMenu:NativeMenuItem = new NativeMenuItem("Position");
			menu.addItem(positionMenu);
			
			var resolutionMenu:NativeMenuItem = new NativeMenuItem("Resolution");
			menu.addItem(resolutionMenu);
			
			positionMenu.submenu = new NativeMenu();
			resolutionMenu.submenu = new NativeMenu();
			
			var LeftSubItem:NativeMenuItem = new NativeMenuItem("Top-Left");
//			LeftSubItem.keyEquivalentModifiers = [];
			LeftSubItem.keyEquivalent = "l";
			//LeftSubItem.addEventListener(Event.SELECT, onTopLeft);
			positionMenu.submenu.addItem(LeftSubItem);
			
			var RightSubItem:NativeMenuItem = new NativeMenuItem("Top-Right");
//			RightSubItem.keyEquivalentModifiers = [];
			RightSubItem.keyEquivalent = "r";
//			RightSubItem.addEventListener(Event.SELECT, onTopRight);
			positionMenu.submenu.addItem(RightSubItem);
			
			var bLeftSubItem:NativeMenuItem = new NativeMenuItem("Bottom-Left");
			bLeftSubItem.keyEquivalentModifiers = [];
			bLeftSubItem.keyEquivalent = "L";
//			bLeftSubItem.addEventListener(Event.SELECT, onBottomLeft);
			positionMenu.submenu.addItem(bLeftSubItem);
			
			var bRightSubItem:NativeMenuItem = new NativeMenuItem("Bottom-Right");
			bRightSubItem.keyEquivalentModifiers = [];
			bRightSubItem.keyEquivalent = "R";
//			bRightSubItem.addEventListener(Event.SELECT, onBottomRight);
			positionMenu.submenu.addItem(bRightSubItem);
			
			var middleSubItem:NativeMenuItem = new NativeMenuItem("Middle");
//			middleSubItem.keyEquivalentModifiers = [];
			middleSubItem.keyEquivalent = "m";
//			middleSubItem.addEventListener(Event.SELECT, onMiddle);
			positionMenu.submenu.addItem(middleSubItem);
			
			var fullscreenSubItem:NativeMenuItem = new NativeMenuItem("FullScreen");
//			fullscreenSubItem.keyEquivalentModifiers = [];
			fullscreenSubItem.keyEquivalent = "f";
//			fullscreenSubItem.addEventListener(Event.SELECT, onFullscreen);
			positionMenu.submenu.addItem(fullscreenSubItem);
			
			return menu;
		}
	}
}