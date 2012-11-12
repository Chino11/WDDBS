package com.alyssanicoll.vo
{
	[RemoteClass(alias = "com.ca.vo.SettingsVO")]
	public class SettingsVO
	{
		public var x:uint = 50;
		public var y:uint = 50;
		public var width:uint = 400;
		public var height:uint = 300;
		public var inFront:Boolean = false;
		public var resolution:String = "320 X 240";  // "320x240" might be a better choice.
		public var defaultCamera:String;
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