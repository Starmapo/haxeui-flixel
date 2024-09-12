package haxe.ui.backend;

import flixel.graphics.frames.FlxFilterFrames;
import openfl.filters.BitmapFilter;
import flixel.graphics.frames.FlxImageFrame;
import flixel.math.FlxRect;
import haxe.ui.Toolkit;

class ImageDisplayImpl extends ImageBase {
    public var filters(default, set):Array<BitmapFilter>;

    var originalFrame:FlxImageFrame;
    var filteredFrame:FlxFilterFrames;

    public function new() {
        super();
        this.pixelPerfectRender = true;
        this.active = false;
    }
    
    private override function validateData():Void {
        if (_imageInfo != null) {
            originalFrame = FlxImageFrame.fromFrame(_imageInfo.data);
            updateFrames();
            
            aspectRatio = _imageInfo.width / _imageInfo.height;

            origin.set(0, 0);
        }
    }
    
    private override function validateDisplay() {
        var scaleX:Float = _imageWidth / (_imageInfo.width / Toolkit.scaleX);
        var scaleY:Float = _imageHeight / (_imageInfo.height / Toolkit.scaleY);
        scale.set(scaleX, scaleY);

        width = Math.abs(scaleX) * frameWidth;
        height = Math.abs(scaleY) * frameHeight;
    }

    function updateFrames():Void {
        if (filters != null && filters.length > 0) {
            frames = FlxFilterFrames.fromFrames(originalFrame, 0, 0, filters);
        } else {
            frames = originalFrame;
        }
    }

    override function set_clipRect(rect:FlxRect):FlxRect {
        if (rect != null) {
            return super.set_clipRect(FlxRect.get(rect.x / scale.x, rect.y / scale.y, rect.width / scale.x, rect.height / scale.y));
        } else {
            return super.set_clipRect(null);
        }
    }

    function set_filters(value:Array<BitmapFilter>):Array<BitmapFilter> {
        filters = value;
        updateFrames();
        return value;
    }
}
