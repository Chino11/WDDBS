package
{
	import com.ca.model.AppModel;
	import com.ca.view.Settings;
	
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.Sprite;
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
				stage.nativeWindow.x = 0;
				stage.nativeWindow.y = 0;
			}
			if(event.keyCode == Keyboard.R){
				stage.nativeWindow.x =  940;
				stage.nativeWindow.y = 0;
			}
			if(event.keyCode == Keyboard.V){
				stage.nativeWindow.x = 0;
				stage.nativeWindow.y = 450;
			}
			if(event.keyCode == Keyboard.N){
				stage.nativeWindow.x =  Screen.mainScreen.bounds.width - stage.nativeWindow.width;
				stage.nativeWindow.y = Screen.mainScreen.bounds.height - stage.nativeWindow.height;
			}
			if(event.keyCode == Keyboard.F){
				//stage.scaleMode = StageScaleMode.SHOW_ALL;
				//stage.align = StageAlign.TOP;
				
				trace("X & Y :",Capabilities.screenResolutionX, Capabilities.screenResolutionY)
//				"stage.nativeWindow.width : ",stage.nativeWindow.bounds, Screen.mainScreen.bounds,
			}
			if(event.keyCode == Keyboard.M){
				stage.nativeWindow.x =  471;
				stage.nativeWindow.y = 225;
			}
		}
		
		private function settingWebcam():void
		{	
			_video = new Video(stage.stageWidth, stage.stageHeight);
			_video.smoothing = true;
			addChild(_video);
			
			_c = Camera.getCamera();
			_c.setMode(stage.stageWidth, stage.stageHeight, 30);
			_video.attachCamera(_c);
			
			drawRect();
			
			//Screen.mainScreen.visibleBounds()
			Screen.mainScreen.visibleBounds.x = 0;
			Screen.mainScreen.visibleBounds.y = 22;
			Screen.mainScreen.visibleBounds.width = 1440;
			Screen.mainScreen.visibleBounds.height = _c.height;
			//addItem({data:1, Label:"Apple iSight});
		}
		
		private function drawRect():void
		{
			var bar:Sprite = new Sprite;
			bar.graphics.beginFill(0xff0000,5);
			bar.graphics.drawRect(0,stage.stageHeight,stage.stageWidth,10);
			bar.graphics.endFill();
			bar.addEventListener(MouseEvent.CLICK, onBarClick);
			addChild(bar);
		}
		
		private function onBarClick(event:MouseEvent):void
		{
			addSettings();
		}
		
		private function addSettings():void
		{
			_settings = new Settings();
			//_settings.width = _video.width;
			//_settings.height = _video.height / 2;
			_settings.y = _video.height - _settings.height;
			_settings.x = (_video.width - _settings.width) / 2;
			_settings.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			addChild(_settings);
		}
		
		private function onCloseClick(event:MouseEvent):void
		{
			removeChild(_settings);
		}
	}
}