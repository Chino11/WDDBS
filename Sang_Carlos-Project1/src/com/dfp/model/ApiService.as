package com.dfp.model
{
	import com.dfp.controller.BuildingArrayEvent;
	import com.dfp.view.Preloader;
	import com.mapquest.LatLng;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import libs.FullSail;
	
	public class ApiService extends EventDispatcher
	{
		public var voArray:Array;
		public var buildings:Array = [];
		public var path:String;
		
		public function ApiService(target:IEventDispatcher=null)
		{
			super(target);
			//url to xml
			var url:String = "xml/bldngPoints.xml";
			
			//new URLRequest
			var uRequest:URLRequest = new URLRequest();
			uRequest.url = url;
			
			//new URLLoader
			var l:URLLoader = new URLLoader;
			l.addEventListener(Event.COMPLETE, onComplete);
			l.load(uRequest);
			
			//new FullSail (asset from flash);
			var fs:FullSail = new FullSail();
		}
		
		private function onComplete(event:Event):void
		{
			//Parsing xml
			var xmlData:XML = new XML(event.currentTarget.data);
			voArray = [];
			var i:int = 0;
			trace("These are the buildings: ", buildings);
			for each(var xml:XML in xmlData.shape){
				var bldVO:BldgPointVO = new BldgPointVO;
				bldVO.Lat1 = Number(xml.Lat1);
				bldVO.Lng1 = Number(xml.Lng1);
				bldVO.Lat2 = Number(xml.Lat2);
				bldVO.Lng2 = Number(xml.Lng2);
				bldVO.imageURL = xmlData.@path + xml.@file;
				bldVO.bldIndex = i;
				bldVO.mapPath = xml.mapPath;
				bldVO.title = xml.@title;
				bldVO.start = xml.start;
				bldVO.end = xml.end;
				
				voArray.push(bldVO);
				i++;
			}
			
			//Building an array event
			var e:BuildingArrayEvent = new BuildingArrayEvent(BuildingArrayEvent.ARRAY_BUILT);
			e.voArray = voArray;
			
			//dispatching event
			dispatchEvent(e);
		}
	}
}