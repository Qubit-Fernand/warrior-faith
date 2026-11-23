package src.epilogue.scene
{
    import flash.geom.Point;

    /** Two beams share the same five mirrors. Coordinates include a one-cell rim for the ports. */
    public class LightCircuit
    {
        public static const WIDTH:int = 6;
        public static const HEIGHT:int = 4;
        public var mirrors:Array;
        public var sources:Array;
        public var receivers:Array;
        public var mask:int;
        public var beacon:Boolean;

        public function LightCircuit(isBeacon:Boolean, saved:int = -1)
        {
            beacon = isBeacon;
            if (beacon)
            {
                mirrors = [new Point(2,0),new Point(5,2),new Point(2,2),new Point(4,3),new Point(5,3)];
                sources = [new Point(-1,2),new Point(4,4)];
                receivers = [new Point(6,0),new Point(6,2)];
            }
            else
            {
                mirrors = [new Point(5,3),new Point(0,0),new Point(0,2),new Point(3,2),new Point(5,2)];
                sources = [new Point(-1,0),new Point(6,2)];
                receivers = [new Point(3,-1),new Point(-1,3)];
            }
            mask = saved >= 0 && saved < 32 ? saved : (beacon ? 23 : 9);
        }

        public function rotate(index:int):void
        {
            if (index >= 0 && index < mirrors.length) mask ^= (1 << index);
        }

        public function traceBeam(index:int):Array
        {
            var origin:Point = sources[index];
            var ray:Array = [origin];
            var x:int = origin.x;
            var y:int = origin.y;
            var dx:int = x < 0 ? 1 : x == WIDTH ? -1 : 0;
            var dy:int = y == HEIGHT ? -1 : y < 0 ? 1 : 0;
            var visited:Object = {};
            while (true)
            {
                x += dx;
                y += dy;
                ray.push(new Point(x,y));
                if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) break;
                var key:String = [x,y,dx,dy].join(",");
                if (visited[key]) break;
                visited[key] = true;
                for (var i:int=0; i<mirrors.length; ++i)
                {
                    if (mirrors[i].x != x || mirrors[i].y != y) continue;
                    var sign:int = (mask & (1 << i)) != 0 ? 1 : -1;
                    var previous:int = dx;
                    dx = sign * dy;
                    dy = sign * previous;
                    break;
                }
            }
            return ray;
        }

        public function connected(index:int, ray:Array):Boolean
        {
            return Point(ray[ray.length-1]).equals(receivers[index]);
        }
    }
}
