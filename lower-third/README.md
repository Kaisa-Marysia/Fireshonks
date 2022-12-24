# TL;DR

Options you must set: <br>
`start=` Slide in after loading site (ms) <br>
`end=` Slide out after loading site (ms) <br>
`day=` Day index. (0-3) <br>
`track=` Track index. (0-N) <br>
`room=` Room name (Fireshonks-Stream OR Fireshonks%20Workshop) <br>

# Docu
*(This part uses examples from index.html, but the same parts are on a other line in the QA.html)*

Set start and end paramater in the url to set the delay when the slide show in and after which time it should slide out.

https://127.0.0.1:8000/index.html?start=1000&end=5000&day=1&track=5&room=Fireshonks%20Workshop
This will slide the banner after one second into the screen and after five seconds out.
Please note, that the end time starts count at 0, so if you use `start=1000` and `end=5000` the slider will stand still for three seconds (1000ms for the start delay, ca 1100ms for the slide in and slide back at 5000ms). 
Also you need to set the `day=` `[0]`-`[4]` and the `track=` number of the day, also `[0]` - `[N]`, as in the example above.
With the `room=` you may set the room which should be parsed. You may select between `Fireshonks-Stream` and `Fireshonks%20Workshop`. (Yes there is a space in the Workshop Element). 

If you want to use a other json file for the lower third information, you must edit the source url at line `63` and `68`
```javascript
 62     [...]
 63     $.getJSON('https://pretalx.c3voc.de/fire-shonks-2022/schedule/export/schedule.json', function(data) {
 64
 65     var text = `${data.schedule.conference.days[params2.getAll('day')].rooms["Fireshonks-Stream"][params2.getAll('track')].title}`
 66
 67     $(".title").html(text);
 68     });
 69     [...]
 ```
 
 At line `64` and at line `68` are configured which key value you want to parse. 
 
 `schedule.conference.days[params2.getAll('day')].rooms["Fireshonks-Stream"][params2.getAll('track')].title`
 
 ```json
 {
   "schedule": {
     ...
     "conference": {
     "days": [0-N]
       {
         "rooms": {
           "Fireshonks-Stream": [
             {
             ...
             "title": "Value",
             "persons": [0-N]
               {
                 "public_name": "VALUE",
                 ...
               }
             }],
         }
       }
     }
   }
```
# Q&A
For the Q&A Big Blue Button or Jitis Links you need the `QA.html`. It's the same code and usages (parameter) but you must download the json file and serve it with a own webservr (Apache, NGINX, ...), because the json can't be parsed without to allow the `Access-Control-Allow-Origin`.
So please install and configure a local webserver for staic files and set `'Access-Control-Allow-Origin', '*'`. 
The webserver don't need root priviliges, because the port we use is `8000`.
Also you need to download the `.json` file from **Pretalx**. 

1. Navigate to [Schedule -> Export -> More exports](https://pretalx.c3voc.de/orga/event/fire-shonks-2022/schedule/export/)
2. Select *JSON (frab compatible)* 
3. Download the file and save it into the root data directory, where your `index.html` and `QA.html` are stored, and save it as `fs.json`.
4. Or seit it up as a cronjob `curl -H "Authorization: Token $TOKENID" https://pretalx.c3voc.de/fire-shonks-2022/schedule/export/schedule.json > fs.json` 
5. You should get a room information under: `https://127.0.0.1:8000/index.html?start=1000&end=5000&day=1&track=5&room=Fireshonks-Stream`

**Question**: Why should I use a token valid json export?
**Answer**: The Room information can't be requested from the public json file, because the extra key:value is only visible with a login. (It's Pretalx).

# Source Code - jQuery

Projects referencing this document are released under the terms of the [MIT license.](https://tldrlegal.com/license/mit-license)

The MIT License is simple and easy to understand and it places almost no restrictions on what you can do with the Project.

You are free to use the Project in any other project (even commercial projects) as long as the copyright header is left intact.

# Python Webserver
You can execute this script` in the folder where the `index.html` and `QA.html` is located. This makes the lower thirdaccessible under https://127.0.0.1:8000/index.html?start=1000&end=5000&day=2&track=3
This script is also already prepared with the `Access-Control-Allow-Origin` HEADER.

**WARNING**
Please don't run any webserer with the `Access-Control-Allow-Origin` on a Public IP and reachable from the internet without any other security credentials or firewall setup!

```python
#!/usr/bin/env python3
from http.server import HTTPServer, SimpleHTTPRequestHandler, test
import sys

class CORSRequestHandler (SimpleHTTPRequestHandler):
    def end_headers (self):
        self.send_header('Access-Control-Allow-Origin', '*')
        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    test(CORSRequestHandler, HTTPServer, port=int(sys.argv[1]) if len(sys.argv) > 1 else 8000)
```
