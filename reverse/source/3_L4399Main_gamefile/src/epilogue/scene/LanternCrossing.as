package src.epilogue.scene
{
    /** Replay legal crossings from the near bank. A bit identifies one traveller. */
    public class LanternCrossing
    {
        public static const NAMES:Array = ["塔丽莎", "船工", "背灯的孩子", "抱着船锚的老人"];
        public static const COST:Array = [1, 2, 5, 10];
        public static const OIL:int = 18;
        public var farBank:int = 0;
        public var lampAcross:Boolean = false;
        public var oil:int = OIL;
        public var moves:Array = [];

        public function LanternCrossing(history:Array = null)
        {
            if (!history) return;
            for each (var raw:* in history)
            {
                if (!(raw is Number || raw is int || raw is uint) || Number(raw) != int(raw) || !cross(int(raw))) break;
            }
        }

        public function get available():int { return lampAcross ? farBank : 15 ^ farBank; }
        public function get finished():Boolean { return farBank == 15; }

        public function cost(mask:int):int
        {
            var people:int = 0;
            var slowest:int = 0;
            if (mask <= 0 || (mask & available) != mask || finished) return 0;
            for (var i:int = 0; i < 4; i++)
            {
                if ((mask & (1 << i)) == 0) continue;
                people++;
                slowest = Math.max(slowest, int(COST[i]));
            }
            return people <= 2 ? slowest : 0;
        }

        public function undo():void
        {
            if (!moves.length) return;
            var mask:int = moves.pop();
            farBank ^= mask;
            lampAcross = !lampAcross;
            oil += cost(mask);
        }

        public function cross(mask:int):Boolean
        {
            var spent:int = cost(mask);
            if (spent == 0 || spent > oil) return false;
            oil -= spent;
            farBank ^= mask;
            lampAcross = !lampAcross;
            moves.push(mask);
            return true;
        }
    }
}
