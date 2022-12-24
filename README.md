## 1.0.2

A Flutter package to get the time of a specific time zone or geo location.  
It also includes an easy to use formatter for DateTime with customizable formatting.

<h1>Features</h1>  
<p>1. Get current <strong>time</strong> from <strong>EZ Time Zone</strong></p>  
<p>2. Get current time from <strong>Latitude</strong> and <strong>Longitude</strong>.</p>  
<p>3. Format a <strong>Flutter DateTime object</strong> to a pretty <em>String formatted</em> text.</p>  
<h1>Short example code</h1>  
<p><code>  
import 'package:worldtime/worldtime.dart';  <br>
final _worldtimePlugin = Worldtime();  <br>
final String myFormatter = 'time - \\H:\\m, date - \\D/\\M/\\Y';  <br>
final DateTime timeAmsterdamTZ = await _worldtimePlugin.timeByCity('Europe/Amsterdam');  <br>
final DateTime timeAmsterdamGeo = await _worldtimePlugin.timeByLocation(latitude: 52.3676, longitude: 4.9041);  <br>
final String resultTZ = _worldtimePlugin.format(dateTime: timeAmsterdamTZ,formatter:myFormatter);  <br>
final String resultGeo = _worldtimePlugin.format(dateTime: timeAmsterdamGeo,formatter:myFormatter);  <br>
</code></p>  
<h1>Walk through</h1>  
<p>Import the plugin</p>  
<p><code>import 'package:worldtime/worldtime.dart';</code></p>  
<p>Initiate the plugin</p>  
<p><code>final _worldtimePlugin = Worldtime();</code></p>
<p>Create a formatter.</p>  
<p><code>final String myFormatter = 'time - \\H:\\m, date - \\D/\\M/\\Y';</code></p>
<h3>Example with TZ Time Zone</h3>
<p>Get the time in Amsterdam.</p>  
<p><code>final DateTime timeAmsterdamTZ = await _worldtimePlugin.timeByCity('Europe/Amsterdam');  
</code></p><br>  
<p>Put the value in a new variable.</p>  
<p><code>final String result = _worldtimePlugin.format(dateTime: timeAmsterdamTZ,   
formatter:myFormatter);</code></p>
<p>Print the variable.</p>  
<p><code>print(result);</code></p>
<h3>Example with Coordinates</h3> 
<p>Amsterdam's coordinates are:<br> 52.3676° N, 4.9041° E => <strong>latitude: 52.3676, longitude: 4.9041</strong></p>  
<p>Get the time in Amsterdam's coordinates.</p>  
<p><code>final DateTime timeAmsterdamGeo = await _worldtimePlugin.timeByLocation(latitude: 52.  
3676, longitude: 4.9041);</code></p>
<p>We will use the same formtter. ('time - \\H:\\m, date - \\D/\\M/\\Y')</p>  
<p>Put the value in a new variable.</p>  
<p><code>final String resultGeo = _worldtimePlugin.format(dateTime: timeAmsterdamGeo,   
formatter:myFormatter);</code></p>
<p>Print the variable.</p>  
<p><code>print(resultGeo);</code></p>