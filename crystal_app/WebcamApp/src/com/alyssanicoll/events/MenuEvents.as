package com.alyssanicoll.events{
	
	import flash.events.Event;
	
	public class MenuEvents extends Event{
		
		public static const REQUEST_TOP_LEFT:String = 'requestTopLeft';
		public static const REQUEST_BOTTOM_LEFT:String = 'requestBottomLeft';
		public static const REQUEST_TOP_RIGHT:String = 'requestTopRight';
		public static const REQUEST_BOTTOM_RIGHT:String = 'requestBottomRight';
		public static const REQUEST_CENTER:String = 'requestCenter';
		public static const REQUEST_FULL_SCREEN:String = 'requestFullScreen';
		public static const POSITION_CHANGE:String = 'positionChange';
		
		public static const REQUEST_RESOLUTION_CHANGE:String = 'requestResolutionChange';
		
		public var newPos:String;
		public var height:Number;
		public var width:Number;
		public var index:uint;
		
		public function MenuEvents(type:String, bubbles:Boolean=true, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
	}
}