package swifter.core.module.racing.system  {
	import flash.events.EventDispatcher;
	
	public class RacePosition extends EventDispatcher {
		private var checkpoints:Array;
		private var racers:Array;
		public var positions:Array;
		public function RacePosition(...modracers) {
			racers = new Array(modracers);
			position = new Array();
		}
		public function checkPosition(...cpoints) {
			checkpoints = new Array(cpoints);
		}

	}
	
}
