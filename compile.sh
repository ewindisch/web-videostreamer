#!/bin/bash
# Copyright 2007  Eric Windisch
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# 	http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#mtasc -header 320:240:30 -swf ImportCode.swf -main ImportCode.as
#mtasc -version 8 -cp /usr/share/mtasc/std8 -swf movie.swf -main -out ImportCode.swf -frame 1 ImportCode.as
swfmill simple upload.xml upload_res.swf
swfmill simple watch.xml watch_res.swf
mtasc -version 8 -cp /usr/share/mtasc/std8 -swf upload_res.swf -main -out upload.swf upload.as
mtasc -version 8 -cp /usr/share/mtasc/std8 -swf watch_res.swf -main -out watch.swf watch.as

mtasc -version 8 -cp /usr/share/mtasc/std8 -main -out upload2.swf upload2.as
