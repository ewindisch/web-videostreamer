/* vim:set syntax=actionscript */
/*
Copyright 2007  Eric Windisch

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

class Main extends MovieClip
{
    public static function main()
    {
        var tF = _root.createTextField("myText", 1, 0, 0, 320, 20);
        tF.text = "Watching..";

        var display = _root.attachMovie("VideoDisplay", "display", _root.getNextHighestDepth());

        var my_nc:NetConnection = new NetConnection();
        my_nc.onStatus = function (info) {
                tF.text += info.code;
        };
        my_nc.onConnect = function(client)
        {
            trace("onConnect> " + client.ip);
            my_nc.acceptConnection(client);
        }

        my_nc.connect("rtmp://video.grokthis.net/oflaDemo");

        // Create a new source stream.
        var source_ns:NetStream = new NetStream(my_nc);
        source_ns.onStatus = function (info) {
                tF.text += ","+info.code;
        };

        /* Attach video */
        display.video.attachVideo(source_ns);

        _root.onEnterFrame = function () {
            //display.video.nextFrame();
        };

        source_ns.play("IronMan"); // or red5StreamDemo

        /* Scaling and rotation */
        display.video._y = 20;
        /* Try forcing playing? */
        display.video.gotoAndPlay(100);


    }
}
