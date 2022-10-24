class CrosswordModel {
  const CrosswordModel(
    this.row,
    this.col,
  );

  final int row;
  final int col;

  Map<String, dynamic> toMap() {
    return {'row': row, 'col': col};
  }

  bool operator ==(other) =>
      other is CrosswordModel && other.row == row && other.col == col;
  // int get hashCode => hash2(row.hashCode, col.hashCode);
  int get hashCode => row.hashCode ^ col.hashCode;
}
