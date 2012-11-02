package com.dfp.controller
{
	import flash.events.Event;
	
	public class BuildingArrayEvent extends Event
	{
		public var voArray:Array;
		public static const ARRAY_BUILT:String = "arrayBuilt";
		
		public function BuildingArrayEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}