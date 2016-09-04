package swifter.core.module.racing.racers  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.Sprite;
	
	public class ModracerAI extends Modracer {

		public var angle_of_sight:Number = 90;
		public var line_of_sight:Sprite = new Sprite();
		public var sight_accuracy:int = 13;
		public var sight_length:int = 480;
		public var sight_steps:int = 15;
		public var turn_tolerance:int = 20;
		public var angle_step:Number;
		public var sight_point:Point;
		public var global_sight_point:Point;
		private var turns_left:int=0;
		
		public function ModracerAI() {
			rotation_step = 3;
			//addChild(line_of_sight);
			line_of_sight.graphics.lineStyle(1,0x000000);
			line_of_sight.graphics.lineTo(100,100);
			addEventListener(Event.ENTER_FRAME,on_enter_frame,false,1);
		}
		protected override function on_enter_frame(e:Event):void {
			angle_step = angle_of_sight*2/sight_accuracy;
			turns_left=0;
			colliding = false;
			line_of_sight.graphics.clear();
			line_of_sight.graphics.lineStyle(1,0x000000);
			if (speed<max_speed&&Math.abs(turns_left)<turn_tolerance*2) {
				speed+=acceleration;
			}
			if(Math.abs(speed)>max_speed) {
				speed*=speed_decay;
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
		
		public function drawLines(...mcs:Array) {
			mcs.forEach(traceSight,null);
		}
		
		public function traceSight(mc:MovieClip,ind:int,arr:Array) {
			for (var i:int=0; i<=sight_accuracy; i++) {
				for (var j:int=1; j<=sight_steps; j++) {
					line_of_sight.graphics.moveTo(0,-15);
					sight_point= new Point(sight_length/sight_steps*j*Math.cos((-90-angle_of_sight+angle_step*i)*0.0174532925),sight_length/sight_steps*j*Math.sin((-90-angle_of_sight+angle_step*i)*0.0174532925));
					global_sight_point=localToGlobal(sight_point);
					if (mc.hitTestPoint(global_sight_point.x,global_sight_point.y,true)) {
						// leaving the loop if the j-th segment of the i-th line of sight
						break;
					}
				}
				// if the line of sight is on the left, add the number of segments to turns_left variable
				if (i<sight_accuracy*0.5) {
					turns_left+=j;
				} else {
					// if the line of sight is on the right, add the number of segments to turns_left variable
					turns_left-=j;
				}
				line_of_sight.graphics.lineTo(sight_point.x,sight_point.y);
			}
		}
		protected override function evaluateCollisions(mc:MovieClip,i:int,arr:Array):void {
			if(mc.visible && mc.hitTestPoint(left.x,left.y,true)) {
				rotation+=rotation_step;
				speed*=0.95;
				colliding = true;
			}
			if(mc.visible && mc.hitTestPoint(right.x,right.y,true)) {
				rotation-=rotation_step;
				speed*=0.95;
				colliding = true;
			}
			if(mc.visible && mc.hitTestPoint(front.x,front.y,true)) {
				speed*=0.95;
				colliding = true;
			}
			if(mc.visible && mc.hitTestPoint(back.x,back.y,true)) {
				speed*=0.95;
				colliding = true;
			}
			if (! colliding) {
				// turn left or right according to tolerance and turns_left value if the car is not colliding with track boundaries
				if (Math.abs(turns_left)>turn_tolerance) {
					if (turns_left>0) {
						rotation -= rotation_step*(speed/max_speed);
					} else {
						rotation += rotation_step*(speed/max_speed);
					}
				}
			}
		}

	}
	
}
