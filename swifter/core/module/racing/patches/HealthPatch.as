package swifter.core.module.racing.patches  {
	import swifter.core.module.racing.racers.Modracer;
	
	public class HealthPatch extends Patch {
		public var health:Number = 20;
		public function HealthPatch() {

		}
		public override function activate(target:Modracer):void {
			trace("Original: " + target.life);
			if(target.life + health <= target.maxLife) {
				target.life += health;
			} else {
				target.life = target.maxLife;
			}
			
			trace("Nuevo: "+ target.life);
			visible = false;
			startTimer();
		}
	}
	
}
