import 'package:js/js.dart';

import 'form_row.dart';

@JS()
class Stepper extends FormRowTyped<num> {
  external String get label;
  external num? get min;
  external num? get max;
  external num? get step;

  factory Stepper({
    required String label,
    num? min,
    num? max,
    num? step,
  }) =>
      _createStepper(
        _CreateStepperOptions(
          label: label,
          min: min,
          max: max,
          step: step,
        ),
      );
}

@JS()
@anonymous
class _CreateStepperOptions {
  external String get label;
  external num? get min;
  external num? get max;
  external num? get step;
  external factory _CreateStepperOptions({
    required String label,
    num? min,
    num? max,
    num? step,
  });
}

@JS('createStepper')
external Stepper _createStepper(_CreateStepperOptions info);
