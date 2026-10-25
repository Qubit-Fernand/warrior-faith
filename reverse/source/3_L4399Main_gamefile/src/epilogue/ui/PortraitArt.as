package src.epilogue.ui
{
    import flash.display.Graphics;
    import flash.display.GradientType;
    import flash.geom.Matrix;
    import flash.display.Sprite;

    /** New stylized vector portraits for this fan chapter, not recovered original art. */
    public class PortraitArt extends Sprite
    {
        public function PortraitArt(identity:String = "hero", size:Number = 112)
        {
            super();
            mouseEnabled = false;
            mouseChildren = false;
            draw(identity);
            scaleX = scaleY = size / 112;
        }

        public function setIdentity(identity:String):void
        {
            graphics.clear();
            draw(identity);
        }

        private function polygon(g:Graphics, color:uint, points:Array, alpha:Number = 1):void
        {
            g.beginFill(color, alpha);
            g.moveTo(points[0], points[1]);
            for(var i:int = 2; i < points.length; i += 2) g.lineTo(points[i], points[i + 1]);
            g.lineTo(points[0], points[1]);
            g.endFill();
        }

        private function shade(g:Graphics, top:uint, bottom:uint, x:Number, y:Number, w:Number, h:Number):void
        {
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(w, h, Math.PI / 2, x, y);
            g.beginGradientFill(GradientType.LINEAR, [top, bottom], [1, 1], [0, 255], matrix);
        }

        private function softPolygon(g:Graphics, top:uint, bottom:uint, points:Array):void
        {
            shade(g, top, bottom, 20, 15, 72, 100);
            g.moveTo(points[0], points[1]);
            for(var i:int = 2; i < points.length; i += 2)g.lineTo(points[i], points[i + 1]);
            g.lineTo(points[0], points[1]);g.endFill();
        }

        private function eye(g:Graphics, x:Number, y:Number, iris:uint, narrow:Boolean):void
        {
            var h:Number = narrow ? 7 : 11;
            g.lineStyle(1.1, 0x293944);
            g.beginFill(0xFFF9ED);
            g.moveTo(x, y + 2); g.curveTo(x + 6, y - 2, x + 13, y + 1);
            g.curveTo(x + 12, y + h, x + 6, y + h);
            g.curveTo(x + 1, y + h, x, y + 2); g.endFill();
            g.lineStyle();
            shade(g, iris, 0x1C3945, x + 4, y + 1, 7, h - 1);
            g.drawEllipse(x + 4, y + 1, 7, h - 1); g.endFill();
            g.beginFill(0x102831); g.drawEllipse(x + 6, y + 2, 3, h - 3); g.endFill();
            g.beginFill(0xFFFFFF, .96); g.drawCircle(x + 6, y + 2, 1.6); g.endFill();
            g.beginFill(0xFFFFFF, .5); g.drawCircle(x + 9, y + h - 2, .8); g.endFill();
            g.lineStyle(1.5, 0x27313E); g.moveTo(x - 1, y + 1);
            g.curveTo(x + 6, y - 2, x + 13, y + 1); g.lineStyle();
        }

        private function draw(identity:String):void
        {
            var id:String = identity ? identity.toLowerCase() : "hero";
            var goddess:Boolean = id.indexOf("格蕾") >= 0 || id == "goddess" || id == "grace";
            var scout:Boolean = id.indexOf("塔丽") >= 0 || id == "talisa" || id == "talisha" || id == "scout";
            var king:Boolean = id.indexOf("霍根") >= 0 || id == "hogan" || id == "hogen" || id == "regent";
            var healer:Boolean = id.indexOf("妮蒂") >= 0 || id == "healer";
            var witness:Boolean = id.indexOf("居民") >= 0 || id == "witness" || id == "villager";
            var mentor:Boolean = id.indexOf("奥古斯") >= 0 || id == "augustine" || id == "mentor";
            var hero:Boolean = !goddess && !scout && !king && !healer && !witness && !mentor;
            var g:Graphics = graphics;
            var field:uint = mentor ? 0x344453 : goddess ? 0x314E58 : scout ? 0x273E53 : king ? 0x392C48 : healer ? 0x355447 : 0x364252;
            var hair:uint = mentor ? 0xC8B8E4 : goddess ? 0xD3B879 : scout ? 0x6E3C2B : king ? 0x6B6674 : healer ? 0x574132 : witness ? 0x443328 : 0x119BAF;
            var skin:uint = mentor ? 0xE6B18F : king ? 0xC4B9A5 : scout ? 0xD5A584 : goddess ? 0xEAD5B6 : 0xDCB595;
            var cloth:uint = mentor ? 0x557789 : goddess ? 0x97BFC2 : scout ? 0x375B73 : king ? 0x3E314F : healer ? 0x80977A : witness ? 0x947754 : 0x6E7A83;
            g.lineStyle(2, 0xC2A16A);
            shade(g, field, 0x142934, 1, 1, 110, 130);
            g.drawRoundRect(1, 1, 110, 130, 20, 20);
            g.endFill();
            // The constellated field keeps each portrait readable at a small scale.
            g.lineStyle(1, 0xE5CC8F, .16);
            g.drawCircle(56, 48, 37);
            g.moveTo(56, 8); g.lineTo(56, 88);
            g.moveTo(18, 48); g.lineTo(94, 48);
            if(goddess) {
                g.lineStyle(2, 0xF2DC9F, .8); g.drawCircle(56, 40, 31);
                g.lineStyle();
                polygon(g, hair, [34,38,28,95,39,116,77,116,84,92,78,35]);
            }
            // Neck and shoulders.
            g.lineStyle();
            shade(g, 0xAE7963, skin, 47, 70, 19, 26); g.drawRoundRect(47, 70, 19, 26, 8, 8); g.endFill();
            polygon(g, cloth, [17,129,24,99,43,86,56,96,70,86,90,99,99,129]);
            if(mentor) {
                // Armor and the green greatsword are identifying cues from the observed NPC.
                polygon(g,0x263B50,[19,129,24,95,39,83,56,96,73,84,91,98,98,129]);
                polygon(g,0xC6D8DF,[24,98,39,84,47,96,39,112,22,113]);
                polygon(g,0x93B7C9,[71,85,90,99,96,115,75,112,64,97]);
                polygon(g,0x577D93,[42,97,55,104,69,96,74,128,39,128]);
                g.lineStyle(1.5,0xD4E4E4);g.moveTo(43,108);g.lineTo(70,108);g.moveTo(42,116);g.lineTo(71,116);g.lineStyle();
                g.beginFill(0xB35BC8);g.drawCircle(54,97,5);g.endFill();
            } else if(king) {
                polygon(g, 0x29243A, [14,130,22,83,38,71,46,91,56,105,68,88,77,70,94,87,102,130]);
                polygon(g, 0xA58A4E, [22,88,40,81,49,98,32,109]);
                polygon(g, 0xA58A4E, [72,82,91,90,80,109,63,98]);
            } else if(scout) {
                polygon(g, 0xA77B48, [28,94,35,89,86,126,78,130]);
                polygon(g, 0x213D55, [30,94,39,86,57,100,78,88,85,99,66,111,43,109]);
            } else if(goddess) {
                polygon(g, 0xE4D8B5, [35,89,47,86,56,101,67,86,78,91,64,121,48,121]);
                g.beginFill(0xD3AB51); g.drawCircle(56, 106, 5); g.endFill();
            } else {
                polygon(g, 0xB8B6A6, [27,102,39,89,49,99,40,111]);
                polygon(g, 0xB8B6A6, [85,102,72,89,63,99,73,111]);
                g.lineStyle(2, 0xD4C197); g.moveTo(55,102); g.lineTo(55,130); g.lineStyle();
            }
            // Distinct silhouettes, not merely tint variants.
            if(mentor) {
                polygon(g,0x8A76B0,[31,30,25,59,30,98,43,117,47,83,70,80,77,124,96,129,86,89,85,42,72,22]);
                polygon(g,hair,[31,29,27,54,33,84,41,94,41,58,71,41,76,87,85,111,83,63,80,31,65,19]);
            }
            else if(king) polygon(g, hair, [32,31,28,57,35,81,42,89,48,79,66,79,75,89,81,62,78,31]);
            else if(scout) polygon(g, hair, [31,26,24,51,26,82,37,98,43,73,76,81,89,97,83,52,76,26]);
            else if(hero) polygon(g, 0x17566F, [25,43,27,23,42,14,63,12,82,23,89,42,83,68,75,80,35,80,26,68]);
            else if(!goddess) polygon(g, hair, [29,37,34,23,52,16,72,24,81,39,77,70,36,71]);
            // Small-size readable chibi proportions: individual cheeks and jaw silhouettes.
            var left:Number = hero ? 29 : witness ? 31 : king ? 34 : goddess ? 35 : scout ? 31 : 33;
            var right:Number = hero ? 83 : witness ? 81 : king ? 80 : goddess ? 77 : scout ? 81 : 79;
            var chin:Number = goddess ? 86 : king ? 88 : mentor ? 85 : 83;
            g.lineStyle(.8, 0x805F54, .8);
            shade(g, 0xFFF0D7, skin, left, 31, right-left, chin-31);
            g.moveTo(left + 4, 35); g.curveTo(56, 21, right - 4, 35);
            g.curveTo(right + 3, 48, right, 64);
            if(king) {g.lineTo(75,80);g.lineTo(63,chin);g.lineTo(49,chin-1);g.lineTo(37,79);g.lineTo(left,64);}
            else {g.curveTo(right - 1, 77, 57, chin);g.curveTo(left + 1, 78, left, 64);}
            g.curveTo(left - 3, 48, left + 4, 35); g.endFill(); g.lineStyle();
            g.beginFill(0xDC947D, .18); g.drawEllipse(left + 3, 66, 11, 5); g.drawEllipse(right - 13, 66, 10, 5); g.endFill();
            // A restrained reflected edge gives volume without hard polygon cheeks.
            g.lineStyle(1, 0xFFF4DB, .6); g.moveTo(left + 3, 57);
            g.curveTo(left + 2, 72, 45, 77); g.lineStyle();
            if(mentor) {
                // Original identity cues, interpreted as a new vector medallion.
                softPolygon(g,0xE1D6F1,0x8F78AF,[29,47,29,29,43,17,60,14,76,22,84,38,81,59,73,48,69,31,59,26,48,35,42,55,34,62]);
                polygon(g,0xEEE7FA,[31,36,37,24,55,19,67,22,52,24,41,38,38,51]);
                polygon(g,0xA998CF,[70,29,78,36,81,55,74,48,71,37,61,27]);
                // Dark forehead ornament with a violet gem, rather than a beard.
                polygon(g,0x273748,[46,31,54,35,60,33,68,31,71,41,63,48,57,53,51,45,44,42]);
                polygon(g,0xACC3D5,[46,34,52,38,51,43,46,40]);
                polygon(g,0xADCADA,[65,35,69,34,68,41,62,44,58,50,56,44]);
                g.lineStyle(1,0x562C6E);g.beginFill(0xB945CD);g.drawEllipse(53,33,10,12);g.endFill();g.lineStyle();
                g.beginFill(0xE5A2EE);g.drawCircle(56,36,2);g.endFill();
                // Cropped sword at the medallion edge keeps the face unobstructed.
                polygon(g,0xD4E5DF,[10,71,26,71,26,124,18,129,10,124]);
                polygon(g,0x4CB429,[14,75,22,75,22,121,18,125,14,121]);
                g.beginFill(0xADEE56);g.drawEllipse(16,83,4,7);g.drawEllipse(16,101,4,7);g.endFill();
                polygon(g,0xC7A74E,[6,67,30,67,27,73,9,73]);
                g.lineStyle(5,0x73552F);g.moveTo(18,55);g.lineTo(18,66);g.lineStyle();
            } else if(goddess) {
                softPolygon(g, 0xF6DFA2, 0xA78248, [31,44,33,25,51,18,72,22,80,39,71,34,57,27,45,39,42,31]);
                g.lineStyle(2, 0xF8E6B0); g.moveTo(35,34); g.lineTo(56,26); g.lineTo(76,34); g.lineStyle();
                polygon(g, 0xD2F6E4, [56,21,60,27,56,33,52,27]);
            } else if(scout) {
                softPolygon(g, 0xA86F46, 0x50312E, [29,44,33,26,56,20,77,31,82,48,70,40,61,31,49,43,45,32,37,48]);
                polygon(g, 0xA9C2BD, [24,27,38,20,57,18,76,25,84,39,70,31,48,27,31,38]);
                g.lineStyle(2,0xD2AF63); g.moveTo(28,28); g.lineTo(57,22); g.lineTo(79,31); g.lineStyle();
            } else if(king) {
                polygon(g, 0xAEA793, [35,28,42,20,56,22,71,20,77,32,69,38,57,31,42,37]);
                softPolygon(g, 0xE8D195, 0x8F703C, [32,31,28,15,42,23,55,9,68,23,83,15,78,33]);
                polygon(g, 0x6EA5A3, [56,16,61,24,56,30,51,24]);
                polygon(g, hair, [39,72,47,77,57,74,66,78,73,70,67,87,56,95,43,85]);
            } else if(hero) {
                g.lineStyle(1, 0x173D53);
                shade(g, 0x40D4D7, 0x08758F, 25, 15, 64, 50);
                g.moveTo(25,47); g.curveTo(21,25,43,16); g.curveTo(65,7,83,26);
                g.lineTo(89,40); g.lineTo(81,37); g.lineTo(83,57); g.lineTo(73,48);
                g.lineTo(68,35); g.lineTo(60,51); g.lineTo(55,37); g.lineTo(45,59);
                g.lineTo(42,39); g.lineTo(32,58); g.lineTo(32,43); g.lineTo(25,54);
                g.lineTo(25,47); g.endFill();
                polygon(g,0x8EEBED,[31,30,43,21,58,17,70,21,60,22,63,26,49,24,40,31,42,25]);
                g.lineStyle(1,0xA2E9E7,.65);g.moveTo(36,36);g.curveTo(42,26,50,27);
                g.moveTo(66,28);g.curveTo(74,32,77,42);g.lineStyle();
            } else {
                polygon(g, hair, [30,43,34,24,48,16,66,17,79,33,79,45,67,34,59,42,51,31,42,41,39,31]);
                if(healer) {g.lineStyle(4,0xB6D1A9);g.moveTo(32,29);g.lineTo(75,29);g.lineStyle();}
                if(witness) {g.lineStyle(2,0xB88964);g.moveTo(65,49);g.lineTo(71,60);g.lineStyle();}
            }
            var iris:uint = hero ? 0x42C6B6 : mentor ? 0xBA6BC8 : goddess ? 0x7DCEC6 : scout ? 0xC69962 : king ? 0xA89B70 : 0x8A9E88;
            eye(g, hero ? 36 : 37, king ? 55 : 54, iris, king || witness);
            eye(g, hero ? 64 : 62, king ? 55 : 54, iris, king || witness);
            g.lineStyle(1.2, king ? 0x52474C : 0x66504A, .85);
            g.moveTo(38,50); g.curveTo(44,king?49:47,49,51);
            g.moveTo(63,51); g.curveTo(69,king?49:47,75,50);
            g.lineStyle(1, 0xAE7F69, .75);
            g.moveTo(56,64); g.lineTo(54,68); g.lineTo(57,68);
            g.lineStyle(1.1, 0x8B6258);
            g.moveTo(hero?50:51,75); g.curveTo(57,king?74:78,64,74); g.lineStyle();
            g.beginFill(0xFFF0DC,.55); g.drawEllipse(54,79,6,1.5); g.endFill();
            if(goddess || scout || mentor) {
                g.lineStyle(.8, goddess ? 0xF7E3AD : scout ? 0xB78259 : 0xF2E9FF, .65);
                g.moveTo(goddess?32:30,48);g.curveTo(28,68,36,goddess?105:83);
                g.moveTo(80,48);g.curveTo(84,68,81,92);g.lineStyle();
            }
            // Sewn/engraved edges distinguish clothing without adding fictional insignia.
            g.lineStyle(.8,0xE1D5B7,.52);
            if(goddess) {g.moveTo(39,92);g.curveTo(43,110,50,119);g.moveTo(73,92);g.curveTo(70,110,63,119);}
            else if(scout) {g.moveTo(31,96);g.lineTo(78,127);g.moveTo(36,91);g.lineTo(84,124);}
            else if(king) {g.moveTo(22,91);g.lineTo(32,105);g.lineTo(45,98);g.moveTo(69,98);g.lineTo(80,105);g.lineTo(91,91);}
            else {g.moveTo(28,104);g.lineTo(39,94);g.lineTo(45,100);g.moveTo(68,100);g.lineTo(73,94);g.lineTo(84,104);}
            g.lineStyle();
            g.lineStyle(1,0xF6E0A7,.7);g.drawRoundRect(5,5,102,122,16,16);
            g.lineStyle();
        }
    }
}
