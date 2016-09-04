package swifter.core.module.racing.racers {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	public class Modracer extends MovieClip {
		public var acceleration: Number = 0.4;
		public var speed_decay: Number = 0.96;
		public var rotation_step: Number = 8;
		public var max_speed: Number = 25;
		public var back_speed: Number = 1;
		public var speed: Number = 0;
		public var speed_x:Number;
		public var speed_y:Number;
		public var accelerate, brake, turn_left, turn_right: Boolean = false;
		public function Modracer() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e: Event): void {
			addEventListener(Event.ENTER_FRAME,on_enter_frame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,on_key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP,on_key_up)
		}
		public function on_enter_frame(e:Event):void {
			if (accelerate && speed < max_speed) {
				speed += acceleration;
			}
			if (brake && speed > -1) {
				speed -= back_speed;
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