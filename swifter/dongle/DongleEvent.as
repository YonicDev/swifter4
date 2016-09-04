package swifter.dongle {
	import flash.events.Event;
	public class DongleEvent extends Event {
		public static const MEDIA_BRIDGE:String = "onMediaBridgeEstablished";
		public static const MEDIA_TRANSMIT:String = "onMediaTransmitElement";
		public static const MEDIA_TRANSMIT_END:String = "onMediaTransmitEnd";
		public static const MEDIA_UNBRIDGE:String = "onMediaBridgeDestroyRequest";
		public function DongleEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=true) {
			super(type,bubbles,cancelable);
		}

	}
	
}
