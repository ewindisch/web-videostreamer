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

class Main
{
    static function main()
    {
        var nc:NetConnection;
        var ns:NetStream;

        var display = _root.attachMovie("VideoDisplay", "display", _root.getNextHighestDepth());

        _root.createTextField("txt",1,0,0,320,25);
        var txt:TextField = _root.txt;
        txt.setNewTextFormat(new TextFormat("Verdana",7));
        txt.htmlText = "Starting...\n";
        txt.wordWrap = true;

        nc= new NetConnection();        
        nc.onStatus = function(info) {
            txt.htmlText += "NetConnection " + info.code + " " info.level + "\n";
        }
        nc.connect("rtmp://video.grokthis.net/oflaDemo");
        
        ns = new NetStream(nc);
        ns.onStatus = function(info) {
            txt.htmlText += "NetStream " + info.code + "  " info.level + "\n";
        }

        var cam=Camera.get();
        ns.attachVideo(cam);
        ns.attachAudio(Microphone.get());
        ns.publish("red5StreamDemo","live");

        display.video.attachVideo(cam);
    }
}

