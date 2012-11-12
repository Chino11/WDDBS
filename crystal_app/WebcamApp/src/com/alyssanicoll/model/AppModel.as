package com.alyssanicoll.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class AppModel extends EventDispatcher
	{
		private var _webcams:Array;
		private var _resolutions:Array = ["128 x 96","176 x 144","352 x 288","704 x 576","1408 x 1152"];
		
		public function AppModel(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}