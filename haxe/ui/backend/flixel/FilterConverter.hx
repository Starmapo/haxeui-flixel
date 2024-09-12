package haxe.ui.backend.flixel;

import haxe.ui.filters.Filter;
import openfl.filters.BitmapFilter;
import haxe.ui.backend.flixel.filters.GrayscaleFilter;

class FilterConverter {
    public static function convertFilter(input:Filter):BitmapFilter {
        if (input == null) {
            return null;
        }
        var output:BitmapFilter = null;

        if ((input is haxe.ui.filters.Grayscale)) {
            var inputGrayscale:haxe.ui.filters.Grayscale = cast(input, haxe.ui.filters.Grayscale);
            output = new GrayscaleFilter(inputGrayscale.amount / 100).filter;
        }

        return output;
    }
}