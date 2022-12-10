Set start and end paramater in the url to set the delay when the slide show in and after which time it should slide out.

https://example.com/index.html?start=1000&end=5000&day=2&track=3
This will slide the banner after one second into the screen and after five seconds out.
Please note, that the end time starts count at 0, so if you use `start=1000` and `end=5000` the slider will stand still for three seconds (1000ms for the start delay, ca 1100ms for the slide in and slide back at 5000ms). Also you need to set the `day=` `[0]`-`[4]` and the `track=` number of the day, also `[0]` - `[N]`, as in the example above.
