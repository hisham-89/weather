
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:weather/model/city.dart';
import 'package:weather/view_model/weather_view_model.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({Key? key}) : super(key: key);

  @override
  CitySearchState createState() => CitySearchState();
}

class CitySearchState extends State<CitySearch> {
  @override
  Widget build(BuildContext context) {
    return
      TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            style: DefaultTextStyle.of(context).style.copyWith(
                fontStyle: FontStyle.italic
            ),
            decoration: const InputDecoration(hintText: "Search for a city",
                hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                border: OutlineInputBorder()
            )
        ),
        suggestionsCallback: (pattern) async {
          return   Provider.of<WeatherViewModel>(context, listen: false).getCity(pattern);
         // return await BackendService.getSuggestions(pattern);
        },
        hideSuggestionsOnKeyboardHide: true,
        hideOnLoading: true,

        itemBuilder: (context,CityElement  suggestion) {
          return ListTile(
            leading:const Icon(Icons.location_on),
            title: Text(suggestion.city),
          );
        },
        onSuggestionSelected: (CityElement suggestion) {
          Provider.of<WeatherViewModel>(context, listen: false).getWeather
            (suggestion.lat,suggestion.lng);
          FocusScope.of(context).requestFocus(FocusNode());
         // Navigator.pop(context)
        },
      );
  }
}
