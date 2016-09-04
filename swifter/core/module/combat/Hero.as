package swifter.core.module.combat {
	
	public final class Hero extends Actor {
		public var soul:Number;
		public var soulRate:Number;
		public function Hero(name:String,heartPoints:Number,specPoints:Number,attack:Number,defense:Number,specAttack:Number,specDefense:Number,speed:Number,lucky:Number,soulFill:Number,typePrim:String,typeSec:String=null,hybridation:Boolean=false) {
			super(name,heartPoints,specPoints,attack,defense,specAttack,specDefense,speed,lucky,typePrim,typeSec,hybridation);
			soulRate = soulFill;
		}
		public override function readOut():void {
			trace(actName + " is a " + type1 + "/" + type2 + "(hybrid = " + hybrid.toString() + ") hero.");
			trace(actName + " will defend with " + defType);
			trace("ATTACK: " + atk + ", DEFENSE: " + def);
			trace("SPECIAL ATTACK: " + sat + ", SPECIAL DEFENSE: " + sdf);
			trace("SPEED: " + sat + ", LUCKY INDEX: " + luk);
			trace("SOUL FILL RATE: " + soulRate);
		}

	}
	
}
