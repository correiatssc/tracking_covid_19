import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:tracking_covid_19/src/blocs/country_timeline_bloc.dart';
import 'package:tracking_covid_19/src/models/country_code.dart';

class SearchCountry extends StatefulWidget {
  const SearchCountry({Key key}) : super(key: key);

  @override
  _SearchCountryState createState() => _SearchCountryState();
}

class _SearchCountryState extends State<SearchCountry> {
  Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = CountryPickerUtils.getCountryByIsoCode('BR');
    bloc.fetchCountryTimeline(_selectedCountry.isoCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CountryPickerDialog(
                    titlePadding: EdgeInsets.all(8.0),
                    searchCursorColor: Colors.pinkAccent,
                    searchInputDecoration:
                        InputDecoration(hintText: 'Search...'),
                    isSearchable: true,
                    onValuePicked: (Country country) {
                      setState(() => _selectedCountry = country);
                      bloc.fetchCountryTimeline(_selectedCountry.isoCode);
                    },
                    itemFilter: (c) => CountryCode.countries
                        .map((c) => c.code)
                        .contains(c.isoCode),
                    itemBuilder: (country) => Row(
                          children: <Widget>[
                            CountryPickerUtils.getDefaultFlagImage(country),
                            SizedBox(width: 16),
                            Flexible(child: Text(country.name))
                          ],
                        ));
              });
        },
        iconSize: 48,
        icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: CountryPickerUtils.getDefaultFlagImage(_selectedCountry)));
  }
}
