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

class UploadCode extends MovieClip
{
    public static function main()
    {
        var tF = _root.createTextField("myText", 1, 0, 0, 320, 20);
        //tF.text = "EricTest Upload";

        var display = _root.attachMovie("VideoDisplay", "display", _root.getNextHighestDepth());
        var displayMirror = _root.attachMovie("VideoDisplayMirror", "displayMirror", _root.getNextHighestDepth());
        var displayReflect = _root.attachMovie("reflectGradi", "reflectGrad", _root.getNextHighestDepth());

        var cam = Camera.get();

        // For testing:
        //cam.setLoopback(true)

        /* Set Quality */
        cam.setMode(320,240,15);
        cam.setQuality(256,256);

        /* Attach video */
        display.video.attachVideo(cam);
        displayMirror.videoMirror.attachVideo(cam);

        /* Scaling and rotation */
        display.video._y = 20;
        display.video._xscale = -100;
        display.video._yscale = 100;
        display.video._x = cam.width;

        displayMirror.videoMirror._y = cam.height+75;
        displayMirror.videoMirror._x = cam.width;
        displayMirror.videoMirror._xscale = -100;
        displayMirror.videoMirror._yscale = -100;
        displayMirror.videoMirror._alpha = 100;

        /* Gradients and blending */
        //var gradient = new MovieClip();

        //displayReflect.reflectGrad.
        //_root.createEmptyMovieClip("reflectGrad",1);
        with ( _root.reflectGrad ) {
            fillType = "linear";
            colors = [0xFFFFFF, 0xFFFFFF];
            alphas = [30,100];
            ratios = [0,255];
            matrix = {matrixType:"box", x:0, y:cam.height, w:cam.width, h:75, r:90/180*Math.PI};
            //lineStyle(1, 0x000000, 100);
            beginGradientFill(fillType, colors, alphas, ratios, matrix);

            moveTo(0,cam.height);
            lineTo(0,cam.height+75);
            lineTo(cam.width,cam.height+75);
            lineTo(cam.width,cam.height);
            lineTo(0,cam.height);

            endFill();
        }

        var live_nc:NetConnection = new NetConnection();
        live_nc.onStatus = function (info) {
                tF.text = info.code;
        };
        live_nc.onConnect = function(client)
        {
            trace("onConnect> " + client.ip);
            live_nc.acceptConnection(client);
        }

        live_nc.connect("rtmp://video.grokthis.net/oflaDemo");

        var live_ns:NetStream = new NetStream(live_nc);
        live_ns.onStatus = function (info) {
                tF.text += ","+info.code;
        };

        /* Attach the camera activity to the source stream. This call causes a warning message to show which service is requesting access. It also gives the user the option of not sending the camera activity to the server. */
        live_ns.attachVideo(cam);

        /* Assuming the user named the stream 'webCamStream',
        publish the live camera activity as 'webCamStream'. */
        live_ns.publish("red5StreamDemo", "live");
    }
}
