package com.alyssanicoll.events{
	
	import flash.events.Event;
	
	public class MenuEvents extends Event{
		
		public static const REQUEST_TOP_LEFT:String = 'requestTopLeft';
		public static const REQUEST_BOTTOM_LEFT:String = 'requestBottomLeft';
		public static const REQUEST_TOP_RIGHT:String = 'requestTopRight';
		public static const REQUEST_BOTTOM_RIGHT:String = 'requestBottomRight';
		public static const REQUEST_CENTER:String = 'requestCenter';
		public static const REQUEST_FULL_SCREEN:String = 'requestFullScreen';
		
		public static const REQUEST_SMALL:String = 'requestSmall';
		public static const REQUEST_WIDE:String = 'requestWIDE';
		public static const REQUEST_FULLSCREEN:String = 'requestFullscreen';
		
		public function MenuEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
	}
}