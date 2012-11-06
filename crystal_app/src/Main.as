package
{
	import com.ca.model.AppModel;
	import com.ca.view.Settings;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.media.Camera;
	import flash.media.Video;
	
	public class Main extends Sprite{
		private var _video:Video;
		private var _webcams:Array = Camera.names;
		private var _resolutions:Array = ["128 x 96","176 x 144","352 x 288","704 x 576","1408 x 1152"];
		private var _c:Camera;
		private var _settings:Settings;
		private var _bar:Sprite;
		private var _mainScreen:NativeWindow;
		private var _nw:NativeWindow;
		private var _keys:Array = [];
		private var _combo:Array = [];
		
		public function Main(){
			settingWebcam();
			stageFunctions();
			settingEffects();
			setupChrome();
			setupMenu();
			
			var model:AppModel = new AppModel;
		}
		
		private function setupMenu():void{
			var menu:NativeMenu = NativeApplication.nativeApplication.menu;
			
			var positionMenu:NativeMenuItem = new NativeMenuItem("Position");
			menu.addItem(positionMenu);
			
			positionMenu.submenu = new NativeMenu();
			
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
			
			NativeApplication.nativeApplication.menu = menu;
		}
		
		private function onTopRight(event:Event):void{
			stage.nativeWindow.width = 500;
			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
			stage.nativeWindow.y = 0;
		}
		
		private function onTopLeft(event:Event):void{
			stage.nativeWindow.width = 500;
			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
		}
		
		private function onBottomRight(event:Event):void{
			stage.nativeWindow.width = 500;
			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
			stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
		}
		
		private function onBottomLeft(event:Event):void{
			stage.nativeWindow.width = 500;
			stage.nativeWindow.height = 397;
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
		}
		
		private function setupChrome():void{
			//just add the assets for the close button
			
			//for close window function
			//stage.nativeWindow.close();
			
			//for minimize function
			//stage.nativeWindow.minimize();
			
			//to move window
			//(MouseEvent.MOUSE_DOWN,onMouseDown);
			//stage.nativeWindow.startMove();
		}
		
		private function settingEffects():void{
			var b:BlurFilter = new BlurFilter(0,0,0);
			_video.filters = [b];
		}
		
		// Responds to Constructor
		private function stageFunctions():void{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP;
			stage.nativeWindow.alwaysInFront = true;	
			_mainScreen = stage.nativeWindow;
		}
		
		// Responds to StageFunctions
		private function onEnterFrame(event:Event):void{
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
			//			stage.addEventListener(KeyboardEvent.KEY_UP, emptyArray);
		}
		
		// Responds to EnterFrame Event
		private function onKeyDown(event:KeyboardEvent):void{
//			if(event.keyCode == Keyboard.L){
//				stage.nativeWindow.width = 500;
//				stage.nativeWindow.height = 397;
//				stage.nativeWindow.x = 0;
//				stage.nativeWindow.y = 0;
//			}
//			if(event.keyCode == Keyboard.R){
//				stage.nativeWindow.width = 500;
//				stage.nativeWindow.height = 397;
//				stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
//				stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
//			}
//			if(event.shiftKey){
//				switch(event.keyCode){
//					case Keyboard.L:
//						stage.nativeWindow.width = 500;
//						stage.nativeWindow.height = 397;
//						stage.nativeWindow.x = 0;
//						stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
//						break;
//				}
//			}
//			else{
//				switch(event.keyCode){
//					case Keyboard.R:
//						stage.nativeWindow.width = 500;
//						stage.nativeWindow.height = 397;
//						stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
//						stage.nativeWindow.y = 0;
//						break;
//				}
//			}
//			if(event.keyCode == Keyboard.F){
//				stage.nativeWindow.width = Capabilities.screenResolutionX;
//				stage.nativeWindow.height = Capabilities.screenResolutionY;
//				stage.nativeWindow.x = 0;
//				stage.nativeWindow.y = 0;
//			}
//			if(event.keyCode == Keyboard.M){
//				stage.nativeWindow.width = 500;
//				stage.nativeWindow.height = 397;
//				stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width)/2;
//				stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.nativeWindow.height)/2;
//			}
			
			//			_keys.push(event.keyCode);
			//			
			//			for each(var c:int in _keys){
			//				if(c==16) _combo.push(c);
			//				if(c==Keyboard.R) _combo.push(c);
			//				if(c==Keyboard.L) _combo.push(c)
			//				if(c==Keyboard.M) _combo.push(c);
			//				if(c==Keyboard.F) _combo.push(c);
			//			}
			//			trace(_combo);
			//			for(var i:int=0; i<_combo.length-1; i++){
			//				if(_combo[i] == 16 && _combo[i+1] == Keyboard.R){
			//					stage.nativeWindow.width = 500;
			//					stage.nativeWindow.height = 397;
			//					stage.nativeWindow.x = Screen.mainScreen.bounds.width - stage.nativeWindow.width;
			//					stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
			//				}
			//				if(_combo[i] == 16 && _combo[i+1] == Keyboard.L){
			//					stage.nativeWindow.width = 500;
			//					stage.nativeWindow.height = 397;
			//					stage.nativeWindow.x = 0;
			//					stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height - 75;
			//				}
			//			}
		}
		//		
		//		private function emptyArray(event:KeyboardEvent):void
		//		{
		//			_keys = [];
		//			_combo = [];
		//		}
		
		private function settingWebcam():void{	
			createSettingsIcon();
			_video = new Video(stage.stageWidth, stage.stageHeight);
			_video.smoothing = true;
			addChild(_video);
			addChild(_bar);
			stage.nativeWindow.y = 0;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2;
			
			_c = Camera.getCamera();
			_c.setMode(stage.stageWidth, stage.stageHeight, 30);
			_video.attachCamera(_c);
			
			
			//Screen.mainScreen.visibleBounds()
			Screen.mainScreen.visibleBounds.x = 0;
			Screen.mainScreen.visibleBounds.y = 0;
			Screen.mainScreen.visibleBounds.width = 1440;
			Screen.mainScreen.visibleBounds.height = _c.height;
			//addItem({data:1, Label:"Apple iSight});
		}
		
		private function createSettingsIcon():void{
			var _settingsIcon:SettingsIcon = new SettingsIcon();
			_settingsIcon.x = stage.stageWidth - _settingsIcon.width - 10;
			_settingsIcon.y = stage.stageHeight - _settingsIcon.height - 10;
			_settingsIcon.addEventListener(MouseEvent.CLICK, onBarClick);
		}
		
		private function onBarClick(event:MouseEvent):void{
			addSettings();
		}
		
		private function addSettings():void {
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			//			options.transparent = true;
			options.systemChrome = NativeWindowSystemChrome.STANDARD;
			options.type = NativeWindowType.NORMAL;
			var nw:NativeWindow = new NativeWindow(options);
			nw.x = _mainScreen.x;
			nw.y = _mainScreen.y;
			nw.width = _mainScreen.width;
			nw.height = _mainScreen.height;
			_settings = new Settings();
			_settings.width = nw.width;
			_settings.height = nw.height;
			//			_settings.x = nw.x;
			//			_settings.y = nw.y;
			_nw = new NativeWindow(options);
			_nw.x = _mainScreen.x;
			_nw.y = _mainScreen.y;		
			_nw.height = 375;
			_nw.width = _mainScreen.width;
			_settings = new Settings();
			_settings.y = 0;
			_settings.x = -15;
			_settings.scaleX = _settings.scaleY = .21;
			_settings.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_nw.stage.addChild(_settings);
			_nw.stage.addEventListener(MouseEvent.CLICK, onStageClick);
			_nw.activate();	
			TweenLite.to(_nw, 1, {x:_mainScreen.x, y:_mainScreen.y + _mainScreen.height, ease:Linear.easeNone});
		}
		
		private function onStageClick(event:MouseEvent):void
		{
			var s:Stage = Stage(event.currentTarget)
			trace(s.mouseX, s.mouseY);
		}
		
		private function onCloseClick(event:MouseEvent):void
		{
			removeChild(_settings);
		}
	}
}