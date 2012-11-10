package{
	import com.ca.events.MenuEvents;
	import com.ca.model.AppModel;
	import com.ca.utils.MenuUtils;
	import com.ca.view.Settings;
	import com.ca.vo.SettingsVO;
	import com.greensock.*;
	import com.greensock.easing.*;
	
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
		private var _storageArray:ByteArray = new ByteArray();
		private var _defaultCamera:String;
		private var _inFront:Boolean;
		private var _resolution:String;
		private var _settingsVO:SettingsVO;
		private var _preBg:PreBackground;
		private var _holder:Sprite;
		private var _displayState:Object;

		private var _mainCloseButton:CloseButton;
		
		public function Main(){
			
			_holder = new Sprite();
			addChild(_holder);
			
			settingVOVariables();
			settingWebcam();
			stageFunctions();
			setupChrome();
			
			// Called in Constructor - sets up the menu that appears on the top of the screen
			
			var model:AppModel = new AppModel;
			
			openSavedSettings();
			registerClassAlias("com.ca.vo.SettingsVO",SettingsVO);
			
			
			// Event Listeners for the Key Shortcuts - Positioning
			NativeApplication.nativeApplication.menu = MenuUtils.makeAppMenu(NativeApplication.nativeApplication.menu);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_TOP_LEFT, onTopLeft);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_BOTTOM_LEFT, onBottomLeft);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_TOP_RIGHT, onTopRight);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_BOTTOM_RIGHT, onBottomRight);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_CENTER, onCenter);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_FULL_SCREEN, onFullscreen);
			
			// Event Listeners for the Key Shortcuts - Resolution
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_SMALL, onSmallDisplay);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_WIDE, onWideDisplay);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_FULLSCREEN, onFullDisplay);
		}
		
		private function onFullDisplay(event:Event):void{	
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
			_inFront = settings.inFront;
		}
		
		// ACTUALLY listen on native window to close, that will call the onSave
		private function onAppOpening():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			_settingsVO = new SettingsVO();
			_settingsVO.x = _mainScreen.x;
			_settingsVO.y = _mainScreen.y;
			_settingsVO.width = _mainScreen.width;
			_settingsVO.height = _mainScreen.height;
//			_settingsVO.inFront = _settings.inFront;
			_settingsVO.resolution = _resolution;
			_settingsVO.defaultCamera = _defaultCamera;
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeObject(_settingsVO);
			fs.close();
			
			onAppOpening();
		}
		
		// ACTUALLY call this function when the app opens
		private function openSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
			
			if(! file.exists){
				trace("File Does not exist");
				return
			}
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			//			var settingsVO:SettingsVO = fs.readObject();
			fs.close();
			
			//pull vo back out and cast it as vo and then set the var throughout the doc = to its variables
		}
		
		private function setupChrome():void{
			_mainCloseButton = new CloseButton();
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
			stage.nativeWindow.alwaysInFront = _settings.inFront;
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
			
			_video = new Video(stage.stageWidth, stage.stageHeight);
			_video.smoothing = true;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2;
			stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.nativeWindow.height) / 2;
			_holder.addChild(_video);
			
			_camera = Camera.getCamera();
			_camera.setMode(stage.stageWidth, stage.stageHeight, 30);
			_video.attachCamera(_camera);
			_camera.addEventListener(ActivityEvent.ACTIVITY, onActive);
		}
		
		private function onActive(event:ActivityEvent):void{
//			trace(_camera.width,_camera.height);
			_displayState = onCenter;   //Set display state onActive  <-------------
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
			_settingsIcon.alpha = alpha;
			_settingsIcon.x = (_mainScreen.width - _settingsIcon.width) - 5;
			_settingsIcon.y = (_mainScreen.height - _settingsIcon.height) - 5;
			_settingsIcon.addEventListener(MouseEvent.CLICK, onSettingsClick);
			_holder.addChild(_settingsIcon);
		}
		
		private function onSettingsClick(event:MouseEvent):void{
			addSettings();
			_mainCloseButton.name = "settingsCloseButton";
			_settingsIcon.removeEventListener(MouseEvent.CLICK, onSettingsClick);
		}
		
		private function addSettings():void {
			_settings = new Settings();
			_settings.y = 0;
			_settings.x = 0;
			_settings.alpha = 0;
			_holder.addChild(_settings);
			TweenLite.to(_settings, 1, {alpha:1});
			_settings.addEventListener('checkBox', onBoxCheck);
		}
		
		private function onCloseClick(event:MouseEvent):void{
			trace(event.currentTarget.name);
			if(event.currentTarget.name == 'mainCloseButton'){
				stage.nativeWindow.close();
			}
			else{
				_holder.removeChild(_settings);
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
			_displayState = onCenter;
		}
		
		private function onCenter(event:Event=null):void{
			TweenLite.to(stage.nativeWindow, .5, {x:(Screen.mainScreen.visibleBounds.width - stage.nativeWindow.width)/2, 
				y:(Screen.mainScreen.visibleBounds.height - stage.nativeWindow.height)/2, ease:Circ.easeOut});
			resetWindow();
			_displayState = onCenter;
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
	}
}