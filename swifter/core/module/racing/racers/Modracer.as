package swifter.core.module.racing.racers {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import swifter.core.module.racing.patches.Patch;

	public class Modracer extends MovieClip {
		
		public var maxLife: Number = 170;
		// public var life:Number = maxLife; Vida omnidireccional
		/*Vida unidireccional*/
		public var lifeTop:Number = maxLife;
		public var lifeRight:Number = maxLife;
		public var lifeLeft:Number = maxLife;
		public var lifeBottom:Number = maxLife;
		public var lifeDelta:Number = 0.15;
		public var acceleration: Number = 0.4;
		public var speed_decay: Number = 0.96;
		public var rotation_step: Number = 4;
		public var max_speed: Number = 15;
		public var back_speed: Number = 1;
		public var speed: Number = 0;
		public var speed_x:Number;
		public var speed_y:Number;
		public var accelerate, brake, turn_left, turn_right, ghost: Boolean = false;
		public var front:Point;
		public var back:Point;
		public var left:Point;
		public var right:Point;
		protected var colliding:Boolean = false;
		public var lap:int = 1;
		public var racePosition:int = 0;
		public var cp:int = 0;
		public var hitLeft,hitRight,hitTop,hitBottom:Boolean = false;
		public function Modracer() {
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function init(e: Event): void {
			ghost = false;
			addEventListener(Event.ENTER_FRAME,on_enter_frame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,on_key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP,on_key_up)
		}
		public function deactivate():void {
			ghost = true;
			speed = speed_x = speed_y = 0;
			accelerate = brake = turn_left = turn_right = false;
			removeEventListener(Event.ENTER_FRAME,on_enter_frame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,on_key_down);
			stage.removeEventListener(KeyboardEvent.KEY_UP,on_key_up);
		}
		protected function on_enter_frame(e:Event):void {
			hitLeft = hitRight = hitTop = hitBottom = false;
			colliding = false;
			/*if(life<=0) {
				life=0;
			}*/
			if(lifeTop<=0) {
				lifeTop=0;
			}
			if(lifeBottom<=0) {
				lifeBottom=0;
			}
			if(lifeRight<=0) {
				lifeRight = 0;
			}
			if(lifeLeft<=0) {
				lifeLeft = 0;
			}
			if (accelerate && speed < max_speed) {
				speed += acceleration;
			}
			if (brake && speed > -1) {
				speed -= back_speed;
			}
			if(Math.abs(speed)>max_speed) {
				speed*=speed_decay;
			}
			if(!accelerate && Math.abs(speed)>0.2) {
				speed*=speed_decay;
			} else if (Math.abs(speed)<0.2) {
				speed = 0;
			}
			speed_x = Math.sin(rotation * 0.0174532925) * speed;
			speed_y = -Math.cos(rotation * 0.0174532925) * speed;
			if (turn_left) {
				rotation -= rotation_step * (speed / max_speed);
			}
			
			if (turn_right) {
				rotation += rotation_step * (speed / max_speed);
			}
				y += speed_y;
				x += speed_x;
				
				front = new Point(0,-60);
				back = new Point(0,60);
				left = new Point(-40,0);
				right = new Point(0,40);
				front = this.localToGlobal(front);
				back = this.localToGlobal(back);
				left = this.localToGlobal(left);
				right = this.localToGlobal(right);
		}
		
		public function checkCollisions(...mcs:Array) {
			mcs.forEach(evaluateCollisions);
		}
		public function checkPatches(...patches:Array) {
			patches.forEach(evaluatePatches);
		}
		
		protected function evaluatePatches(p:Patch,i:int,arr:Array):void {
			if(p.visible && p.hitTestObject(this)) {
				p.activate(this);
			}
		}
		
		public function establishRoute(...checkpoints) {
			checkpoints.forEach(evaluateCheckpoints);
		}
		
		protected function evaluateCheckpoints(mc:MovieClip,i:int,arr:Array):void {
			if(mc.hitTestPoint(back.x,back.y,true)) {
				this.cp = mc.number;
			}
		}
		
		protected function evaluateCollisions(mc:MovieClip,i:int,arr:Array):void {
			if(!ghost) {
				if(mc.visible && mc.hitTestPoint(left.x,left.y,true)) {
					rotation+=rotation_step+1;
					speed*=0.9;
					hitLeft = true;
				}
				if(mc.visible && mc.hitTestPoint(right.x,right.y,true)) {
					hitRight = true;
				}
				if(mc.visible && mc.hitTestPoint(front.x,front.y,true)) {
					rotation-=rotation_step+1;
					hitTop = true;
				}
				if(mc.visible && mc.hitTestPoint(back.x,back.y,true)) {
					hitBottom = true;
				}
			}
			if(hitLeft) {
				lifeLeft -= lifeDelta;
			} if(hitBottom) {
				lifeBottom -= lifeDelta;
			} if(hitTop) {
				lifeTop-= lifeDelta;
			} if(hitRight) {
				lifeRight -= lifeDelta;
			}
		}
		
		public function on_key_down(e: KeyboardEvent): void {
			if (e.keyCode == 38) {
				accelerate = true;
			}
			if (e.keyCode == 40) {
				brake = true;
			}
			if (e.keyCode == 37) {
				turn_left = true;
			}
			if (e.keyCode == 39) {
				turn_right = true;
			}
		}
		public function on_key_up(e: KeyboardEvent): void {
			if (e.keyCode == 38) {
				accelerate = false;
			}
			if (e.keyCode == 40) {
				brake = false;
			}
			if (e.keyCode == 37) {
				turn_left = false;
			}
			if (e.keyCode == 39) {
				turn_right = false;
			}
		}
	}

}