package swifter.drift  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;

	public class Room extends MovieClip {
		public var b1:MovieClip;
		public var b2:MovieClip;
		
		public var left:Room;
		public var right:Room;
		public var up:Room;
		public var down:Room;
		public function Room() {
			if(b1!=null) {
				b1.addEventListener(MouseEvent.CLICK,goLeft);
				b1.buttonMode = true;
			}
			if(b2!=null) {
				b2.addEventListener(MouseEvent.CLICK,goRight);
				b2.buttonMode = true;
			}
		}
		private function goLeft(e:MouseEvent) {
			Main.warp(this,left,"left",new moveSound());
		}
		private function goRight(e:MouseEvent) {
			Main.warp(this,right,"right",new moveSound());
		}
	}
	
}
