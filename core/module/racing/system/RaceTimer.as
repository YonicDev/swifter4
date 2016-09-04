package swifter.core.module.racing.system  {
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	public class RaceTimer {
		private static var timeElapsed:Number=0;
		private static var ms:Number;
		private static var s:Number;
		private static var min:Number;
		private static var ss:String;
		private static var mins:String;
		private static var d:String;
		public static function setTimes(timeText:TextField) {
			timeElapsed = getTimer();
			ms = timeElapsed;
			s = Math.floor(ms*0.001);
			min = Math.floor(s/60);
			mins = min.toString();
			ss = (s-min*60).toString();
			d = Math.round((ms-s*1000)).toString();
			
			if(int(mins) <10) {
				mins = "0"+mins;
			}
			if(int(ss)<10) {
				ss = "0"+ss;
			}
			if(int(d)<10) {
				d="0"+d;
			}
			
			timeText.text = mins+":"+ss+":"+d;
		}
		public static function stop() {
			timeElapsed = timeElapsed;
		}

	}
	
}
