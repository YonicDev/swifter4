package swifter.core.module.racing.patches  {
	import swifter.core.module.racing.racers.Modracer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Patch extends MovieClip {
		var ti:Timer = new Timer(1000);
		public function Patch() {
		}
		
		public function activate(target:Modracer):void {
			visible = false;
			startTimer();
		}
		
		protected function startTimer():void {
			ti.start();
			ti.addEventListener(TimerEvent.TIMER,redraw);
		}
		
		protected function redraw(e:TimerEvent):void {
			ti.stop();
			visible = true;
		}

	}
	
}
