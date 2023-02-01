## 1.0.9

A Flutter package to get the time of a specific time zone or geo location.  
It also includes an easy to use formatter for DateTime with customizable formatting.

# Features

1. Get current **time** from **EZ Time Zone**
2. Get current time from **Latitude** and **Longitude**.
3. Format a **Flutter DateTime object** to a pretty _String formatted_ text to your liking.

![Example App](assets/example.png)

# Short example code

``` dart
import 'package:worldtime/worldtime.dart';

final _worldtimePlugin = Worldtime();

final String myFormatter = 'time - \\h:\\m, date - \\D/\\M/\\Y';

final DateTime timeAmsterdamTZ = await _worldtimePlugin
    .timeByCity('Europe/Amsterdam');

final DateTime timeAmsterdamGeo = await _worldtimePlugin
    .timeByLocation(latitude: 52.3676, longitude: 4.9041);

final String resultTZ = _worldtimePlugin
    .format(dateTime: timeAmsterdamTZ,formatter:myFormatter);

final String resultGeo = _worldtimePlugin
    .format(dateTime: timeAmsterdamGeo,formatter:myFormatter);
```

# Walk through

Import the plugin

``` dart
import 'package:worldtime/worldtime.dart';
```

Initiate the plugin

``` dart
final _worldtimePlugin = Worldtime();
```

Create a formatter.

``` dart
final String myFormatter = 'time - \\h:\\m, date - \\D/\\M/\\Y';
```

## Example with TZ Time Zone

Get the time in Amsterdam.

``` dart
final DateTime timeAmsterdamTZ = await _worldtimePlugin
    .timeByCity('Europe/Amsterdam');
```

Put the value in a new variable.

``` dart
final String resultTZ = _worldtimePlugin
    .format(dateTime: timeAmsterdamTZ,formatter:myFormatter);
```

Print the variable.

``` dart
print(result);
```

## Example with Coordinates

Amsterdam's coordinates are:
52.3676° N, 4.9041° E => **latitude: 52.3676, longitude: 4.9041**  
Get the time in Amsterdam's coordinates.

``` dart
final DateTime timeAmsterdamGeo = await _worldtimePlugin.
    timeByLocation(
        latitude: 52.3676,
        longitude: 4.9041,
    );
```

We will use the same formtter. ('time - \\h:\\m, date - \\D/\\M/\\Y')  
Put the value in a new variable.

``` dart
final String resultGeo = _worldtimePlugin.
    format(
        dateTime: timeAmsterdamGeo,
        formatter:myFormatter,
    );
```

Print the variable.

``` dart
print(resultGeo);
```
