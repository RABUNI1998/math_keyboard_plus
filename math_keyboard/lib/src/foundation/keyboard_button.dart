import 'package:flutter/services.dart';
import 'package:math_keyboard_plus/src/foundation/node.dart';

/// Class representing a button configuration.
abstract class KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const KeyboardButtonConfig({
    this.flex,
    this.keyboardCharacters = const [],
  });

  /// Optional flex.
  final int? flex;

  /// The list of [KeyEvent.character] that should trigger this keyboard
  /// button on a physical keyboard.
  ///
  /// Note that the case of the characters is ignored.
  ///
  /// Special keyboard keys like backspace and arrow keys are specially handled
  /// and do *not* require this to be set.
  ///
  /// Must not be `null` but can be empty.
  final List<String> keyboardCharacters;
}

/// Class representing a button configuration for a [FunctionButton].
class BasicKeyboardButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const BasicKeyboardButtonConfig({
    required this.label,
    required this.value,
    this.args,
    this.asTex = false,
    this.highlighted = false,
    List<String> keyboardCharacters = const [],
    int? flex,
  }) : super(
          flex: flex,
          keyboardCharacters: keyboardCharacters,
        );

  /// The label of the button.
  final String label;

  /// The value in tex.
  final String value;

  /// List defining the arguments for the function behind this button.
  final List<TeXArg>? args;

  /// Whether to display the label as TeX or as plain text.
  final bool asTex;

  /// The highlight level of this button.
  final bool highlighted;
}

/// Class representing a button configuration of the Delete Button.
class DeleteButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  DeleteButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Previous Button.
class PreviousButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  PreviousButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Next Button.
class NextButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  NextButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class SubmitButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  SubmitButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Page Toggle Button.
class PageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [PageButtonConfig].
  const PageButtonConfig({int? flex}) : super(flex: flex);
}

/// List of keyboard button configs for the digits from 0-9.
///
/// List access from 0 to 9 will return the appropriate digit button.
final _digitButtons = [
  for (var i = 0; i < 10; i++)
    BasicKeyboardButtonConfig(
      label: '$i',
      value: '$i',
      keyboardCharacters: ['$i'],
    ),
];

const _decimalButton = BasicKeyboardButtonConfig(
  label: '.',
  value: '.',
  keyboardCharacters: ['.', ','],
  highlighted: true,
);

const _subtractButton = BasicKeyboardButtonConfig(
  label: '−',
  value: '-',
  keyboardCharacters: ['-'],
  highlighted: true,
);

/// Keyboard showing extended functionality.
final functionKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\frac{\Box}{\Box}',
      value: r'\frac',
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^2',
      value: '^2',
      args: [TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^{\Box}',
      value: '^',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: [
        '^',
        // This is a workaround for keyboard layout that use ^ as a toggle key.
        // In that case, "Dead" is reported as the character (e.g. for German
        // keyboards).
        'Dead',
      ],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sin',
      value: r'\sin(',
      asTex: true,
      keyboardCharacters: ['s'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sin^{-1}',
      value: r'\sin^{-1}(',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\sqrt{\Box}',
      value: r'\sqrt',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: ['r'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt[\Box]{\Box}',
      value: r'\sqrt',
      args: [TeXArg.brackets, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cos',
      value: r'\cos(',
      asTex: true,
      keyboardCharacters: ['c'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cos^{-1}',
      value: r'\cos^{-1}(',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\log_{\Box}(\Box)',
      value: r'\log_',
      asTex: true,
      args: [TeXArg.braces, TeXArg.parentheses],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ln(\Box)',
      value: r'\ln(',
      asTex: true,
      keyboardCharacters: ['l'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\tan',
      value: r'\tan(',
      asTex: true,
      keyboardCharacters: ['t'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\tan^{-1}',
      value: r'\tan^{-1}(',
      asTex: true,
    ),
  ],
  [
    const PageButtonConfig(flex: 3),
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      highlighted: true,
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      highlighted: true,
      keyboardCharacters: [')'],
    ),
    PreviousButtonConfig(),
    NextButtonConfig(),
    DeleteButtonConfig(),
  ],
];

/// Advanced keyboard showing more complex mathematical operators.
final advancedKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\lim_{x \to \Box}(\Box)',
      value: r'\lim_',
      args: [TeXArg.braces, TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\frac{d}{dx}(\Box)',
      value: r'\frac{d}{dx}',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\frac{\partial}{\partial x}(\Box)',
      value: r'\frac{\partial}{\partial x}',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\int(\Box)',
      value: r'\int',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\sum_{\Box}(\Box)',
      value: r'\sum_',
      args: [TeXArg.braces, TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\prod_{\Box}(\Box)',
      value: r'\prod_',
      args: [TeXArg.braces, TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\lim^{\sup}(\Box)',
      value: r'\lim^{\sup}',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\lim_{\inf}(\Box)',
      value: r'\lim_{\inf}',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\infty',
      value: r'\infty',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\nabla',
      value: r'\nabla',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Delta',
      value: r'\Delta',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\exp(\Box)',
      value: r'\exp(',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\forall',
      value: r'\forall',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\exists',
      value: r'\exists',
      asTex: true,
    ),
  ],
  [
    const PageButtonConfig(flex: 3),
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      highlighted: true,
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      highlighted: true,
      keyboardCharacters: [')'],
    ),
    PreviousButtonConfig(),
    NextButtonConfig(),
    DeleteButtonConfig(),
  ],
];

/// Statistics and combinatorics keyboard showing statistical and combinatorial operators.
/// This is the 4th page in the keyboard cycling.
final statisticsKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\binom{\Box}{\Box}',
      value: r'\binom',
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'P(\Box,\Box)',
      value: 'P(',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '!',
      value: '!',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: 'mod',
      value: r'\mod',
      asTex: false,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt[\Box]{\Box}',
      value: r'\sqrt',
      args: [TeXArg.brackets, TeXArg.braces],
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\ell(\Box)',
      value: r'\ell(',
      args: [TeXArg.parentheses],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\mathbb{N}',
      value: r'\mathbb{N}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\mathbb{Z}',
      value: r'\mathbb{Z}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\mathbb{Q}',
      value: r'\mathbb{Q}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\mathbb{R}',
      value: r'\mathbb{R}',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\mathbb{C}',
      value: r'\mathbb{C}',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\emptyset',
      value: r'\emptyset',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\aleph',
      value: r'\aleph',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cup',
      value: r'\cup',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cap',
      value: r'\cap',
      asTex: true,
    ),
  ],
  [
    const PageButtonConfig(flex: 3),
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      highlighted: true,
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      highlighted: true,
      keyboardCharacters: [')'],
    ),
    PreviousButtonConfig(),
    NextButtonConfig(),
    DeleteButtonConfig(),
  ],
];

/// Standard keyboard for math expression input.
final standardKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    const BasicKeyboardButtonConfig(
      label: '×',
      value: r'\cdot',
      keyboardCharacters: ['*'],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '÷',
      value: r'\frac',
      keyboardCharacters: ['/'],
      args: [TeXArg.braces, TeXArg.braces],
      highlighted: true,
    ),
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    const BasicKeyboardButtonConfig(
      label: '+',
      value: '+',
      keyboardCharacters: ['+'],
      highlighted: true,
    ),
    _subtractButton,
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    _decimalButton,
    DeleteButtonConfig(),
  ],
  [
    const PageButtonConfig(),
    _digitButtons[0],
    PreviousButtonConfig(),
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];

/// Keyboard getting shown for number input only.
final numberKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _subtractButton,
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    _decimalButton,
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    DeleteButtonConfig(),
  ],
  [
    PreviousButtonConfig(),
    _digitButtons[0],
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];
