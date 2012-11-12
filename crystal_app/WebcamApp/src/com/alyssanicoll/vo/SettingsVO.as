package com.alyssanicoll.vo
{
	import flash.media.Camera;

	[RemoteClass(alias = "com.ca.vo.SettingsVO")]
	public class SettingsVO
	{
		
		
		public var _webcams:Array = Camera.names;
		public var x:uint = 50; // how do we grab the last place that the window was
		public var y:uint = 50;
		public var width:uint = resolutionX;
		public var height:uint = resolutionY;
		public var inFront:Boolean = false;
		public var resolutionX:uint = 320; 
		public var resolutionY:uint = 240;
		public var defaultCamera:String = _webcams[0];
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