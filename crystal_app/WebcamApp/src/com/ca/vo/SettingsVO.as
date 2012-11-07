package com.ca.vo
{
	[RemoteClass(alias = "com.ca.vo.SettingsVO")]
	public class SettingsVO
	{
		public var x:uint;
		public var y:uint;
		public var width:uint;
		public var height:uint;
		public var inFront:Boolean;
		public var resolution:String;
		public var defaultCamera:String;
		public function SettingsVO()
		{
		}
	}
}