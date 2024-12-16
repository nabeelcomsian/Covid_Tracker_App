import 'package:covid_app/Services/World_States_Service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorldStatesList extends StatefulWidget {
  const WorldStatesList({super.key});

  @override
  State<WorldStatesList> createState() => _WorldStatesListState();
}

class _WorldStatesListState extends State<WorldStatesList> {
  TextEditingController searchController = TextEditingController();
  WorldStatesService worldStates = WorldStatesService();
  List<dynamic> countriesData = [];  // List to store all countries data

  // Function to filter countries based on search text
  List<dynamic> getFilteredCountries(String query) {
    if (query.isEmpty) {
      return countriesData; // Return all countries if search is empty
    } else {
      // Filter countries based on search query (case insensitive)
      return countriesData
          .where((country) => country['country']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch data initially when the widget is created
    _loadData();
  }

  // Method to load country data
  void _loadData() async {
    final data = await worldStates.fetchWorldList();
    setState(() {
      countriesData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 232, 232),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {}); // Trigger rebuild when search changes
                },
                decoration: const InputDecoration(
                  hintText: 'Search by Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: worldStates.fetchWorldList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                // Handling loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Container(
                                  width: 80,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: 80,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
                // Error handling for data fetch failure
                else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Data found'),
                  );
                } else {
                  // Store the fetched data
                  countriesData = snapshot.data!;

                  // Apply search filter
                  List<dynamic> filteredCountries = getFilteredCountries(searchController.text.trim().toString());

                  // Display filtered countries
                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        String country = filteredCountries[index]['country'];
                        String cases = filteredCountries[index]['cases'].toString();
                        String flagUrl = filteredCountries[index]['countryInfo']['flag'];

                        return Column(
                          children: [
                            ListTile(
                              title: Text(country),
                              subtitle: Text(cases),
                              leading: Image.network(
                                flagUrl,
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
