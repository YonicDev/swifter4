package swifter.drift {
	import flash.display.MovieClip;
	import flash.events.Event;
	import swifter.drift.Main;
	
	public class RoomContainer extends MovieClip {
		public function RoomContainer() {
			this.x=Main.MIDDLE_X;
			this.y=Main.MIDDLE_Y;
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void {
			stage.addChild(this);
		}
		public function addRoom(rm:Room,depth:Number=0) {
			this.addChildAt(rm,depth);
		}
	}
	
}
