package src.epilogue
{
    import flash.utils.ByteArray;
    import src.epilogue.scene.LanternCrossing;

    /** Plain AMF object in the same role slot as player inventory and rewards. */
    public class ChapterState
    {
        public static const SAVE_KEY:String = "fanChapterReturnLight";
        public static var value:Object = defaults();
        public static var unsupported:Boolean = false;
        public static var resumePending:Boolean = false;

        public static function defaults():Object
        {
            return {version:1,stage:0,inChapter:false,scene:"dock",bridgeOpen:false,
                beaconMirrorMask:-1,releaseMirrorMask:-1,
                crossingMoves:[],crossingDone:false,rescuedGroups:0,dockRelays:0,calibrationDone:false,navigationSteps:0,navigationTurns:[0,0,0],beaconPrepared:false,releasePrepared:false,
                boss1Defeated:false,boss2Defeated:false,ending:"",endingChoice:"",seenEndings:[],
                rewardClaims:{},seenDialogues:{},journal:[],endingNodes:0,
                homecomingSteps:0,homecomingHeading:0,
                elapsedSeconds:0,deaths:0,fixture:false};
        }
        public static function copy(source:Object):Object
        {
            var bytes:ByteArray=new ByteArray();bytes.writeObject(source);bytes.position=0;
            return bytes.readObject();
        }
        public static function restore(source:Object):void
        {
            unsupported=false;
            resumePending=false;
            if(!source){value=defaults();return;}
            if(int(source.version)>1){value=copy(source);unsupported=true;return;}
            value=defaults();
            // Explicit known fields only, retaining no references into another slot.
            for(var key:String in value) if(source.hasOwnProperty(key))value[key]=copy({v:source[key]}).v;
            value.version=1;
            value.rescuedGroups=Math.max(0,Math.min(2,int(value.rescuedGroups)));
            value.dockRelays=int(value.dockRelays)&3;
            value.navigationSteps=Math.max(0,Math.min(3,int(value.navigationSteps)));
            if(!(value.navigationTurns is Array) || value.navigationTurns.length!=3)value.navigationTurns=[0,0,0];
            else value.navigationTurns=[int(value.navigationTurns[0])&3,int(value.navigationTurns[1])&3,int(value.navigationTurns[2])&3];
            // Earlier v2 candidates had a single compass interaction; keep earned progress.
            if(value.calibrationDone){value.navigationSteps=3;value.navigationTurns=[3,2,1];}
            // Already calibrated on an earlier release: preserve its open route.
            if (!source.hasOwnProperty("crossingMoves") && value.calibrationDone) value.crossingDone = true;
            var crossing:LanternCrossing = new LanternCrossing(value.crossingMoves as Array);
            value.crossingMoves = crossing.moves;
            value.crossingDone = Boolean(value.crossingDone) || crossing.finished;
            value.endingNodes=Math.max(0,Math.min(3,int(value.endingNodes)));
            value.homecomingSteps=Math.max(0,Math.min(3,int(value.homecomingSteps)));
            value.homecomingHeading=int(value.homecomingHeading)&3;
            if(value.homecomingSteps>=2)value.homecomingHeading=3;
            if(["dock","warden","regent"].indexOf(value.scene)<0)value.scene="dock";
            if(!(value.seenEndings is Array))value.seenEndings=[];
            if(!(value.journal is Array))value.journal=[];
            if(!value.rewardClaims)value.rewardClaims={};
            if(!value.seenDialogues)value.seenDialogues={};
            resumePending=Boolean(value.inChapter);
        }
        /** Return-voyage actions never rewrite the earned ending or its reward. */
        public static function advanceHomecoming(action:String):Boolean
        {
            if(unsupported || value.ending!="release")return false;
            var step:int=int(value.homecomingSteps);
            if(action=="home_wick" && step==0)value.homecomingSteps=1;
            else if(action=="home_course" && step==1)
            {
                value.homecomingHeading=(int(value.homecomingHeading)+1)%4;
                if(value.homecomingHeading==3)value.homecomingSteps=2;
            }
            else if(action=="home_lantern" && step==2)value.homecomingSteps=3;
            else return false;
            return true;
        }
        public static function reset():void {restore(null);}
        public static function record(key:String):void
        { if(!unsupported && value.journal.indexOf(key)<0)value.journal.push(key); }
        public static function exported():Object {return copy(value);}
    }
}
