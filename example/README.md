## 1.0.0

A Flutter package to get the time of a specific time zone or geo location.
It also includes an easy to use formatter for DateTime with customizable formatting.

<h1>Features</h1>
<p>1. Get current <strong>time</strong> from <strong>EZ Time Zone</strong></p>
<p>2. Get current time from Latitude and Longitude.</p>
<p>3. Format a <strong>Flutter DateTime object</strong> to a pretty <em>String formatted</em>text.</p>
<h2>Usage</h2>
<p>initiate the plugin</p>
<p><code>final _worldtimePlugin = Worldtime();</code></p><br>
<p>Get the time in Amsterdam.</p>
<p><code>final DateTime timeAmsterdam = await _worldtimePlugin.timeByCity('Europe/Amsterdam');
</code></p><br>
<p>Initiate the formatter.</p>
<p><code>String formatter = 'time - \\H:\\m, date - \\D/\\M/\\Y';</code></p><br>
<p>Put the value in a new variable.</p>
<p><code>final String result = _worldtimePlugin.format(dateTime: timeAmsterdam, 
formatter:myFormatter);</code></p><br>
<p>Print the variable.</p>
<p><code>print(result);</code></p><br><br>
<p>Amsterdam's coordinates are 52.3676° N, 4.9041° E => latitude: 52.3676, longitude: 4.9041</p>
<p>Get the time in Amsterdam's coordinates.</p>
<p><code>final DateTime timeAmsterdamGeo = await _worldtimePlugin.timeByLocation(latitude: 52.
3676, longitude: 4.9041);</code></p><br>
<p>We will use the same formatter. ('time - \\H:\\m, date - \\D/\\M/\\Y')</p>
<p>Put the value in a new variable.</p>
<p><code>final String resultGeo = _worldtimePlugin.format(dateTime: timeAmsterdam, 
formatter:myFormatter);</code></p><br>
<p>Print the variable.</p>
<p><code>print(resultGeo);</code></p><br><br>