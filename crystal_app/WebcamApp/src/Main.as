package{
	import com.alyssanicoll.events.MenuEvents;
	import com.alyssanicoll.events.SettingsEvent;
	import com.alyssanicoll.model.AppModel;
	import com.alyssanicoll.utils.MenuUtils;
	import com.alyssanicoll.view.Settings;
	import com.alyssanicoll.view.SettingsShortcuts;
	import com.alyssanicoll.vo.SettingsVO;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.ShortRotationPlugin;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	public class Main extends Sprite{
		private var _video:Video;
		//		private var _webcams:Array = Camera.names;
		private var _resolutions:Array = [];
		private var _camera:Camera;
		private var _settings:Settings;
		private var _settingsIcon:Sprite;
		private var _mainScreen:NativeWindow;
		private var _nw:NativeWindow;
		private var _defaultCamera:String;
		private var _inFront:Boolean;
		private var _resolution:String;
		private var _settingsVO:SettingsVO;
		private var _preBg:PreBackground;
		private var _holder:Sprite;
		private var _displayState:Function;

		private var _mainCloseButton:CloseButton;

		private var _tabs:SettingsTabs;

		private var _shortcuts:SettingsShortcuts;
		
		public function Main(){
			
			registerClassAlias("com.ca.vo.SettingsVO",SettingsVO);
			
			_holder = new Sprite();
			addChild(_holder);
			
			openSavedSettings(); // Break out the "preBg" logic to run before this method.
			
			//settingVOVariables();
			settingWebcam();
			stageFunctions();
			setupChrome();
			
			// Called in Constructor - sets up the menu that appears on the top of the screen
			
			var model:AppModel = new AppModel;
			
			// Event Listeners for the Key Shortcuts - Positioning
			NativeApplication.nativeApplication.menu = MenuUtils.makeAppMenu(NativeApplication.nativeApplication.menu);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_TOP_LEFT, onTopLeft);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_BOTTOM_LEFT, onBottomLeft);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_TOP_RIGHT, onTopRight);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_BOTTOM_RIGHT, onBottomRight);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_CENTER, onMiddle);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_FULL_SCREEN, onFullscreen);
			
			// Event Listeners for the Key Shortcuts - Resolution
		//	NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_SMALL, onSmallDisplay);
		//	NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_WIDE, onWideDisplay);
		//	NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_FULLSCREEN, onFullDisplay);
		}
		
		// ACTUALLY listen on native window to close, that will call the onSave
		private function writeSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			_settingsVO.x = _mainScreen.x;
			_settingsVO.y = _mainScreen.y;
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeObject(_settingsVO);
			fs.close();
			
			//onAppOpening();
		}
		
		// ACTUALLY call this function when the app opens
		private function openSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			if(! file.exists){
				trace("File Does not exist");
				// If the file doesn't exist, Perhaps populate a settings VO with default values.
				// OR bring up the settings menu so the user can define and save their own settings.
				_settingsVO = new SettingsVO();
				addSettings();
				return
			}
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			trace(fs.bytesAvailable);
			//pull vo back out and cast it as vo and then set the var throughout the doc = to its variables
			_settingsVO = fs.readObject();
			fs.close();
			
			trace("file Data: ",_settingsVO); // figure out how to see the object you saved to the file stream
			
		}
		
		private function setupChrome():void{
			_mainCloseButton = new CloseButton();
			_mainCloseButton.buttonMode = true;
			_holder.addChild(_mainCloseButton);
			_mainCloseButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_mainCloseButton.name = "mainCloseButton";
			_mainCloseButton.mouseChildern = false;
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		private function onWindowClose(event:MouseEvent):void{
			stage.nativeWindow.close();
		}
		
		private function onMouseDown(event:MouseEvent):void{
			stage.nativeWindow.startMove();
		}
		
		// Responds to Constructor
		private function stageFunctions():void{
			stage.align = StageAlign.TOP;
			stage.nativeWindow.alwaysInFront = _inFront;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_mainScreen = stage.nativeWindow;
			_mainScreen.width = 500;
			_mainScreen.height = 397;
		}
		
		private function onBoxCheck(event:Event):void{
			trace('I am being called');
			stage.nativeWindow.alwaysInFront = _settingsVO.inFront;
			trace(_inFront);
		}
		
		// BG is listening for mouse OVER and OUT
		private function onMouseOver(event:Event):void{
			TweenLite.to(_settingsIcon, .5, {alpha:1});
			TweenLite.to(_mainCloseButton, .5, {alpha:1});
		}
		
		// BG is listening for mouse OVER and OUT
		private function onMouseOut(event:Event):void{
			//  turn mouse enable false on the video, and have a bg that is listening for these events
			if(_holder.contains(_settingsIcon)) TweenLite.to(_settingsIcon, .5, {alpha:0});
			if(_holder.contains(_mainCloseButton)) TweenLite.to(_mainCloseButton, .5, {alpha:0});
		}
	
		// Being called in the constructor - calling camera and video to life
		private function settingWebcam():void{	
			_preBg = new PreBackground();
			//addChild(_preBg);
			
			_holder.addChild(_preBg);
			
			_video = new Video(320, 240);
			_video.smoothing = true;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2;
			stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.nativeWindow.height) / 2;
			_holder.addChild(_video);
			
			_camera = Camera.getCamera(_settingsVO.defaultCamera);
			
			if(!_camera){
				_camera = Camera.getCamera();
			}
			
			_camera.setMode(stage.stageWidth, stage.stageHeight, 30); // TODO: This would use the camera setting
//			_camera.setMode(320, 240, 30);
			_video.attachCamera(_camera);
			_camera.addEventListener(ActivityEvent.ACTIVITY, onActive);
		}
		
		private function onActive(event:ActivityEvent):void{
//			trace(_camera.width,_camera.height);
			_displayState = onMiddle;   //Set display state onActive  <-------------
			_video.height = _camera.height;
			_video.width = _camera.width;
			stage.nativeWindow.width = _video.width;
			stage.nativeWindow.height = _video.height;
			
			if(_holder.contains(_preBg)) _holder.removeChild(_preBg);
			settingsIcon(0);
			_camera.removeEventListener(ActivityEvent.ACTIVITY, onActive);
			_holder.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_holder.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_displayState();
		}
		
		// Called by Mouse OVER and OUT functions -  adding settings Icon to the screen
		private function settingsIcon(alpha:Number):void{
			if(_settingsIcon==null){
				_settingsIcon = new Gear();
			}
			_settingsIcon.buttonMode = true;
			_settingsIcon.alpha = alpha;
			_settingsIcon.x = (_mainScreen.width - _settingsIcon.width) - 5;
			_settingsIcon.y = (_mainScreen.height - _settingsIcon.height) - 5;
			_settingsIcon.addEventListener(MouseEvent.CLICK, onSettingsClick);
			_holder.addChild(_settingsIcon);
		}
		
		private function onSettingsClick(event:MouseEvent):void{
			addSettings();
			addTabs();
			_mainCloseButton.name = "settingsCloseButton";
			_settingsIcon.removeEventListener(MouseEvent.CLICK, onSettingsClick);
		}
		
		private function addTabs():void
		{
			_tabs = new SettingsTabs();
			_tabs.x = -_tabs.width/2;
			_tabs.alpha = 0;
			_holder.addChild(_tabs);
			TweenLite.to(_tabs, 1, {alpha:1});
			
			_tabs.tabShortcuts.buttonMode = true;
			_tabs.tabSettings.buttonMode = true;
			
			_tabs.tabShortcuts.addEventListener(MouseEvent.CLICK, onShortcutsTabClick);
			_tabs.tabSettings.addEventListener(MouseEvent.CLICK, onSettingsTabClick);
		}
		
		private function onSettingsTabClick(event:MouseEvent):void
		{
			if(_shortcuts && _holder.contains(_shortcuts)){
				_holder.removeChild(_shortcuts);
				addSettings();
			}
		}
		
		private function onShortcutsTabClick(event:MouseEvent):void
		{
			if(_settings && _holder.contains(_settings)){
				_holder.removeChild(_settings);
				addShortcuts();
			}
		}
		
		private function addShortcuts():void
		{
			_shortcuts = new SettingsShortcuts();
			_shortcuts.y = 0;
			_shortcuts.x = 0;
			_shortcuts.alpha = 0;
			_holder.addChild(_shortcuts);
			TweenLite.to(_shortcuts, 1, {alpha:1});
			_shortcuts.addEventListener('topLeft', onTopLeft);
			_shortcuts.addEventListener('topRight', onTopRight);
			_shortcuts.addEventListener('middle', onMiddle);
			_shortcuts.addEventListener('bottomLeft', onBottomLeft);
			_shortcuts.addEventListener('bottomRight', onBottomRight);
			_shortcuts.addEventListener('fullscreen', onFullscreen);

		}
		
		private function addSettings():void {
			_settings = new Settings();
			_settings.settingsVO = _settingsVO;
			_settings.y = 0;
			_settings.x = 0;
			_settings.alpha = 0;
			_holder.addChild(_settings);
			TweenLite.to(_settings, 1, {alpha:1});
			_settings.addEventListener(SettingsEvent.SETTINGS_CHANGE,onSettingsChange);
			
		}
		
		private function onSettingsChange(event:SettingsEvent):void
		{
			_settingsVO = Settings(event.currentTarget).settingsVO;
			
			// Cleaning up dirty settings. Fix how it's stored and you won't need this!
			var resString:String = _settingsVO.resolution.replace(/\s/g,'');
			var res:Array = resString.split("X");
			trace(resString);
			
			onRezChange(res[0],res[1]);
			
			// Use this function to update display and stuffs.
			
			writeSavedSettings();
		}
		
		private function onCloseClick(event:MouseEvent):void{
			trace(event.currentTarget.name);
			if(event.currentTarget.name == 'mainCloseButton'){
				stage.nativeWindow.close();
			}
			else{
				if(_holder.contains(_settings)){
					_holder.removeChild(_settings);
				}
				else{
					_holder.removeChild(_shortcuts);
				}
				_holder.removeChild(_tabs);
				_mainCloseButton.name = "mainCloseButton";
				_settingsIcon.addEventListener(MouseEvent.CLICK, onSettingsClick);
			}
		}
		
		private function resetWindow():void{
			stage.nativeWindow.width = _video.width;
			stage.nativeWindow.height = _video.height;
			settingsIcon(_settingsIcon.alpha);
		}
		
		private function onFullscreen(event:Event):void{
			stage.nativeWindow.width = Screen.mainScreen.visibleBounds.width
			stage.nativeWindow.height = Screen.mainScreen.visibleBounds.height;
			TweenLite.to(stage.nativeWindow, .5, {x:Screen.mainScreen.visibleBounds.left, 
				y:Screen.mainScreen.visibleBounds.top, ease:Circ.easeOut});
			resetWindow();
			_displayState = onMiddle;
		}
		
		private function onMiddle(event:Event=null):void{
			TweenLite.to(stage.nativeWindow, .5, {x:(Screen.mainScreen.visibleBounds.width - stage.nativeWindow.width)/2, 
				y:(Screen.mainScreen.visibleBounds.height - stage.nativeWindow.height)/2, ease:Circ.easeOut});
			resetWindow();
			_displayState = onMiddle;
		}
		
		private function onTopRight(event:Event=null):void{
			TweenLite.to(stage.nativeWindow, .5, {x:Screen.mainScreen.visibleBounds.right - stage.nativeWindow.width, 
				y:Screen.mainScreen.visibleBounds.top, ease:Circ.easeOut});

			resetWindow();
			_displayState = onTopRight;
		}
		
		private function onTopLeft(event:Event=null):void{
			TweenLite.to(stage.nativeWindow, .5, {x:Screen.mainScreen.visibleBounds.left, 
				y:Screen.mainScreen.visibleBounds.top, ease:Circ.easeOut});
			resetWindow();
			_displayState = onTopLeft;
		}
		
		private function onBottomRight(event:Event=null):void{
			TweenLite.to(stage.nativeWindow, .5, {x:Screen.mainScreen.visibleBounds.right - stage.nativeWindow.width, 
				y:Screen.mainScreen.visibleBounds.bottom - stage.nativeWindow.height, ease:Circ.easeOut});
			resetWindow();
			_displayState = onBottomRight;
		}
		
		private function onBottomLeft(event:Event=null):void{
			TweenLite.to(stage.nativeWindow, .5, {x:Screen.mainScreen.visibleBounds.left, 
				y:Screen.mainScreen.visibleBounds.bottom - stage.nativeWindow.height, ease:Circ.easeOut});
			resetWindow();
			_displayState = onBottomLeft;
		}
		
		private function onRezChange(resX:uint,resY:uint):void
		{
			stage.stageWidth = _video.width = resX;
			stage.stageHeight = _video.height = resY;
			settingsIcon(_settingsIcon.alpha);
			_displayState();
		}
		
/*		private function onFullDisplay(event:Event):void{	
			stage.stageWidth = _video.width = 720;
			stage.stageHeight = _video.height = 480;
			settingsIcon(_settingsIcon.alpha);
			_displayState();
		}
		
		private function onWideDisplay(event:Event):void{
			stage.stageWidth = _video.width = 360;
			stage.stageHeight = _video.height = 240;
			settingsIcon(_settingsIcon.alpha);
			_displayState();
		}
		
		private function onSmallDisplay(event:Event):void{
			stage.stageWidth = _video.width = 320;
			stage.stageHeight = _video.height = 240;
			settingsIcon(_settingsIcon.alpha);
			_displayState();
		}
		
		private function settingVOVariables():void{
			var settings:Settings = new Settings();
		//	_inFront = settings.inFront;
		}*/
	}
}