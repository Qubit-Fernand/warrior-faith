package mx.core
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.PixelSnapping;

    /**
     * New project compatibility support for Flex-generated PNG Embed subclasses.
     * This minimal class is not claimed to be recovered original game source or
     * a complete Flex framework implementation. IFlexAsset is the existing empty
     * marker interface used by this project's recovered ByteArrayAsset.
     */
    public class BitmapAsset extends Bitmap implements IFlexAsset
    {
        public function BitmapAsset(bitmapData:BitmapData = null,
                                    pixelSnapping:String = PixelSnapping.AUTO,
                                    smoothing:Boolean = false)
        {
            super(bitmapData,pixelSnapping,smoothing);
        }
    }
}
