package
{
	import com.dfp.controller.BuildingArrayEvent;
	import com.dfp.model.ApiService;
	import com.dfp.model.BuildingVO;
	import com.dfp.view.App;
	import com.dfp.view.Preloader;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
		
	[SWF (width="1103", height="570")]
	
	public class Main extends Sprite
	{	
		private var _apiService:ApiService;

		private var _appView:App;

		private var _preloader:Preloader;
		
		public function Main()
		{	
			//Security
			Security.allowDomain("www.youtube.com");
			Security.loadPolicyFile("http://www.wddbs.com/crossdomain.xml");
			
			//Stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//functions
			apiService();
			preloader()
			contextMenuFunction();
			
		}
		
		private function apiService():void
		{
			//Setting up the API's
			_apiService = new ApiService();
			_apiService.addEventListener(BuildingArrayEvent.ARRAY_BUILT, onCompleted);
			_apiService.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_apiService.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function preloader():void
		{
			//Creating preloader
			_preloader = new Preloader;
			_preloader.x = stage.stageWidth*.5 - _preloader.width*.5;
			_preloader.y = stage.stageHeight*.5 - _preloader.height *.5;
			
			addChild(_preloader);
		}
		
		private function contextMenuFunction():void
		{
			//Creating copyright on right click menu which leads to my google plus profile
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			var mItem:ContextMenuItem = new ContextMenuItem("Copyright ©2012 Carlos Sang", true);
			mItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, copyrightClick);
			cm.customItems.push(mItem);
			this.contextMenu = cm;
		}
		
		private function copyrightClick(event:ContextMenuEvent):void
		{
			//Click function which leads to my google plus profile
			var urlRequest:URLRequest = new URLRequest("https://plus.google.com/u/0/100504784804225944202/posts");
			navigateToURL(urlRequest, "_blank");
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			//onProgress function for my preloader
			_preloader.percent = event.bytesLoaded/event.bytesTotal;
		}
		
		private function onError(event:Event):void
		{
			//Setting text in case of loading error
			var tf:TextField = new TextField();
			tf.text = "ERROR!! Please try again.";
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = stage.stageWidth*.5 - tf.width*.5;
			tf.y = stage.stageHeight*.5 - tf.height*.5;
			
			addChild(tf);
			removeChild(_preloader);
		}
		
		private function onCompleted(event:BuildingArrayEvent):void
		{
			//Setting appView's voArray equal to apiService voArray when info is parsed and removing preloader;
			removeChild(_preloader);
			
			_appView = new App();
			_appView.voArray = event.voArray;
			
			//Adding the appView to stage
			addChild(_appView);
		}
	}
}