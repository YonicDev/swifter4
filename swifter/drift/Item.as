package swifter.drift  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.geom.Point;
	import flash.events.Event;

	public class Item extends MovieClip {
		private var holding:Boolean;
		private var inv_x:Number;
		
		public var usable:Array;
		public function Item() {
			this.mc.mouseEnabled = false;
			this.tester.alpha = 0;
			this.tester.addEventListener(MouseEvent.CLICK,grabItem);
			this.addEventListener(Event.ADDED_TO_STAGE,init);
			holding = false;
		}
		private function init(e:Event):void {
			//TODO: Improve placement
			inv_x = (Main.inventory.length+1) * (this.width);
			this.x = inv_x;
		}
		public function grabItem(e:MouseEvent) {
			if(!holding) {
				Mouse.hide();
				this.startDrag(true);
			} else {
				Mouse.show();
				this.stopDrag();
				this.x = inv_x;
				this.y = 0;
				usable.forEach(testAllItems);
			}
			holding = !holding;
		}
		public function testAllItems(item:MovieClip, index:int, arr:Array) {
			if(this.hitTestObject(item)) {
				item.interactWith(item);
			}
		}
	}
	
}
