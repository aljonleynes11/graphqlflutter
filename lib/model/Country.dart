import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
    Country({
        this.countries,
    });

    List<CountryElement> countries;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        countries: List<CountryElement>.from(json["countries"].map((x) => CountryElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    };
}

class CountryElement {
    CountryElement({
        this.name,
        this.capital,
    });

    String name;
    String capital;

    factory CountryElement.fromJson(Map<String, dynamic> json) => CountryElement(
        name: json["name"],
        capital: json["capital"] == null ? null : json["capital"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "capital": capital == null ? null : capital,
    };
}
