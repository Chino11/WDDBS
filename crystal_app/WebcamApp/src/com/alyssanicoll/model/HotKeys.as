package com.alyssanicoll.model
{
	import flash.display.Sprite;

	public class HotKeys extends Sprite
	{
		public function HotKeys()
		{
		}
		private function topLeft():void{
			this.x = 0;
			this.y = 0;
			this.width = stage.stageWidth / 2;
			this.height = stage.stageHeight / 2;
		}
		
		private function topRight():void{
			this.x = stage.stageWidth / 2;
			this.y = 0;
			this.width = stage.stageWidth / 2;
			this.height = stage.stageHeight / 2;
		}
		
		private function bottomLeft():void{
			this.x = 0;
			this.y = stage.stageHeight / 2;
			this.width = stage.stageWidth / 2;
			this.height = stage.stageHeight / 2;
		}
		
		private function bottomRight():void{
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;
			this.width = stage.stageWidth / 2;
			this.height = stage.stageHeight / 2;
		}
		
		private function fullScreen():void{
			this.x = 0;
			this.y = 0;
			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
		}
		
	}
}