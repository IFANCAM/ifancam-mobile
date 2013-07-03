// Decompiled by AS3 Sorcerer 1.78
// http://www.as3sorcerer.com/

//com.webfreshener.core.utils.Base64Codec

package com.webfreshener.core.utils{
    import flash.utils.ByteArray;
    import mx.utils.Base64Encoder;
    import mx.utils.Base64Decoder;

    public class Base64Codec {

        public static function encodeObject(object:Object):String{
            var ba:ByteArray = new ByteArray();
            ba.writeObject(object);
            var b64:Base64Encoder = new Base64Encoder();
            b64.encodeBytes(ba, 0, ba.length);
            return (b64.drain());
        }
        public static function decodeObject(encoded:String):Object{
            var b64:Base64Decoder = new Base64Decoder();
            b64.decode(encoded);
            return (b64.toByteArray().readObject());
        }

    }
}//package com.webfreshener.core.utils

