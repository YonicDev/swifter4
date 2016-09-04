package swifter.animator.events  {
	import flash.events.Event;
	public class DisplayEvent extends Event {
		
		public static const DISPLAY_OBJECT = "objectDisplayed";
		
		public static const DISPLAY_SET = "objectSetDisplayed";

		public function DisplayEvent(type:String, bubbles:Boolean=true,cancelable:Boolean=false):void {
			super(type,bubbles,cancelable);
		}

	}
	
}
