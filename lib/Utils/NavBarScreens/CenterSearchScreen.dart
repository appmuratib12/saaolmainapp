import 'package:flutter/material.dart';
import '../../data/network/BaseApiService.dart';
import '../CenterDetailsPageScreen.dart';

class CenterSearchScreen extends StatefulWidget {
  final TextEditingController searchController;
  const CenterSearchScreen({super.key,required this.searchController});


  @override
  _CenterSearchScreenState createState() => _CenterSearchScreenState();
}

class _CenterSearchScreenState extends State<CenterSearchScreen> {

  List<String> _searchResults = [];
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }


  void _onSearchChanged() {
    final query = widget.searchController.text;
    if (query.isNotEmpty) {
      _fetchSearchResults(query);
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }
  Future<void> _fetchSearchResults(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await BaseApiService().getCenterCitiesResponse(query);
      setState(() {
        _searchResults = response.data!
            .map((dataItem) => dataItem.cityName ?? '')
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList();
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 45, left: 10, right: 10, bottom: 10),
            color: Colors.white, // Background color for app bar
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,color:Colors.black54),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Icon(Icons.search,color:Colors.black54,),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: widget.searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Search for city....",
                        hintStyle: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                        border: InputBorder.none,
                      ),
                      style:const TextStyle(fontWeight:FontWeight.w500,fontFamily:'FontPoppins',fontSize: 15,color:Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color:Colors.white70,thickness:0.2,), // Line separator after search bar
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                ?  const Center(child: Text("No results found",style:TextStyle(fontWeight:FontWeight.w600,fontFamily:'FontPoppins',fontSize:16,color:Colors.black),))
                : ListView.separated(
              itemCount: _searchResults.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_city,color:Colors.black87,size:20,),
                  title: Text(_searchResults[index],style:const TextStyle(fontWeight:FontWeight.w500,
                      fontFamily:'FontPoppins',fontSize:14,color:Colors.black87),),
                  trailing: const Icon(Icons.north_east,color:Colors.black87,size:20,),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CenterDetailsPageScreen(centerName:_searchResults[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


