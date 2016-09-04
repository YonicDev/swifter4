package swifter.core.module.racing.racers  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class ModracerAI extends Modracer {

		public function ModracerAI() {
			super();
		}
		public override function init(e:Event):void {
			trace("CPUInit");
			addEventListener(Event.ENTER_FRAME,on_enter_frame);
		}
		public override function on_enter_frame(e:Event):void {
			if (speed < max_speed) {
				speed += acceleration;
			}
			if(Math.abs(speed)>max_speed) {
				speed*=speed_decay;
			}
			if(!accelerate && Math.abs(speed)>0.2) {
				speed*=speed_decay;
			} else if (Math.abs(speed)<0.2) {
				speed = 0;
			}
			var speed_x:Number=Math.sin(rotation*0.0174532925)*speed;
			var speed_y:Number=- Math.cos(rotation*0.0174532925)*speed;
			y+=speed_y;
			x+=speed_x;
			
			front = new Point(0,-60);
				back = new Point(0,60);
				left = new Point(-40,0);
				right = new Point(0,40);
				front = this.localToGlobal(front);
				back = this.localToGlobal(back);
				left = this.localToGlobal(left);
				right = this.localToGlobal(right);
		}
		public override function correctPosition(p:Point) {
			if(p===left) {
				rotation+=rotation_step+2;
				speed*=0.75;
			} if (p===right) {
				rotation-=rotation_step+2;
				speed*=0.75;
			} if (p===front||p===back) {
				speed*=0.75;
			}
		}

	}
	
}
