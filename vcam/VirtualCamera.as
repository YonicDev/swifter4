package swifter.vcam {
	import flash.display.MovieClip;
	import flash.geom.Transform;
	import flash.geom.Matrix;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class VirtualCamera extends MovieClip {
		
		private var cameraTrans:Transform;
		private var stageTrans:Transform;
		private static var currentCamera:VirtualCamera;
		public function VirtualCamera() {
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,resetStage);
		}
		
		private function init(e:Event):void {
			cameraTrans = new Transform(this);
			stageTrans = new Transform(parent);
			this.visible = false;
			activate();
		}
		
		private function updateStage(e:Event):void {
			parent.filters = this.filters;
			stageTrans.colorTransform = cameraTrans.colorTransform;
			var stageMatrix:Matrix = cameraTrans.matrix;
			stageMatrix.invert();
			stageMatrix.translate(stage.stageWidth*.5,stage.stageHeight*.5);
			stageTrans.matrix = stageMatrix;
		}
		private function resetStage(e:Event=null):void {
			stage.removeEventListener(Event.ENTER_FRAME, updateStage);
			stageTrans.matrix = new Matrix();
			stageTrans.colorTransform = new ColorTransform();
			parent.filters = new Array();
		}

		private function deactivate():void {
			stage.removeEventListener(Event.ENTER_FRAME,updateStage);
			resetStage();
			currentCamera = null;
		}
		private function activate():void {
			stage.addEventListener(Event.ENTER_FRAME,updateStage);
			currentCamera = this;
		}
		public static function switchTo(to:VirtualCamera) {
			currentCamera.deactivate();
			to.activate();
		}
	}
	
}
