import 'package:doctor_doom/authentication/tokenmanage.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _dobController = TextEditingController();
  final _institutionController = TextEditingController();
  final _otherOccupationController = TextEditingController();

  String? _selectedOccupation;

  final List<SelectedListItem> occupations = [
    SelectedListItem(name: 'Software Developer'),
    SelectedListItem(name: 'Product Manager'),
    SelectedListItem(name: 'Data Scientist'),
    SelectedListItem(name: 'UX/UI Designer'),
    SelectedListItem(name: 'Graphic Designer'),
    SelectedListItem(name: 'Content Writer'),
    SelectedListItem(name: 'Digital Marketer'),
    SelectedListItem(name: 'HR Specialist'),
    SelectedListItem(name: 'Sales Manager'),
    SelectedListItem(name: 'Accountant'),
    SelectedListItem(name: 'Entrepreneur'),
    SelectedListItem(name: 'Consultant'),
    SelectedListItem(name: 'Lawyer'),
    SelectedListItem(name: 'Doctor'),
    SelectedListItem(name: 'Nurse'),
    SelectedListItem(name: 'Teacher'),
    SelectedListItem(name: 'Professor'),
    SelectedListItem(name: 'Researcher'),
    SelectedListItem(name: 'Student'),
    SelectedListItem(name: 'Freelancer'),
    SelectedListItem(name: 'Project Manager'),
    SelectedListItem(name: 'Team Leader'),
    SelectedListItem(name: 'CEO'),
    SelectedListItem(name: 'CFO'),
    SelectedListItem(name: 'COO'),
    SelectedListItem(name: 'Engineer'),
    SelectedListItem(name: 'Civil Engineer'),
    SelectedListItem(name: 'Mechanical Engineer'),
    SelectedListItem(name: 'Electrical Engineer'),
    SelectedListItem(name: 'Architect'),
    SelectedListItem(name: 'Artist'),
    SelectedListItem(name: 'Photographer'),
    SelectedListItem(name: 'Videographer'),
    SelectedListItem(name: 'Journalist'),
    SelectedListItem(name: 'Event Planner'),
    SelectedListItem(name: 'Recruiter'),
    SelectedListItem(name: 'Real Estate Agent'),
    SelectedListItem(name: 'Social Media Manager'),
    SelectedListItem(name: 'Translator'),
    SelectedListItem(name: 'Therapist'),
    SelectedListItem(name: 'Psychologist'),
    SelectedListItem(name: 'Fitness Trainer'),
    SelectedListItem(name: 'Nutritionist'),
    SelectedListItem(name: 'Blogger'),
    SelectedListItem(name: 'Vlogger'),
    SelectedListItem(name: 'Other'),
  ];

  Future<void> submitProfile() async {
    String dob = _dobController.text;
    String institution = _institutionController.text;
    String occupation = _selectedOccupation == 'Other'
        ? _otherOccupationController.text
        : _selectedOccupation ?? '';

    Map<String, String> updatedFields = {
      'DOB': dob,
      'Institution': institution,
      'Occupation': occupation,
    };

    print('DOB: $dob, Institution: $institution, Occupation: $occupation');

    final accessToken = await getAccessToken();
    if (accessToken == null) {
      print('Failed to get access token');
      return;
    }

    print('Access token is $accessToken');
    print(
        'Updated fields: ${updatedFields['DOB']}....${updatedFields['Institution']}....${updatedFields['Occupation']}');

    final response = await http.put(
      Uri.parse('https://agora.naitikk.tech/update-info/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'dob': updatedFields['DOB'],
        'institution': updatedFields['Institution'],
        'occupation': updatedFields['Occupation'],
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Updated!'),
            content: const Text('Details submitted successfully!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to submit details'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String?> getAccessToken() async {
    final authToken = await getToken();
    print('Auth token is $authToken');

    try {
      final response = await http.post(
        Uri.parse('https://agora.naitikk.tech/token/refresh/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh': authToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String accessToken = data['access'];
        return accessToken;
      } else {
        print('Failed to fetch access token: ${response.body}');
      }
    } catch (e) {
      print('Error fetching access token: $e');
    }
    return null;
  }

  void _showOccupationPicker() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          "Select Occupation",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: occupations,
        onSelected: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty && selectedList[0] is SelectedListItem) {
            setState(() {
              _selectedOccupation = (selectedList[0] as SelectedListItem).name;
            });
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 201, 152),
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C2C2C),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildcontainer(
                title: 'Date of Birth',
                content: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        labelText: 'DOB',
                        hintText: 'YYYY-MM-DD',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildcontainer(
                title: 'Institution',
                content: TextField(
                  controller: _institutionController,
                  decoration: InputDecoration(
                    labelText: 'Institute name',
                    prefixIcon: Icon(Icons.school),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildcontainer(
                title: 'Occupation',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _showOccupationPicker,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedOccupation ?? "Select Occupation",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedOccupation == 'Other')
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextField(
                          controller: _otherOccupationController,
                          decoration: InputDecoration(
                            labelText: 'Specify Other Occupation',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: submitProfile,
                child: Text(
                  '   DONE   ',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: const Color(0xFF2C2C2C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildcontainer({
  required String title,
  required Widget content,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                content,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
