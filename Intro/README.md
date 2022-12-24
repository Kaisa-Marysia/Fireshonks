# TL;DR

Options you must set: <br>
`day=` Day index. (0-3) <br>
`track=` Track index. (0-N) <br>
`room=` Room name (Fireshonks-Stream OR Fireshonks%20Workshop) <br>

# Docu

Set the `day`,`track` and `room` parameter in the url to get the information (`Track` and `Person Name`) from Pretalx. <br>
**Example:** http://127.0.0.1:8000/index.html?day=2&track=5&room=Fireshonks-Stream

This will request the Track and Person Name from the offical Schedule Json file from the Pretalx Site and render a Intro. There is **no Fade out**, you must change yor Scene in OBS from the Intro Page to the talk.

