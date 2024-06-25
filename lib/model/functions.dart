String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input; // Return the original string if it's empty
  }

  // Capitalize the first letter and concatenate the rest of the string
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String printPowerOrLoyalty(
    String typeLine, String? power, String? toughness, String? loyalty) {
  if (typeLine.toLowerCase().contains('creature')) {
    return ('$power/$toughness');
  } else if (typeLine.toLowerCase().contains('planeswalker')) {
    return ('Loyalty: $loyalty');
  } else {
    return ('');
  }
}
