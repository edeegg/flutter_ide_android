import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/sdk_version.dart';

class SdkStep extends StatelessWidget {
  final bool isLoading;
  final List<SdkVersion> versions;
  final List<SdkVersion> androidVersions;
  final SdkVersion? selected;
  final SdkVersion? selectedAndroid;
  final Function(SdkVersion) onSelect;
  final Function(SdkVersion) onSelectAndroid;
  final bool hasInternet;

  const SdkStep({
    super.key,
    required this.isLoading,
    required this.versions,
    required this.selected,
    required this.onSelect,
    required this.hasInternet,
    required this.androidVersions,
    this.selectedAndroid,
    required this.onSelectAndroid,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Instalação do SDK',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Escolha uma versão para instalar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: DropdownButtonFormField2<SdkVersion>(
                    isExpanded: true,
                    value: selected,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Versão do SDK do Flutter',
                    ),
                    hint: const Text(
                      'Selecione uma versão',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: versions.map((v) {
                      return DropdownMenuItem<SdkVersion>(
                        value: v,
                        child: Text(v.tagName),
                      );
                    }).toList(),
                    onChanged: hasInternet
                        ? (v) {
                            if (v != null) onSelect(v);
                          }
                        : null,
                    dropdownStyleData: DropdownStyleData(
                      elevation: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: DropdownButtonFormField2<SdkVersion>(
                    isExpanded: true,
                    value: selectedAndroid,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Versão do SDK do Android',
                    ),
                    hint: const Text(
                      'Selecione uma versão',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: androidVersions.map((v) {
                      return DropdownMenuItem<SdkVersion>(
                        value: v,
                        child: Text(v.tagName),
                      );
                    }).toList(),
                    onChanged: hasInternet
                        ? (v) {
                            if (v != null) onSelect(v);
                          }
                        : null,
                    dropdownStyleData: DropdownStyleData(
                      elevation: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                if (!hasInternet)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Conecte-se à internet para continuar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
    );
  }
}
