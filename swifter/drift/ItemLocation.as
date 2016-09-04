package swifter.drift  {
	import flash.display.MovieClip
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class ItemLocation extends MovieClip {
		
		public var item:Item;
		
		private var friction:Number;

		public function ItemLocation() {
			this.addEventListener(MouseEvent.CLICK,find);
		}
		private function find(e:MouseEvent):void {
			//TODO: hideDescription();
			if(Main.inventory.length < Main.MAXIMUM_ITEMS)
				collectItem(item);
			else
				Main.inventoryFull();
		}
		public function collectItem(item:Item):void {
			Main.inventory.push(item);
			Main.inventoryContainer.addChild(item);
			item.gotoAndStop(0);
			item.addEventListener(Event.ENTER_FRAME,toInventory);
		}
		public function toInventory(e:Event) {
			if(friction <= 0.2)
				friction+=0.2;
		}
	}
	
}
