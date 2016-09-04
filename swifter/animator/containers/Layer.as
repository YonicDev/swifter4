package swifter.animator.containers  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import swifter.animator.events.DisplayEvent;
	import swifter.core.errors.DisplayError;

	public class Layer extends Sprite {
		public var objects:Array = new Array();
		public function Layer() {
			
		}
		public function addElement(mc:MovieClip):void {
			objects.push(mc);
			this.addChild(mc);
			dispatchEvent(new DisplayEvent(DisplayEvent.DISPLAY_OBJECT));
		}
		public function addElementSet(...arguments):void {
			objects.push(arguments);
			arguments.forEach(displayObjects,stage);
			dispatchEvent(new DisplayEvent(DisplayEvent.DISPLAY_SET));
		}
		private function displayObjects(mc:MovieClip,index:int,arr:Array):void {
			try {
				if(mc==null) {
					throw new DisplayError("El objeto " + index + " es un elemento nulo.",1);
				} else {
					this.addChild(mc);
				}
			} catch (error:DisplayError) {
				trace(error.name + " " + error.errorID + ": " + error.message);
			}
			
		}
	}
	
}
