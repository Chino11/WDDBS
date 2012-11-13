package com.alyssanicoll.vo
{
	import flash.display.Screen;
	import flash.media.Camera;

	[RemoteClass(alias = "com.alyssanicoll.vo.SettingsVO")]
	public class SettingsVO
	{
		
		
		public var _webcams:Array = Camera.names;
		public var x:uint = 50;
		public var y:uint = 50;
		public var width:uint = resolutionX;
		public var height:uint = resolutionY;
		public var inFront:Boolean = false;
		public var resolutionX:uint = 320; 
		public var resolutionY:uint = 240;
		public var resolutionSelected:uint;
		public var defaultCamera:String;
		public var defaultCameraIndex:uint = 0;
		public var bottom:Number = Screen.mainScreen.visibleBounds.bottom;
		public var top:Number = Screen.mainScreen.visibleBounds.top;
		public var right:Number = Screen.mainScreen.visibleBounds.right;
		public var left:Number = Screen.mainScreen.visibleBounds.left;
		public function SettingsVO()
		{
		}
		
/*		
		var a:Array = resolution.split("x");
		a[0] //width
		a[1] //height
*/
	}
}