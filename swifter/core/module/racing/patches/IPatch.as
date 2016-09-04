package swifter.core.module.racing.patches  {
	import swifter.core.module.racing.racers.Modracer;
	
	public interface IPatch {

		function activate(target:Modracer):void;
		function reDraw():void;

	}
	
}
