import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: Column(children: [LocationContainer()])),
    );
  }
}

class LocationContainer extends StatefulWidget {
  const LocationContainer({super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  String? selectedAddress;
  final TextEditingController _textController = TextEditingController();
  final List<String> addresses = ['', ''];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(24, 30, 24, 47),
      decoration: ShapeDecoration(
        color: const Color(0xFF0258C9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        children: [
          Container(
            width: 328,
            margin: const EdgeInsets.all(16),
            constraints: const BoxConstraints(minHeight: 48.0),
            decoration: ShapeDecoration(
              color: Colors.white,

              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: DropdownButton(
              value: selectedAddress,
              hint: const Text(''),
              items:
                  addresses.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedAddress = newValue;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          // Text input field
          SizedBox(
            width: 328,
            child: TextField(
              autocorrect: true,
              controller: _textController,
              onSubmitted: (value) async {},
              onChanged: (value) {},
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                // Set border properties for all states
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0), // Radius
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),

                hintText: '00.0',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
