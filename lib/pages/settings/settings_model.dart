import '/components/button/button_widget.dart';
import '/components/section_header2/section_header2_widget.dart';
import '/components/slider/slider_widget.dart';
import '/components/storage_info/storage_info_widget.dart';
import '/components/switch_component/switch_component_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for SectionHeader.
  late SectionHeader2Model sectionHeaderModel1;
  // State field(s) for Dropdown widget.
  String? dropdownValue1;
  FormFieldController<String>? dropdownValueController1;
  // State field(s) for Dropdown widget.
  String? dropdownValue2;
  FormFieldController<String>? dropdownValueController2;
  // Model for SectionHeader.
  late SectionHeader2Model sectionHeaderModel2;
  // Model for Switch.
  late SwitchComponentModel switchModel1;
  // Model for Switch.
  late SwitchComponentModel switchModel2;
  // Model for Slider.
  late SliderModel sliderModel;
  // Model for SectionHeader.
  late SectionHeader2Model sectionHeaderModel3;
  // Model for StorageInfo.
  late StorageInfoModel storageInfoModel1;
  // Model for StorageInfo.
  late StorageInfoModel storageInfoModel2;
  // Model for StorageInfo.
  late StorageInfoModel storageInfoModel3;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for SectionHeader.
  late SectionHeader2Model sectionHeaderModel4;
  // Model for Button.
  late ButtonModel buttonModel3;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    sectionHeaderModel1 = createModel(context, () => SectionHeader2Model());
    sectionHeaderModel2 = createModel(context, () => SectionHeader2Model());
    switchModel1 = createModel(context, () => SwitchComponentModel());
    switchModel2 = createModel(context, () => SwitchComponentModel());
    sliderModel = createModel(context, () => SliderModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeader2Model());
    storageInfoModel1 = createModel(context, () => StorageInfoModel());
    storageInfoModel2 = createModel(context, () => StorageInfoModel());
    storageInfoModel3 = createModel(context, () => StorageInfoModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    sectionHeaderModel4 = createModel(context, () => SectionHeader2Model());
    buttonModel3 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    sectionHeaderModel1.dispose();
    sectionHeaderModel2.dispose();
    switchModel1.dispose();
    switchModel2.dispose();
    sliderModel.dispose();
    sectionHeaderModel3.dispose();
    storageInfoModel1.dispose();
    storageInfoModel2.dispose();
    storageInfoModel3.dispose();
    buttonModel2.dispose();
    sectionHeaderModel4.dispose();
    buttonModel3.dispose();
  }
}
