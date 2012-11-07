package{
	import com.ca.model.AppModel;
	import com.ca.view.Menus;
	import com.ca.view.Settings;
	import com.ca.vo.SettingsVO;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.BlurFilter;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	public class Main extends Sprite{
		private var _video:Video;
//		private var _webcams:Array = Camera.names;
		private var _resolutions:Array = ["128 x 96","176 x 144","352 x 288","704 x 576","1408 x 1152"];
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
		
		public function Main(){
			
			settingWebcam();
			stageFunctions();
			setupChrome();
			
			// Called in Constructor - sets up the menu that appears on the top of the screen
			var menu:Menus = new Menus();
			
			var model:AppModel = new AppModel;

			openSavedSettings();
			registerClassAlias("com.ca.vo.SettingsVO",SettingsVO);
		}
		
		// ACTUALLY listen on native window to close, that will call the onSave
		private function openSavedSettings():void{
			var file:File = File.applicationStorageDirectory;
			file.nativePath += File.separator + "settings.data";
						
			_settingsVO = new SettingsVO();
			_settingsVO.x = _mainScreen.x;
			_settingsVO.y = _mainScreen.y;
			_settingsVO.width = _mainScreen.width;
			_settingsVO.height = _mainScreen.height;
			_settingsVO.inFront = _inFront;
			_settingsVO.resolution = _resolution;
			_settingsVO.defaultCamera = _defaultCamera;
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeObject(_settingsVO);
			fs.close();
			
			onAppOpening();
		}
		
		// ACTUALLY call this function when the app opens
		private function onAppOpening():void{
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
		}
		

		
			private function setupChrome():void{
			//just add the assets for the close button
			var closeButton:CloseButton = new CloseButton();
			stage.addChild(closeButton);
			
			//for close window function
			//stage.nativeWindow.close();
			
			//for minimize function
			//stage.nativeWindow.minimize();
			
			//to move window
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			
			// ADD RESIZE BACK --------------------------------------------------------------------------------------------------------------
		}
		
		private function onMouseDown(event:MouseEvent):void{
			// This isnt working? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 
			stage.nativeWindow.startMove();
		}
		
		// What is this effect doing ?  ?  Can we have an effect called on settings window that blurs and darkens video ? ? ? ? ? ? ? ? ? ? ? ? 
		private function settingEffects():void{
			var b:BlurFilter = new BlurFilter(10,10,10);
			_video.filters = [b];
		}
		
		// Responds to Constructor
		private function stageFunctions():void{
//			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP;
			stage.nativeWindow.alwaysInFront = true;	
			_mainScreen = stage.nativeWindow;
			_mainScreen.width = 500;
			_mainScreen.height = 397;
			
			
			// Why arent these working ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
			stage.addEventListener(MouseEvent.MOUSE_OVER , onMouseOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT , onMouseOut);

//			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
//			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_OVER , onMouseOver);
			_mainScreen.addEventListener(MouseEvent.MOUSE_OUT , onMouseOut);
		}
		
		// BG is listening for mouse OVER and OUT
		private function onMouseOut(event:Event):void{
			//  turn mouseenable false on the video, and have a bg that is listening for these events, and the bg loads b4 everything
			this.removeChild(_settingsIcon);
		}
		// BG is listening for mouse OVER and OUT
		private function onMouseOver(event:Event):void{
			settingsIcon();
		}
		
		// Being called in the constructor - calling camera and video to life
		private function settingWebcam():void{	
			_preBg = new PreBackground();
			addChild(_preBg);
			_video = new Video(stage.stageWidth, stage.stageHeight);
			_video.smoothing = true;
			_video.addEventListener(Event.COMPLETE, onVideoComplete);
			stage.nativeWindow.y = Screen.mainScreen.visibleBounds.top;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2;
			addChild(_video);
			
			_camera = Camera.getCamera();
			_camera.setMode(stage.stageWidth, stage.stageHeight, 30);
			_video.attachCamera(_camera);
		}
		
		private function onVideoComplete(event:Event):void{
			settingsIcon();
		}
		
		// Called by Mouse OVER and OUT functions -  adding settings Icon to the screen
		private function settingsIcon():void{
			_settingsIcon = new Gear;
			_settingsIcon.x = (_mainScreen.width - _settingsIcon.width) - 5;
			_settingsIcon.y = (_mainScreen.height - _settingsIcon.height) - 5;
			_settingsIcon.addEventListener(MouseEvent.CLICK, onSettingsClick);
			addChild(_settingsIcon);
		}
		
		private function onSettingsClick(event:MouseEvent):void{
			addSettings();
		}
		
		private function addSettings():void {
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.transparent = true;
			options.systemChrome = NativeWindowSystemChrome.NONE;
			options.type = NativeWindowType.NORMAL;
			
			_nw = new NativeWindow(options);		
			_nw.height = _mainScreen.height;
			_nw.width = _mainScreen.width;
			_nw.x = _mainScreen.x;
			_nw.y = _mainScreen.y;
			_nw.alwaysInFront = true;
			
			_nw.stage.scaleMode = StageScaleMode.NO_SCALE;
			_nw.stage.align = StageAlign.TOP_LEFT;
			_nw.activate();	
			
			_settings = new Settings();
			_settings.y = 0;
			_settings.x = 0;
			_settings.alpha = 0;
			_settings.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			
			_nw.stage.addChild(_settings);
			
			stage.align = StageAlign.BOTTOM;
			_nw.stage.align = StageAlign.TOP;

			
			TweenLite.to(_settings, 1, {alpha:1});
		}
		
		private function onCloseClick(event:MouseEvent):void{
			_settings.stage.nativeWindow.close();
		}
	}
}