import { map, rule, writeToProfile } from 'karabiner.ts'

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
writeToProfile('Custom', [
  rule('fn delete word').manipulators([
    map('delete_or_backspace', 'fn').to('delete_or_backspace', 'right_option'),
  ]),
  rule('mouse keys navigate spaces').manipulators([
    map({ pointing_button: 'button5' }).to('left_arrow', 'control'),
    map({ pointing_button: 'button4' }).to('right_arrow', 'control'),
  ]),
])
