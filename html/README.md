# TL;DR

Options you must set: <br>
`start=` Slide in after loading site (ms)
`end=` Slide out after loading site (ms)
`day=` Day index. (0-3)
`track=` Track index. (0-N)
`room=` Room name (Fireshonks-Stream OR Fireshonks%20Workshop)

# Docu

Set start and end paramater in the url to set the delay when the slide show in and after which time it should slide out.

https://example.com/index.html?start=1000&end=5000000&day=1&track=5&room=Fireshonks%20Workshop
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

# Source Code - jQuery

Projects referencing this document are released under the terms of the [MIT license.](https://tldrlegal.com/license/mit-license)

The MIT License is simple and easy to understand and it places almost no restrictions on what you can do with the Project.

You are free to use the Project in any other project (even commercial projects) as long as the copyright header is left intact.

# Python Webserver
You can execute `python -m http.server 9999` in the folder where the index.html is located. This makes the belly band accessible under https://127.0.0.1:9999/index.html?start=1000&end=5000&day=2&track=3
