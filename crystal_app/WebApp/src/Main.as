package
{
	import com.ca.model.AppModel;
	import com.ca.view.Settings;
	import com.greensock.*;
	import com.greensock.easing.*;
	
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
	import flash.system.Capabilities;
	import flash.ui.Keyboard;

	public class Main extends Sprite
	{
		private var _video:Video;
		private var _webcams:Array = Camera.names;
		private var _resolutions:Array = ["128 x 96","176 x 144","352 x 288","704 x 576","1408 x 1152"];
		private var _c:Camera;
		private var _settings:Settings;
		private var _mainScreen:NativeWindow;

		private var _nw:NativeWindow;

		private var _bar:Sprite;
		
		
		public function Main()
		{
			settingWebcam();
			stageFunctions();
			settingEffects();
			
			var model:AppModel = new AppModel;
		}
		
		private function settingEffects():void
		{
			var b:BlurFilter = new BlurFilter(0,0,0);
			_video.filters = [b];
		}
		
		// Responds to Constructor
		private function stageFunctions():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP;
			stage.nativeWindow.alwaysInFront = true;	
			_mainScreen = stage.nativeWindow;
		}
		
		// Responds to StageFunctions
		private function onEnterFrame(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		// Responds to EnterFrame Event
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.L){
				stage.nativeWindow.width = 500;
				stage.nativeWindow.height = 397;
				stage.nativeWindow.x = 0;
				stage.nativeWindow.y = 0;
			}
			if(event.keyCode == Keyboard.R){
				stage.nativeWindow.width = 500;
				stage.nativeWindow.height = 397;
				stage.nativeWindow.x =  Screen.mainScreen.bounds.width - stage.nativeWindow.width;
				stage.nativeWindow.y = 0;
			}
			if(event.keyCode == Keyboard.V){
				stage.nativeWindow.width = 500;
				stage.nativeWindow.height = 397;
				stage.nativeWindow.x = 0;
				stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height;
			}
			if(event.keyCode == Keyboard.N){
				stage.nativeWindow.width = 500;
				stage.nativeWindow.height = 397;
				stage.nativeWindow.x =  Screen.mainScreen.bounds.width - stage.nativeWindow.width;
				stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height;
			}
			if(event.keyCode == Keyboard.F){
				stage.nativeWindow.width = Capabilities.screenResolutionX;
				stage.nativeWindow.height = Capabilities.screenResolutionY;
				stage.nativeWindow.x = 0;
				stage.nativeWindow.y = 0;
				//stage.scaleMode = StageScaleMode.SHOW_ALL;
				//stage.align = StageAlign.TOP;
				
				//trace("X & Y :",Capabilities.screenResolutionX, Capabilities.screenResolutionY)
//				"stage.nativeWindow.width : ",stage.nativeWindow.bounds, Screen.mainScreen.bounds,
			}
			if(event.keyCode == Keyboard.M){
				stage.nativeWindow.width =  500;
				stage.nativeWindow.height = 397;
				stage.nativeWindow.x =  (Screen.mainScreen.bounds.width - stage.nativeWindow.width)/2;
				stage.nativeWindow.y = (Screen.mainScreen.bounds.height - stage.nativeWindow.height)/2;

			}
		}
		
		private function settingWebcam():void
		{	
			drawRect();
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
			Screen.mainScreen.visibleBounds.y = 22;
			Screen.mainScreen.visibleBounds.width = 1440;
			Screen.mainScreen.visibleBounds.height = _c.height;
			//addItem({data:1, Label:"Apple iSight});
		}
		
		private function drawRect():void
		{
			_bar = new Sprite;
			_bar.graphics.beginFill(0xff0000,5);
			_bar.graphics.drawRect(0,stage.stageHeight-10,stage.stageWidth,10);
			_bar.graphics.endFill();
			_bar.addEventListener(MouseEvent.CLICK, onBarClick);
		}
		
		private function onBarClick(event:MouseEvent):void
		{
			addSettings();
		}
		
		private function addSettings():void
		{
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
//			options.transparent = true;
			options.systemChrome = NativeWindowSystemChrome.STANDARD;
			options.type = NativeWindowType.NORMAL;
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
		
		protected function onStageClick(event:MouseEvent):void
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