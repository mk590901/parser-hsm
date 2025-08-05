import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/list_bloc.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParserPage()));
}

class ParserPage extends StatelessWidget {
  const ParserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Parser HSM',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.normal,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.indigo,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            // ComboBox
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<ListBloc, ListState>(
                builder: (context, state) {
                  return DropdownButtonFormField<String>(
                    value: state.selectedOption,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    items:
                    ListBloc.items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        context.read<ListBloc>().add(
                          SelectOptionEvent(newValue),
                        );
                        context.read<ListBloc>().add(ClearListEvent());
                      }
                    },
                  );
                },
              ),
            ),
            // Scrollable List with Buttons
            Expanded(
              child: BlocBuilder<ListBloc, ListState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                state.items[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<ListBloc>().add(ClearListEvent());
                                context.read<ListBloc>().add(
                                  PerformActionEvent(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Parse',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
