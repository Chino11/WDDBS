package
{
	public class CrapIMightNeedLater
	{
		public function CrapIMightNeedLater()
		{
		}		private function addSettings():void {
			
			/*			
			This code is for the second native window
			Delete if you decide to keep everything on one window
			
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
			
			stage.align = StageAlign.BOTTOM;
			_nw.stage.align = StageAlign.TOP;
			*/
			
			_settings = new Settings();
			_settings.y = 0;
			_settings.x = 0;
			_settings.alpha = 0;
			_settings.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			_holder.addChild(_settings);
			TweenLite.to(_settings, 1, {alpha:1});
		}
		
		
		private function onCenter(event:Event):void{
			//			stage.nativeWindow.width = 500;
			//			stage.nativeWindow.height = 397;
			resetWindow();
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
		
		// Being called in the constructor - calling camera and video to life
		private function settingWebcam():void{	
			_preBg = new PreBackground();
			addChild(_preBg);
			
			
			_holder.addChild(_preBg);
			
			_video = new Video(stage.stageWidth, stage.stageHeight);
			_video.smoothing = true;
			stage.nativeWindow.y = Screen.mainScreen.visibleBounds.top;
			stage.nativeWindow.x = (Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2;
			_holder.addChild(_video);
			
			_camera = Camera.getCamera();
			_camera.setMode(stage.stageWidth, stage.stageHeight, 30);
			//_camera.setMode(1280, 1024, 30);
			_video.attachCamera(_camera);
			_camera.addEventListener(ActivityEvent.ACTIVITY, onActive);
			
			// FINDING OTHER CAMERAS
			
			//			for each(var s:String in Camera.names) 
			//			trace("camera's : ", s, Camera.names.length);
		}
		
		private function onActive(event:ActivityEvent):void{
			/*
			trace(_camera.width,_camera.height);
			_video.height = _camera.height;
			_video.width = _camera.width;
			stage.nativeWindow.width = _video.width;
			stage.nativeWindow.height = _video.height;
			*/
			if(_holder.contains(_preBg)) _holder.removeChild(_preBg);
			settingsIcon(0);
			_camera.removeEventListener(ActivityEvent.ACTIVITY, onActive);
			_holder.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_holder.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
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
		}
		
		
		
		
		
		
		
		
		
		import com.ca.model.AppModel;
		import com.ca.utils.MenuUtils;
		import com.ca.view.Settings;
		import com.ca.vo.SettingsVO;
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
		import flash.display.StageAlign;
		import flash.display.StageScaleMode;
		import flash.events.ActivityEvent;
		import flash.events.Event;
		import flash.events.MouseEvent;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
		import flash.filters.BlurFilter;
		import flash.media.Camera;
		import flash.media.Video;
		import flash.net.registerClassAlias;
		import flash.system.Capabilities;
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
			private var _holder:Sprite;
			
			public function Main(){
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				
				_holder = new Sprite();
				addChild(_holder);
				
				settingWebcam();
				stageFunctions();
				setupChrome();
				//			setUpMenu();
				
				// Called in Constructor - sets up the menu that appears on the top of the screen
				
				var model:AppModel = new AppModel;
				
				openSavedSettings();
				registerClassAlias("com.ca.vo.SettingsVO",SettingsVO);
				
				NativeApplication.nativeApplication.menu = MenuUtils.makeAppMenu(NativeApplication.nativeApplication.menu);
			}
			
			//		private function setUpMenu():void
			//		{
			//			var menu:NativeMenu = NativeApplication.nativeApplication.menu;
			//			trace(NativeApplication, "this is the native application");
			//			
			//			var positionMenu:NativeMenuItem = new NativeMenuItem("Position");
			//			menu.addItem(positionMenu);
			//			
			//			var resolutionMenu:NativeMenuItem = new NativeMenuItem("Resolution");
			//			menu.addItem(resolutionMenu);
			//			
			//			positionMenu.submenu = new NativeMenu();
			//			resolutionMenu.submenu = new NativeMenu();
			//			
			//			var LeftSubItem:NativeMenuItem = new NativeMenuItem("Top-Left");
			//			LeftSubItem.keyEquivalentModifiers = [];
			//			LeftSubItem.keyEquivalent = "l";
			//			LeftSubItem.addEventListener(Event.SELECT, onTopLeft);
			//			positionMenu.submenu.addItem(LeftSubItem);
			//			
			//			var RightSubItem:NativeMenuItem = new NativeMenuItem("Top-Right");
			//			RightSubItem.keyEquivalentModifiers = [];
			//			RightSubItem.keyEquivalent = "r";
			//			RightSubItem.addEventListener(Event.SELECT, onTopRight);
			//			positionMenu.submenu.addItem(RightSubItem);
			//			
			//			var bLeftSubItem:NativeMenuItem = new NativeMenuItem("Bottom-Left");
			//			bLeftSubItem.keyEquivalentModifiers = [];
			//			bLeftSubItem.keyEquivalent = "L";
			//			bLeftSubItem.addEventListener(Event.SELECT, onBottomLeft);
			//			positionMenu.submenu.addItem(bLeftSubItem);
			//			
			//			var bRightSubItem:NativeMenuItem = new NativeMenuItem("Bottom-Right");
			//			bRightSubItem.keyEquivalentModifiers = [];
			//			bRightSubItem.keyEquivalent = "R";
			//			bRightSubItem.addEventListener(Event.SELECT, onBottomRight);
			//			positionMenu.submenu.addItem(bRightSubItem);
			//			
			//			var middleSubItem:NativeMenuItem = new NativeMenuItem("Middle");
			//			middleSubItem.keyEquivalentModifiers = [];
			//			middleSubItem.keyEquivalent = "m";
			//			middleSubItem.addEventListener(Event.SELECT, onMiddle);
			//			positionMenu.submenu.addItem(middleSubItem);
			//			
			//			var fullscreenSubItem:NativeMenuItem = new NativeMenuItem("FullScreen");
			//			fullscreenSubItem.keyEquivalentModifiers = [];
			//			fullscreenSubItem.keyEquivalent = "f";
			//			fullscreenSubItem.addEventListener(Event.SELECT, onFullscreen);
			//			positionMenu.submenu.addItem(fullscreenSubItem);
			//			
			//			NativeApplication.nativeApplication.menu = menu;
			//			
			//		}
			
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
				_holder.addChild(closeButton);
				
				//for close window function
				//stage.nativeWindow.close();
				
				//for minimize function
				//stage.nativeWindow.minimize();
				
				//to move window
				stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				
				// ADD RESIZE BACK --------------------------------------------------------------------------------------------------------------
			}
			
			private function onMouseDown(event:MouseEvent):void{
				stage.nativeWindow.startMove();
			}
	}
}