String formatCategoryIconName(String iconKey) {
  return iconKey
      .split('_')
      .map(
        (word) => '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
      )
      .join(' ');
}
