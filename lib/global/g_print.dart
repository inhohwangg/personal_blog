void printWhite(dynamic text) {
  print('\x1b[37;1m${text.toString()}\x1B[0m');
}

void printBlack(dynamic text) {
  print('\x1b[30;1m${text.toString()}\x1B[0m');
}

void printRed(dynamic text) {
  print('\x1b[31;1m${text.toString()}\x1B[0m');
}

void printGreen(dynamic text) {
  print('\x1b[32;1m${text.toString()}\x1B[0m');
}

void printYellow(dynamic text) {
  print('\x1b[33;1m${text.toString()}\x1B[0m');
}

void printBlue(dynamic text) {
  print('\x1b[34;1m${text.toString()}\x1B[0m');
}

void printPurple(dynamic text) {
  print('\x1b[35;1m${text.toString()}\x1B[0m');
}

void printCyan(dynamic text) {
  print('\x1b[36;1m${text.toString()}\x1B[0m');
}
