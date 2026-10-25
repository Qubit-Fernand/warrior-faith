package src.epilogue
{
    import flash.utils.ByteArray;

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
                rescuedGroups:0,dockRelays:0,calibrationDone:false,navigationSteps:0,navigationTurns:[0,0,0],beaconPrepared:false,releasePrepared:false,
                boss1Defeated:false,boss2Defeated:false,ending:"",endingChoice:"",seenEndings:[],
                rewardClaims:{},seenDialogues:{},journal:[],endingNodes:0,
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
            value.endingNodes=Math.max(0,Math.min(3,int(value.endingNodes)));
            if(["dock","warden","regent"].indexOf(value.scene)<0)value.scene="dock";
            if(!(value.seenEndings is Array))value.seenEndings=[];
            if(!(value.journal is Array))value.journal=[];
            if(!value.rewardClaims)value.rewardClaims={};
            if(!value.seenDialogues)value.seenDialogues={};
            resumePending=Boolean(value.inChapter);
        }
        public static function reset():void {restore(null);}
        public static function record(key:String):void
        { if(value.journal.indexOf(key)<0)value.journal.push(key); }
        public static function exported():Object {return copy(value);}
    }
}
