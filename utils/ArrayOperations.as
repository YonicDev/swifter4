package swifter.utils {
	import flash.utils.ByteArray;
	public final class ArrayOperations {

		public static function clone(source: Object):* {
			var myBA: ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return (myBA.readObject());
		}

	}

}