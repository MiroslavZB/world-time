import 'package:flutter/material.dart';

import 'package:worldtime/worldtime.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Time Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _worldtimePlugin = Worldtime();
  String zone = '';
  String continent = '';
  double long = 0;
  double lat = 0;
  final TextEditingController longController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  DateTime now = DateTime(1990);

  @override
  void dispose() {
    super.dispose();
    longController.dispose();
    latController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('World Time Example App')),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (continent == '') ...[
                  Text(
                    'Result: ${now.toString()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Result formatted ${_worldtimePlugin.format(dateTime: now, formatter: '\\D/\\M/\\Y \\h:\\m')}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 80,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                        ),
                        child: TextField(
                          maxLength: 20,
                          style: const TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          controller: longController
                            ..selection = TextSelection.collapsed(
                                offset: longController.text.length),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counter: Offstage(),
                            hintText: 'longitude',
                          ),
                          onChanged: (newValue) {
                            final double val = double.tryParse(newValue) ?? 0;
                            setState(
                                () => long = val < -90 || val > 90 ? 0 : val);
                          },
                        ),
                      ),
                      Expanded(child: Container()),
                      TextButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          DateTime newDate = await _worldtimePlugin
                              .timeByLocation(latitude: lat, longitude: long);
                          setState(() => now = newDate);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  now != DateTime(1990)
                                      ? 'Time at long: $long, lat: $lat is : $now'
                                      : 'An Error occurred!',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Go'),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 80,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(border: Border.all(width: 2)),
                        child: TextField(
                          maxLength: 20,
                          style: const TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            final double val = double.tryParse(newValue) ?? 0;
                            setState(
                                () => lat = val < -90 || val > 90 ? 0 : val);
                          },
                          controller: latController
                            ..selection = TextSelection.collapsed(
                                offset: latController.text.length),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counter: Offstage(),
                            hintText: 'latitude',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text('Choose an area', style: TextStyle(fontSize: 28)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      childAspectRatio: 16 / 9,
                      children: List.generate(
                        areas.length,
                        (i) => InkWell(
                          onTap: () => setState(() => continent = areas[i]),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                areas[i],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  InkWell(
                    onTap: () => setState(() {
                      continent = '';
                      zone = '';
                    }),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blueGrey,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Go back',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView(
                      children: zones[continent]!
                          .map(
                            (e) => InkWell(
                              onTap: () async {
                                setState(() => zone = e);
                                DateTime newDate = await _worldtimePlugin
                                    .timeByCity('$continent/$zone');
                                setState(() => now = newDate);

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        now != DateTime(1990)
                                            ? 'Time in $continent/$zone is : $now'
                                            : 'An Error occurred!',
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    e,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Note that below lists aren't fully inclusive.
/// Some of the TZ Time Zones don't fit well into the categories and are therefore left out.
const List areas = [
  'Africa',
  'America',
  'Antarctica',
  'Asia',
  'Atlantic',
  'Australia',
  'Europe',
  'Indian',
  'Pacific',
];

const Map<String, List<String>> zones = {
  'Africa': [
    'Bamako',
    'Bangui',
    'Banjul',
    'Bissau',
    'Blantyre',
    'Brazzaville',
    'Bujumbura',
    'Cairo',
    'Casablanca',
    'Ceuta',
    'Conakry',
    'Dakar',
    'Dar_es_Salaam',
    'Djibouti',
    'Douala',
    'El_Aaiun',
    'Freetown',
    'Gaborone',
    'Harare',
    'Johannesburg',
    'Juba',
    'Kampala',
    'Khartoum',
    'Kigali',
    'Kinshasa',
    'Lagos',
    'Libreville',
    'Lome',
    'Luanda',
    'Lubumbashi',
    'Lusaka',
    'Malabo',
    'Maputo',
    'Maseru',
    'Mbabane',
    'Mogadishu',
    'Monrovia',
    'Nairobi',
    'Ndjamena',
    'Niamey',
    'Nouakchott',
    'Ouagadougou',
    'Porto-Novo',
    'Sao_Tome',
    'Timbuktu',
    'Tripoli',
    'Tunis',
    'Windhoek'
  ],
  'America': [
    'Adak',
    'Anchorage',
    'Anguilla',
    'Antigua',
    'Araguaina',
    'Argentina/Buenos_Aires',
    'Argentina/Catamarca',
    'Argentina/ComodRivadavia',
    'Argentina/Cordoba',
    'Argentina/Jujuy',
    'Argentina/La_Rioja',
    'Argentina/Mendoza',
    'Argentina/Rio_Gallegos',
    'Argentina/Salta',
    'Argentina/San_Juan',
    'Argentina/San_Luis',
    'Argentina/Tucuman',
    'Argentina/Ushuaia',
    'Aruba',
    'Asuncion',
    'Atikokan',
    'Atka',
    'Bahia',
    'Bahia_Banderas',
    'Barbados',
    'Belem',
    'Belize',
    'Blanc-Sablon',
    'Boa_Vista',
    'Bogota',
    'Boise',
    'Buenos_Aires',
    'Cambridge_Bay',
    'Campo_Grande',
    'Cancun',
    'Caracas',
    'Catamarca',
    'Cayenne',
    'Cayman',
    'Chicago',
    'Chihuahua',
    'Ciudad_Juarez',
    'Coral_Harbour',
    'Cordoba',
    'Costa_Rica',
    'Creston',
    'Cuiaba',
    'Curacao',
    'Danmarkshavn',
    'Dawson',
    'Dawson_Creek',
    'Denver',
    'Detroit',
    'Dominica',
    'Edmonton',
    'Eirunepe',
    'El_Salvador',
    'Ensenada',
    'Fort_Nelson',
    'Fort_Wayne',
    'Fortaleza',
    'Glace_Bay',
    'Godthab',
    'Goose_Bay',
    'Grand_Turk',
    'Grenada',
    'Guadeloupe',
    'Guatemala',
    'Guayaquil',
    'Guyana',
    'Halifax',
    'Havana',
    'Hermosillo',
    'Indiana/Indianapolis',
    'Indiana/Knox',
    'Indiana/Marengo',
    'Indiana/Petersburg',
    'Indiana/Tell_City',
    'Indiana/Vevay',
    'Indiana/Vincennes',
    'Indiana/Winamac',
    'Indianapolis',
    'Inuvik',
    'Iqaluit',
    'Jamaica',
    'Jujuy',
    'Juneau',
    'Kentucky/Louisville',
    'Kentucky/Monticello',
    'Knox_IN',
    'Kralendijk',
    'La_Paz',
    'Lima',
    'Los_Angeles',
    'Louisville',
    'Lower_Princes',
    'Maceio',
    'Managua',
    'Manaus',
    'Marigot',
    'Martinique',
    'Matamoros',
    'Mazatlan',
    'Mendoza',
    'Menominee',
    'Merida',
    'Metlakatla',
    'Mexico_City',
    'Miquelon',
    'Moncton',
    'Monterrey',
    'Montevideo',
    'Montreal',
    'Montserrat',
    'Nassau',
    'New_York',
    'Nipigon',
    'Nome',
    'Noronha',
    'North_Dakota/Beulah',
    'North_Dakota/Center',
    'North_Dakota/New_Salem',
    'Nuuk',
    'Ojinaga',
    'Panama',
    'Pangnirtung',
    'Paramaribo',
    'Phoenix',
    'Port-au-Prince',
    'Port_of_Spain',
    'Porto_Acre',
    'Porto_Velho',
    'Puerto_Rico',
    'Punta_Arenas',
    'Rainy_River',
    'Rankin_Inlet',
    'Recife',
    'Regina',
    'Resolute',
    'Rio_Branco',
    'Rosario',
    'Santa_Isabel',
    'Santarem',
    'Santiago',
    'Santo_Domingo',
    'Sao_Paulo',
    'Scoresbysund',
    'Shiprock',
    'Sitka',
    'St_Barthelemy',
    'St_Johns',
    'St_Kitts',
    'St_Lucia',
    'St_Thomas',
    'St_Vincent',
    'Swift_Current',
    'Tegucigalpa',
    'Thule',
    'Thunder_Bay',
    'Tijuana',
    'Toronto',
    'Tortola',
    'Vancouver',
    'Virgin',
    'Whitehorse',
    'Winnipeg',
    'Yakutat',
    'Yellowknife',
  ],
  'Antarctica': [
    'Casey',
    'Davis',
    'DumontDUrville',
    'Macquarie',
    'Mawson',
    'McMurdo',
    'Palmer',
    'Rothera',
    'South_Pole',
    'Syowa',
    'Troll',
    'Vostok',
  ],
  'Asia': [
    'Aden',
    'Almaty',
    'Amman',
    'Anadyr',
    'Aqtau',
    'Aqtobe',
    'Ashgabat',
    'Ashkhabad',
    'Atyrau',
    'Baghdad',
    'Bahrain',
    'Baku',
    'Bangkok',
    'Barnaul',
    'Beirut',
    'Bishkek',
    'Brunei',
    'Calcutta',
    'Chita',
    'Choibalsan',
    'Chongqing',
    'Chungking',
    'Colombo',
    'Dacca',
    'Damascus',
    'Dhaka',
    'Dili',
    'Dubai',
    'Dushanbe',
    'Famagusta',
    'Gaza',
    'Harbin',
    'Hebron',
    'Ho_Chi_Minh',
    'Hong_Kong',
    'Hovd',
    'Irkutsk',
    'Istanbul',
    'Jakarta',
    'Jayapura',
    'Jerusalem',
    'Kabul',
    'Kamchatka',
    'Karachi',
    'Kashgar',
    'Kathmandu',
    'Katmandu',
    'Khandyga',
    'Kolkata',
    'Krasnoyarsk',
    'Kuala_Lumpur',
    'Kuching',
    'Kuwait',
    'Macao',
    'Macau',
    'Magadan',
    'Makassar',
    'Manila',
    'Muscat',
    'Nicosia',
    'Novokuznetsk',
    'Novosibirsk',
    'Omsk',
    'Oral',
    'Phnom_Penh',
    'Pontianak',
    'Pyongyang',
    'Qatar',
    'Qostanay',
    'Qyzylorda',
    'Rangoon',
    'Riyadh',
    'Saigon',
    'Sakhalin',
    'Samarkand',
    'Seoul',
    'Shanghai',
    'Singapore',
    'Srednekolymsk',
    'Taipei',
    'Tashkent',
    'Tbilisi',
    'Tehran',
    'Tel_Aviv',
    'Thimbu',
    'Thimphu',
    'Tokyo',
    'Tomsk',
    'Ujung_Pandang',
    'Ulaanbaatar',
    'Ulan_Bator',
    'Urumqi',
    'Ust-Nera',
    'Vientiane',
    'Vladivostok',
    'Yakutsk',
    'Yangon',
    'Yekaterinburg',
    'Yerevan',
  ],
  'Atlantic': [
    'Azores',
    'Bermuda',
    'Canary',
    'Cape_Verde',
    'Faeroe',
    'Faroe',
    'Jan_Mayen',
    'Madeira',
    'Reykjavik',
    'South_Georgia',
    'St_Helena',
    'Stanley',
  ],
  'Australia': [
    'ACT',
    'Adelaide',
    'Brisbane',
    'Broken_Hill',
    'Canberra',
    'Currie',
    'Darwin',
    'Eucla',
    'Hobart',
    'LHI',
    'Lindeman',
    'Lord_Howe',
    'Melbourne',
    'North',
    'NSW',
    'Perth',
    'Queensland',
    'South',
    'Sydney',
    'Tasmania',
    'Victoria',
    'West',
    'Yancowinna',
  ],
  'Europe': [
    'Amsterdam',
    'Andorra',
    'Astrakhan',
    'Athens',
    'Belfast',
    'Belgrade',
    'Berlin',
    'Bratislava',
    'Brussels',
    'Bucharest',
    'Budapest',
    'Busingen',
    'Chisinau',
    'Copenhagen',
    'Dublin',
    'Gibraltar',
    'Guernsey',
    'Helsinki',
    'Isle_of_Man',
    'Istanbul',
    'Jersey',
    'Kaliningrad',
    'Kiev',
    'Kirov',
    'Kyiv',
    'Lisbon',
    'Ljubljana',
    'London',
    'Luxembourg',
    'Madrid',
    'Malta',
    'Mariehamn',
    'Minsk',
    'Monaco',
    'Moscow',
    'Nicosia',
    'Oslo',
    'Paris',
    'Podgorica',
    'Prague',
    'Riga',
    'Rome',
    'Samara',
    'San_Marino',
    'Sarajevo',
    'Saratov',
    'Simferopol',
    'Skopje',
    'Sofia',
    'Stockholm',
    'Tallinn',
    'Tirane',
    'Tiraspol',
    'Ulyanovsk',
    'Uzhgorod',
    'Vaduz',
    'Vatican',
    'Vienna',
    'Vilnius',
    'Volgograd',
    'Warsaw',
    'Zagreb',
    'Zaporozhye',
    'Zurich',
  ],
  'Indian': [
    'Antananarivo',
    'Chagos',
    'Christmas',
    'Cocos',
    'Comoro',
    'Kerguelen',
    'Mahe',
    'Maldives',
    'Mauritius',
    'Mayotte',
    'Reunion',
  ],
  'Pacific': [
    'Apia',
    'Auckland',
    'Bougainville',
    'Chatham',
    'Chuuk',
    'Easter',
    'Efate',
    'Enderbury',
    'Fakaofo',
    'Fiji',
    'Funafuti',
    'Galapagos',
    'Gambier',
    'Guadalcanal',
    'Guam',
    'Honolulu',
    'Johnston',
    'Kanton',
    'Kiritimati',
    'Kosrae',
    'Kwajalein',
    'Majuro',
    'Marquesas',
    'Midway',
    'Nauru',
    'Niue',
    'Norfolk',
    'Noumea',
    'Pago_Pago',
    'Palau',
    'Pitcairn',
    'Pohnpei',
    'Ponape',
    'Port_Moresby',
    'Rarotonga',
    'Saipan',
    'Samoa',
    'Tahiti',
    'Tarawa',
    'Tongatapu',
    'Truk',
    'Wake',
    'Wallis',
    'Yap',
  ],
};
