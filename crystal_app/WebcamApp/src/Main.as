package{
	import com.alyssanicoll.events.MenuEvents;
	import com.alyssanicoll.events.SettingsEvent;
	import com.alyssanicoll.model.AppModel;
	import com.alyssanicoll.model.FileStore;
	import com.alyssanicoll.utils.MenuUtils;
	import com.alyssanicoll.view.Filters;
	import com.alyssanicoll.view.Settings;
	import com.alyssanicoll.view.SettingsShortcuts;
	import com.alyssanicoll.vo.SettingsVO;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.controls.ComboBox;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import org.osmf.media.DefaultMediaFactory;
	
	public class Main extends Sprite{
		private var _video:Video;
		//private var _resolutions:Array = [16:9 - 4:3];
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
		private var _displayState:String;
		private var _mainCloseButton:CloseButton;
		private var _tabs:SettingsTabs;
		private var _shortcuts:SettingsShortcuts;
		private var _filters:Filters = new Filters();

		private var _fileStore:FileStore;
		
		public function Main(){
			
			registerClassAlias("com.ca.vo.SettingsVO", SettingsVO);
			
			_holder = new Sprite();
			addChild(_holder);
			
			_fileStore = new FileStore();
			_settingsVO = _fileStore.settingsVO;
			trace(_settingsVO.inFront);
			
			settingWebcam();
			stageFunctions();
			setupChrome();
			addSettings(0);
			_video.filters = [];
			// Called in Constructor - sets up the menu that appears on the top of the screen
			
//			var model:AppModel = new AppModel;
			
						
			// Event Listeners for the Key Shortcuts - Positioning
			NativeApplication.nativeApplication.menu = MenuUtils.makeAppMenu(NativeApplication.nativeApplication.menu);
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.POSITION_CHANGE, onPositionChange);

			// Event Listeners for the Key Shortcuts - Resolution
			NativeApplication.nativeApplication.menu.addEventListener(MenuEvents.REQUEST_RESOLUTION_CHANGE, onResolutionChange);
		}
		
		
		private function setupChrome():void{
			_mainCloseButton = new CloseButton();
			_mainCloseButton.stop();
			_mainCloseButton.buttonMode = true;
			_holder.addChild(_mainCloseButton);
			_mainCloseButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_mainCloseButton.name = "mainCloseButton";
			_mainCloseButton.mouseChildern = false;
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		
		private function onActive(event:ActivityEvent):void{
//			trace(_camera.width,_camera.height);
			trace("From settings vo in onActive",Camera.names[0]);
//			_camera = new Camera();
			_camera.setMode(_settingsVO.resolutionX, _settingsVO.resolutionY, 30, true); // TODO: This would use the camera setting
			_displayState = "Center";   //Set display state onActive  <-------------
			_video.height = _camera.height;
			_video.width = _camera.width;
			stage.nativeWindow.width = _video.width;
			stage.nativeWindow.height = _video.height;
			
			if(_holder.contains(_preBg)) _holder.removeChild(_preBg);
			_camera.removeEventListener(ActivityEvent.ACTIVITY, onActive);
			_holder.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_holder.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			settingsIcon(0);
			onPositionChange();
			
			
			if(_video.width >= 500 && _settings){
				_settings.x = (_video.width - _settings.width)/2;
				_settings.y = ((_video.height - _settings.height)/2)-100;
				_tabs.x = (_video.width - (_tabs.width*2.5))/2;
				_tabs.y = (_settings.y - _tabs.height);
			}
				
			else if(_video.width <= 499 && _settings){
				_settings.x = 0;
				_settings.y = 0;
			}
			
			if(_video.width >= 500 && _shortcuts){
				_shortcuts.x = ((_video.width - _shortcuts.width)/2)-30;
				_shortcuts.y = ((_video.height - _shortcuts.height)/2)-100;
				_tabs.x = (_video.width - (_tabs.width*2.5))/2;
				_tabs.y = (_settings.y - _tabs.height);
			}
				
			else if(_video.width <= 499 && _shortcuts){
				_shortcuts.x = 0;
				_shortcuts.y = 0;
				_tabs.x = 0;
				_tabs.y = 20;
			}
		}
		
		private function onWindowClose(event:MouseEvent):void{
			stage.nativeWindow.close();
		}
		
		private function onMouseDown(event:MouseEvent):void{
			stage.nativeWindow.startMove();
			
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			if(stage.nativeWindow.bounds.top){
				resetWindow();
			}			
		}
		
		// Responds to Constructor
		private function stageFunctions():void{
			stage.align = StageAlign.TOP;
//			stage.nativeWindow.alwaysInFront = _inFront;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_mainScreen = stage.nativeWindow;
			_mainScreen.width = _settingsVO.resolutionX;
			_mainScreen.height = _settingsVO.resolutionY;
		}
		
		private function onBoxCheck():void{
			stage.nativeWindow.alwaysInFront = _settingsVO.inFront;
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
			_holder.addChild(_preBg);
			_video = new Video(320, 240);
			_video.smoothing = true;
			_holder.addChild(_video);
			_camera = Camera.getCamera(String(_settingsVO.defaultCameraIndex));
			
			if(!_camera){
				_camera = Camera.getCamera();
			}
			
//			_camera.setMode(320, 240, 30);
			_video.attachCamera(_camera);
			_camera.addEventListener(ActivityEvent.ACTIVITY, onActive);
			stage.nativeWindow.x = ((Screen.mainScreen.bounds.width - _camera.width) / 2)/2;
			stage.nativeWindow.y = ((Screen.mainScreen.bounds.height - _camera.height) / 2)/2;
			_preBg.width = _settingsVO.resolutionX*2;
			_preBg.height = _settingsVO.resolutionY;
			
		}
		
		// Called by Mouse OVER and OUT functions -  adding settings Icon to the screen
		private function settingsIcon(alpha:Number):void{
			if(_settingsIcon==null){
				_settingsIcon = new Gear();
			}
			_settingsIcon.buttonMode = true;
			_settingsIcon.alpha = alpha;
			_settingsIcon.x = (_camera.width - _settingsIcon.width) - 5;
			_settingsIcon.y = (_camera.height - _settingsIcon.height) - 5;
			_settingsIcon.addEventListener(MouseEvent.CLICK, onSettingsClick);
			_holder.addChild(_settingsIcon);
		}
		
		private function onSettingsClick(event:MouseEvent):void{
			addSettings();
			addTabs();
			_mainCloseButton.gotoAndStop(2);
			
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
		
		private function addShortcuts():void{
			_shortcuts = new SettingsShortcuts();

			_shortcuts.y = 0;
			_shortcuts.x = 0;
			_shortcuts.alpha = 0;
			_holder.addChild(_shortcuts);
			TweenLite.to(_shortcuts, 1, {alpha:1});
			_shortcuts.addEventListener(MenuEvents.POSITION_CHANGE, onPositionChange);
			
			_video.filters = [_filters.myBlur, _filters.myGlow];
		}
		
		private function addSettings(defaultAlpha:Number = 1):void {
			if(_settings==null) _settings = new Settings();
			_settings.settingsVO = _settingsVO;
			_settings.x = 0;
			_settings.y = 0;
			_settings.alpha = 0;
			_holder.addChild(_settings);
			TweenLite.to(_settings, .5, {alpha:defaultAlpha});
			_settings.addEventListener(SettingsEvent.SETTINGS_CHANGE,onSettingsChange);
			_settings.addEventListener(SettingsEvent.CAMERA_CHANGE,onCameraChange);
			
			_video.filters = [_filters.myBlur, _filters.myGlow];
		}
		
		private function onCameraChange(event:Event):void
		{
			_camera = Camera.getCamera(String(_settingsVO.defaultCameraIndex));
			_video.attachCamera(_camera);
			_camera.addEventListener(ActivityEvent.ACTIVITY,onActive);

		}
		
		private function onSettingsChange(event:SettingsEvent):void{
			trace(_settingsVO.defaultCamera)

			_camera.addEventListener(ActivityEvent.ACTIVITY,onActive);
			
//			onSettingsRezChange(_settingsVO.resolutionX,_settingsVO.resolutionY);
			_settingsVO = Settings(event.currentTarget).settingsVO;
			_camera.setMode(_settingsVO.resolutionX,_settingsVO.resolutionY,30,true);
			// Use this function to update display and stuffs.
			_fileStore.settingsVO = _settingsVO;
			onBoxCheck();
			_inFront = _settingsVO.inFront;
			
		}
		
		
		private function onCloseClick(event:MouseEvent):void{
			trace(event.currentTarget.name);
			if(event.currentTarget.name == 'mainCloseButton'){
				stage.nativeWindow.close();
			}
			else{
				if(_holder.contains(_settings)){
					_holder.removeChild(_settings);
					_mainCloseButton.gotoAndStop(1);
				}
				else{
					_holder.removeChild(_shortcuts);
					_mainCloseButton.gotoAndStop(1);
				}
				_holder.removeChild(_tabs);
				_mainCloseButton.name = "mainCloseButton";
				_settingsIcon.addEventListener(MouseEvent.CLICK, onSettingsClick);
				_video.filters = [];
			}
		}
		
		private function resetWindow():void{
			stage.nativeWindow.width = _camera.width;
			stage.nativeWindow.height = _camera.height;
			_holder.x = 0;
			_holder.y = 0;
			settingsIcon(_settingsIcon.alpha);
		}
		
		private function onPositionTween(positionX:Number, positionY:Number):void
		{
			resetWindow();
			TweenLite.to(stage.nativeWindow, .5, {x:positionX, y:positionY, ease:Circ.easeOut});
		}
		
		private function onPositionChange(p:MenuEvents=null):void{
			var compareVal:String="";
			(p == null) ? compareVal = _displayState : compareVal = p.newPos;
			switch (compareVal){
				case "TopLeft":
					onPositionTween(_settingsVO.left, _settingsVO.top);
					_displayState = compareVal;
					break;
				
				case "TopRight":
					onPositionTween(_settingsVO.right - _camera.width, _settingsVO.top);
					_displayState = compareVal;
					break;
				
				case "BottomLeft":
					onPositionTween(_settingsVO.left, _settingsVO.bottom - _camera.height);
					_displayState = compareVal;
					break;
				
				case "BottomRight":
					onPositionTween(_settingsVO.right - stage.nativeWindow.width, _settingsVO.bottom - _camera.height);
					_displayState = compareVal;
					break;
				
				case "Center":
					onPositionTween((Screen.mainScreen.visibleBounds.width - _camera.width)/2,
						(Screen.mainScreen.visibleBounds.height - _camera.height)/2);
					_displayState = compareVal;
					break;
				
				case "Fullscreen":
					stage.nativeWindow.width = Screen.mainScreen.visibleBounds.width;
					stage.nativeWindow.height = Screen.mainScreen.visibleBounds.height;
					
					_video.width = 1025;
					_video.height = 768;
					
//					_holder.x = (stage.nativeWindow.width - _holder.width)/2;
//					_holder.y = (stage.nativeWindow.height - _holder.height)/2;
					
					_camera.setMode(_video.width,_video.height,30,true);
					settingsIcon(_settingsIcon.alpha);
					
					//onPositionTween(_settingsVO.left, _settingsVO.top);
					onPositionTween((Screen.mainScreen.visibleBounds.width - _camera.width)/2,
						(Screen.mainScreen.visibleBounds.height - _camera.height)/2);
					
					_displayState = "Center";
					break;
			}
		}

		private function onResolutionChange(e:MenuEvents):void{
			_camera.addEventListener(ActivityEvent.ACTIVITY,onActive);
			_camera.setMode(e.width,e.height,30,true);
			_settingsVO.resolutionX = e.width;
			_settingsVO.resolutionY = e.height;
			_settingsVO.resolutionSelected = e.index;
		}
	}
}