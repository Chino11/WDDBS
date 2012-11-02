package com.dfp.view
{
	import com.dfp.model.BldgPointVO;
	import com.mapquest.LatLng;
	import com.mapquest.LatLngCollection;
	import com.mapquest.tilemap.Size;
	import com.mapquest.tilemap.TileMap;
	import com.mapquest.tilemap.controls.inputdevice.MouseWheelZoomControl;
	import com.mapquest.tilemap.controls.shadymeadow.SMLargeZoomControl;
	import com.mapquest.tilemap.controls.shadymeadow.SMViewControl;
	import com.mapquest.tilemap.overlays.ImageOverlay;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import libs.AppBase;
	import libs.FullSail;
	import libs.FullScreen;
	import libs.Popup;
	
	public class App extends AppBase
	{
		public static const MAP_KEY:String = "Fmjtd%7Cluuanu0bnd%2Crl%3Do5-96b5qf";
		
		private var _video:Loader;
		private var _videoBld:Loader;
		
		private var _player:Object;
		private var _playerBld:Object;
		
		private var _bldPoints:Array;
		private var _path:String;
		
		private var _tileMap:TileMap;
				
		private var _fsMap:FullSail;
		private var _bld:IOView;

		private var _videoCode:String;
		private var _autoplay:String;
		private var _color:String;
		private var _rel:String;

		private var _tooltip:Popup;
		private var _fullScreen:FullScreen;
		private var _map:MovieClip;

		private var _mapMoveX:Number=0;
		private var _mapMoveY:Number=0;
		private var _mapZoom:Object;
		
		public function App()
		{
			//Preparing some assets for future use
			_fsMap = new FullSail();
			_tooltip = new Popup();
			_fullScreen = new FullScreen;
			
////////////////////////////////////////////////////////////////////////////////////////////
//////////// MAP (Mapquest API) ///////////////////////////////////////////////////////////	
			
			_tileMap = new TileMap(MAP_KEY,16, new LatLng(28.59334,-81.303166));
			_tileMap.size = new Size(500, 425);
			//_tileMap.addControl(new MouseWheelZoomControl());
			_tileMap.addControl(new SMViewControl());
			_tileMap.addControl(new SMLargeZoomControl());
			_tileMap.zoomIn();
			_tileMap.zoomOut();
			viewMap.addChild(_tileMap);
			
////////////////////////////////////////////////////////////////////////////////////////////
/////////// VIDEO (Youtube API) ///////////////////////////////////////////////////////////	
			
			_videoCode = "4Rp-pJxXj6Y";
			_autoplay = "0";
			_color = "white";
			_rel = "0";
			var start:uint = 0;
			var end:uint = 10;
			
			_video = new Loader();
			_video.load(new URLRequest("http://www.youtube.com/v/"+_videoCode+"?version=3&autoplay="+_autoplay+"&color="+_color+"&rel="+_rel));
			_video.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			viewVideo.addChild(_video);
		}
		
		public function set voArray(value:Array):void
		{
			//Adding buildings to the map
			_bldPoints = value;
			var io:IOView = new IOView();
			for each(var b:BldgPointVO in _bldPoints){
				io = new IOView();
				var shapePts:LatLngCollection = new LatLngCollection();
				var latLng1:LatLng = new LatLng(b.Lat1, b.Lng1);
				var latLng2:LatLng = new LatLng(b.Lat2, b.Lng2);
				shapePts.add(latLng1);
				shapePts.add(latLng2);
				io.shapePoints = (shapePts);
				io.imageURL = b.imageURL;
				io.tooltip = b.title;
				io.path = b.mapPath;
				io.start = b.start;
				io.end = b.end;
				
				//Giving event listeners to each building
				io.addEventListener(MouseEvent.CLICK, onBldClick);
				io.addEventListener(MouseEvent.ROLL_OVER, onMapRollover);
				io.addEventListener(MouseEvent.ROLL_OUT, onMapRollout);
				
				_tileMap.addShape(io);
			}
		}

		private function onMapRollover(event:MouseEvent):void
		{
			//Setting up the tooltip
			var bld:IOView = IOView(event.currentTarget);
			
			_tooltip.tfTooltip.text = bld.tooltip;
			_tooltip.x = mouseX;
			_tooltip.y = mouseY;
			addChild(_tooltip)
		}
		
		private function onMapRollout(event:MouseEvent):void
		{	
			//removing tooltip
			if(this.contains(_tooltip)) removeChild(_tooltip);
		}
		
		private function onBldClick(event:MouseEvent):void
		{
			//If there is a map in the display, remove it
			if(viewDetail.numChildren > 2){
				viewDetail.removeChildAt(viewDetail.numChildren-1);
			}
			
			//Setting up to display the next map
			_bld = IOView(event.currentTarget);
			var path:String = _bld.path;
			
			_fsMap = new FullSail();
			_fsMap.gotoAndStop(1);
			
			_map = MovieClip(_fsMap.getChildByName(path));
			
			if(this.contains(_tooltip)) removeChild(_tooltip);

			if(_video.getChildAt(0)) (_video.getChildAt(0) as Object).stopVideo();

			viewVideo.removeChildren();

			buildThumbMap();
			
			//Preparing next video
			var start:String = _bld.start;
			var end:String = _bld.end;
			
			_videoBld = new Loader();
			_videoBld.load(new URLRequest("http://www.youtube.com/v/4Rp-pJxXj6Y?version=3&autoplay=0&color=white&rel=0&start="+start+"&end="+end));
			_videoBld.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInitBld);
			viewVideo.addChild(_videoBld);	
		}
		
		private function buildThumbMap():void
		{
			//adding next map
			_map.x = viewDetail.width / 2 + 75;
			_map.y = viewDetail.height / 2 + 50;
			_map.scaleX = _map.scaleY = .1;

			viewDetail.addEventListener(MouseEvent.CLICK, onBldDetailClick);
			viewDetail.addChild(_map);
		}
		
		private function onBldDetailClick(event:MouseEvent):void
		{
			//preparing fullscreen display
			_fullScreen.x = _fullScreen.y = 50;
			addChild(_fullScreen);
			
			_map.scaleX = _map.scaleY = .15;
			_fullScreen.viewFullScreen.addChild(_map);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_map.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			_map.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onBldKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onBldKeyUp);
			_map.addEventListener(Event.ENTER_FRAME, onEnterFrame);		
			
			_fullScreen.btnClose.buttonMode = true;
			_fullScreen.btnClose.mouseChildren = false;
			_fullScreen.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick);
		}
		
		private function onStopDrag(event:MouseEvent):void
		{
			//stop drag
			_map.stopDrag();
		}
		
		private function onDrag(event:MouseEvent):void
		{	
			//start drag
			_map.startDrag();
		}
		
		private function onCloseClick(event:MouseEvent):void
		{
			//when closing fullscreen
			while(_fullScreen.viewFullScreen.numChildren > 2){
				_fullScreen.viewFullScreen.removeChildAt(_fullScreen.viewFullScreen.numChildren-1)
			}
			removeChild(_fullScreen);
			buildThumbMap();
		}
		
		private function onEnterFrame(event:Event):void
		{
			//preparing zoom and moving with keyword keys
			_map.x -= _mapMoveX;
			_map.y -= _mapMoveY;
			_map.scaleX += _mapZoom;
			_map.scaleY += _mapZoom;
		}
		
		private function onBldKeyDown(event:KeyboardEvent):void
		{	
			//Controlling how much to zoom and move with keyboard keys
			if(event.keyCode == 37 || event.keyCode == 39) _mapMoveX = (event.keyCode - 38) * 10;
			if(event.keyCode == 38 || event.keyCode == 40) _mapMoveY = (event.keyCode - 39) * 10;
			if(event.keyCode == 187 || event.keyCode == 189) _mapZoom = (188 - event.keyCode) / 100;
		}
		
		private function onBldKeyUp(event:KeyboardEvent):void
		{
			//desactivating keyboard
			_mapMoveX = _mapMoveY = 0;
			_mapZoom = 0	
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////// Video Functions all the way down ////////////////////////////////////////////////////////////////////
		private function onLoaderInit(event:Event):void
		{	
			_video.content.addEventListener("onReady", onPlayerReady);
			_video.content.addEventListener("onError", onPlayerError);
			_video.content.addEventListener("onStateChange", onPlayerStateChange);
			_video.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
		
		private function onLoaderInitBld(event:Event):void
		{
			_videoBld.content.addEventListener("onReady", onPlayerBldReady);
			_videoBld.content.addEventListener("onError", onPlayerError);
			_videoBld.content.addEventListener("onStateChange", onPlayerStateChange);
			_videoBld.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
		
		private function onPlayerReady(event:Event):void
		{
			_player = _video.content;
			_player.setSize(640,390);
		}
		
		private function onPlayerBldReady(event:Event):void
		{
			_playerBld = _videoBld.content;
			_playerBld.setSize(640,390);
		}
		
		private function onPlayerError(event:Event):void
		{
			trace("player error:", Object(event).data);
		}
		
		private function onPlayerStateChange(event:Event):void
		{
			trace("player state:", Object(event).data);	
		}
		
		private function onVideoPlaybackQualityChange(event:Event):void
		{
			trace("video quality:", Object(event).data);
		}
	}
}