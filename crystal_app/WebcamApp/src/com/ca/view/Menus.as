package com.ca.view
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	public class Menus extends Sprite
	{
		public function Menus()
		{
			super();
			var menu:NativeMenu = NativeApplication.nativeApplication.menu;
			
			var positionMenu:NativeMenuItem = new NativeMenuItem("Position");
			menu.addItem(positionMenu);
			
			var resolutionMenu:NativeMenuItem = new NativeMenuItem("Resolution");
			menu.addItem(resolutionMenu);
			
			positionMenu.submenu = new NativeMenu();
			resolutionMenu.submenu = new NativeMenu();
			
			var LeftSubItem:NativeMenuItem = new NativeMenuItem("Top-Left");
			LeftSubItem.keyEquivalentModifiers = [];
			LeftSubItem.keyEquivalent = "l";
			LeftSubItem.addEventListener(Event.SELECT, onTopLeft);
			positionMenu.submenu.addItem(LeftSubItem);
			
			var RightSubItem:NativeMenuItem = new NativeMenuItem("Top-Right");
			RightSubItem.keyEquivalentModifiers = [];
			RightSubItem.keyEquivalent = "r";
			RightSubItem.addEventListener(Event.SELECT, onTopRight);
			positionMenu.submenu.addItem(RightSubItem);
			
			var bLeftSubItem:NativeMenuItem = new NativeMenuItem("Bottom-Left");
			bLeftSubItem.keyEquivalentModifiers = [];
			bLeftSubItem.keyEquivalent = "L";
			bLeftSubItem.addEventListener(Event.SELECT, onBottomLeft);
			positionMenu.submenu.addItem(bLeftSubItem);
			
			var bRightSubItem:NativeMenuItem = new NativeMenuItem("Bottom-Right");
			bRightSubItem.keyEquivalentModifiers = [];
			bRightSubItem.keyEquivalent = "R";
			bRightSubItem.addEventListener(Event.SELECT, onBottomRight);
			positionMenu.submenu.addItem(bRightSubItem);
			
			var middleSubItem:NativeMenuItem = new NativeMenuItem("Middle");
			middleSubItem.keyEquivalentModifiers = [];
			middleSubItem.keyEquivalent = "m";
			middleSubItem.addEventListener(Event.SELECT, onMiddle);
			positionMenu.submenu.addItem(middleSubItem);
			
			var fullscreenSubItem:NativeMenuItem = new NativeMenuItem("FullScreen");
			fullscreenSubItem.keyEquivalentModifiers = [];
			fullscreenSubItem.keyEquivalent = "f";
			fullscreenSubItem.addEventListener(Event.SELECT, onFullscreen);
			positionMenu.submenu.addItem(fullscreenSubItem);
			
			NativeApplication.nativeApplication.menu = menu;
		}
		
		private function onFullscreen(event:Event):void{
			stage.nativeWindow.width = Capabilities.screenResolutionX;
			stage.nativeWindow.height = Capabilities.screenResolutionY;
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
		}
		
		private function onMiddle(event:Event):void{
			//			stage.nativeWindow.width = 500;
			//			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width)/2;
			stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.nativeWindow.height)/2;
		}
		
		private function onTopRight(event:Event):void{
			//			stage.nativeWindow.width = 500;
			//			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
			stage.nativeWindow.y = 0;
		}
		
		private function onTopLeft(event:Event):void{
			//			stage.nativeWindow.width = 500;
			//			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
		}
		
		private function onBottomRight(event:Event):void{
			//			stage.nativeWindow.width = 500;
			//			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
			stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
		}
		
		private function onBottomLeft(event:Event):void{
			//			stage.nativeWindow.width = 500;
			//			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
		}
		

	}
}