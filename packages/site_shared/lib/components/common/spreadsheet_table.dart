// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../util.dart';

/// Basic styling customization for a cell, row, or column in a
/// [SpreadsheetTable].
///
/// Supports text and background coloring, as well as basic text styling
/// (bold and italic).
class SpreadsheetStyle {
  /// Creates a styling configuration for a spreadsheet element.
  const SpreadsheetStyle({
    this.textColor,
    this.backgroundColor,
    this.bold,
    this.italic,
    this.textAlign,
  });

  /// The text color (e.g., '#333333', 'red', 'var(--site-primary-color)').
  final String? textColor;

  /// The background color (e.g., '#f5f5f5', '#ffebee',
  /// 'var(--site-raised-bgColor)').
  final String? backgroundColor;

  /// Whether the text should be rendered bold (`font-weight: 600`).
  ///
  /// If null, inherits from parent row/column style or default table styling.
  final bool? bold;

  /// Whether the text should be rendered italic (`font-style: italic`).
  ///
  /// If null, inherits from parent row/column style or default table styling.
  final bool? italic;

  /// The horizontal text alignment ('left', 'center', 'right').
  final String? textAlign;

  /// Merges this style with [other], where [other] takes precedence if its
  /// properties are defined (non-null).
  SpreadsheetStyle merge(SpreadsheetStyle? other) {
    if (other == null) return this;
    return SpreadsheetStyle(
      textColor: other.textColor ?? textColor,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      bold: other.bold ?? bold,
      italic: other.italic ?? italic,
      textAlign: other.textAlign ?? textAlign,
    );
  }

  /// Converts this style into a map of CSS properties suitable for [Styles].
  Map<String, String> toCssMap() {
    final map = <String, String>{};
    if (textColor != null) map['color'] = textColor!;
    if (backgroundColor != null) map['background-color'] = backgroundColor!;
    if (bold == true) map['font-weight'] = '600';
    if (bold == false) map['font-weight'] = 'normal';
    if (italic == true) map['font-style'] = 'italic';
    if (italic == false) map['font-style'] = 'normal';
    if (textAlign != null) map['text-align'] = textAlign!;
    return map;
  }
}

/// Represents a column definition in a [SpreadsheetTable].
class SpreadsheetColumn {
  /// Creates a column definition with a [label], optional [width], and [style].
  const SpreadsheetColumn({
    required this.label,
    this.width,
    this.style = const SpreadsheetStyle(),
  });

  /// Creates a column definition with only a [label].
  factory SpreadsheetColumn.label(String label) =>
      SpreadsheetColumn(label: label);

  /// The header label for this column (e.g., 'A', 'Name', 'Revenue').
  final String label;

  /// Optional CSS width (e.g., '150px', '20%', '10rem').
  final String? width;

  /// Default styling applied to all cells in this column.
  final SpreadsheetStyle style;
}

/// Represents a single cell in a [SpreadsheetTable].
class SpreadsheetCell {
  /// Creates a cell with arbitrary Jaspr [content], optional [style], and
  /// optional column/row spans.
  const SpreadsheetCell({
    required this.content,
    this.style,
    this.colSpan = 1,
    this.rowSpan = 1,
  });

  /// Creates a simple text cell with optional styling.
  factory SpreadsheetCell.text(
    String text, {
    SpreadsheetStyle? style,
    int colSpan = 1,
    int rowSpan = 1,
  }) {
    return SpreadsheetCell(
      content: [Component.text(text)],
      style: style,
      colSpan: colSpan,
      rowSpan: rowSpan,
    );
  }

  /// Creates an empty/blank cell.
  factory SpreadsheetCell.empty({
    SpreadsheetStyle? style,
    int colSpan = 1,
    int rowSpan = 1,
  }) {
    return SpreadsheetCell(
      content: [const Component.text('\u00A0')],
      style: style,
      colSpan: colSpan,
      rowSpan: rowSpan,
    );
  }

  /// The Jaspr components to render inside this cell.
  final List<Component> content;

  /// Specific styling for this cell, which overrides row and column styles.
  final SpreadsheetStyle? style;

  /// The number of columns this cell spans.
  final int colSpan;

  /// The number of rows this cell spans.
  final int rowSpan;
}

/// Represents a row of data in a [SpreadsheetTable].
class SpreadsheetRow {
  /// Creates a row from a list of [cells], optional [style], and [label].
  const SpreadsheetRow({
    required this.cells,
    this.style = const SpreadsheetStyle(),
    this.label,
  });

  /// Creates a row from a list of values (strings, components, or cells).
  factory SpreadsheetRow.fromValues(
    List<Object?> values, {
    SpreadsheetStyle style = const SpreadsheetStyle(),
    String? label,
  }) {
    return SpreadsheetRow(
      cells: values.map((val) {
        if (val is SpreadsheetCell) return val;
        if (val is Component) return SpreadsheetCell(content: [val]);
        if (val == null) return SpreadsheetCell.empty();
        return SpreadsheetCell.text(val.toString());
      }).toList(),
      style: style,
      label: label,
    );
  }

  /// The cells in this row.
  final List<SpreadsheetCell> cells;

  /// Default styling applied to all cells in this row (overrides column
  /// styles).
  final SpreadsheetStyle style;

  /// Optional row header label (e.g., '1', '2', 'Total').
  ///
  /// If not provided and [SpreadsheetTable.showRowNumbers] is true, the 1-based
  /// row index is used automatically.
  final String? label;
}

/// A generic Jaspr component built on HTML tables that renders static data
/// as a full-screen, scrollable, read-only spreadsheet.
///
/// Provides basic customization such as text and background coloring, and basic
/// text styling (bold and italic) at the column, row, and cell levels.
class SpreadsheetTable extends StatelessComponent {
  /// Creates a read-only spreadsheet table from [columns] and [rows].
  const SpreadsheetTable({
    required this.columns,
    required this.rows,
    this.showRowNumbers = true,
    this.fullScreen = true,
    this.id,
    this.additionalClasses,
    this.tableStyles,
    super.key,
  });

  /// Creates a [SpreadsheetTable] from a 2D grid of values (e.g., CSV data).
  ///
  /// The [headers] specify the column labels.
  /// Each list in [data] represents a row of cell values.
  factory SpreadsheetTable.from2D(
    List<String> headers,
    List<List<Object?>> data, {
    bool showRowNumbers = true,
    bool fullScreen = true,
    String? id,
    String? additionalClasses,
    Map<String, String>? tableStyles,
    List<SpreadsheetColumn>? customColumns,
    List<SpreadsheetRow>? customRows,
  }) {
    final columns =
        customColumns ?? headers.map(SpreadsheetColumn.label).toList();
    final rows = customRows ?? data.map(SpreadsheetRow.fromValues).toList();
    return SpreadsheetTable(
      columns: columns,
      rows: rows,
      showRowNumbers: showRowNumbers,
      fullScreen: fullScreen,
      id: id,
      additionalClasses: additionalClasses,
      tableStyles: tableStyles,
    );
  }

  /// The column definitions for the spreadsheet.
  final List<SpreadsheetColumn> columns;

  /// The data rows for the spreadsheet.
  final List<SpreadsheetRow> rows;

  /// Whether to display a sticky row number/label column on the left edge.
  final bool showRowNumbers;

  /// Whether the container should expand to full-screen viewport dimensions.
  final bool fullScreen;

  /// Optional HTML ID for the outer container.
  final String? id;

  /// Additional CSS class names to attach to the outer container.
  final String? additionalClasses;

  /// Optional inline styles for the outer container.
  final Map<String, String>? tableStyles;

  @override
  Component build(BuildContext context) {
    final containerClasses = [
      'spreadsheet-container',
      if (fullScreen) 'spreadsheet-fullscreen',
      ?additionalClasses,
    ].toClasses;

    return div(
      id: id,
      classes: containerClasses,
      styles: tableStyles != null ? Styles(raw: tableStyles!) : null,
      [
        table(
          classes: 'spreadsheet-table',
          [
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ],
    );
  }

  Component _buildHeader() {
    return thead([
      tr([
        if (showRowNumbers)
          const th(
            classes: 'spreadsheet-corner-header',
            // Use non-breaking space so markdown-it/sass doesn't treat as empty.
            [Component.text('\u00A0')],
          ),
        for (final col in columns) _buildHeaderCell(col),
      ]),
    ]);
  }

  Component _buildHeaderCell(SpreadsheetColumn col) {
    final cssMap = col.style.toCssMap();
    if (col.width != null) {
      cssMap['width'] = col.width!;
      cssMap['min-width'] = col.width!;
    }

    return th(
      classes: 'spreadsheet-col-header',
      styles: cssMap.isNotEmpty ? Styles(raw: cssMap) : null,
      [Component.text(col.label)],
    );
  }

  Component _buildBody() {
    return tbody([
      for (var rowIndex = 0; rowIndex < rows.length; rowIndex++)
        _buildRow(rowIndex, rows[rowIndex]),
    ]);
  }

  Component _buildRow(int rowIndex, SpreadsheetRow row) {
    final rowCells = <Component>[];

    if (showRowNumbers) {
      final label = row.label ?? '${rowIndex + 1}';
      rowCells.add(
        th(
          classes: 'spreadsheet-row-header',
          [Component.text(label)],
        ),
      );
    }

    final maxCols =
        columns.length > row.cells.length ? columns.length : row.cells.length;

    for (var colIndex = 0; colIndex < maxCols; colIndex++) {
      if (colIndex < row.cells.length) {
        final cell = row.cells[colIndex];
        final colStyle =
            colIndex < columns.length
                ? columns[colIndex].style
                : const SpreadsheetStyle();
        final mergedStyle = colStyle.merge(row.style).merge(cell.style);

        final cssMap = mergedStyle.toCssMap();
        final attributes = <String, String>{
          if (cell.colSpan > 1) 'colspan': cell.colSpan.toString(),
          if (cell.rowSpan > 1) 'rowspan': cell.rowSpan.toString(),
        };

        rowCells.add(
          td(
            classes: 'spreadsheet-cell',
            styles: cssMap.isNotEmpty ? Styles(raw: cssMap) : null,
            attributes: attributes.isNotEmpty ? attributes : null,
            cell.content,
          ),
        );
      } else {
        // If row has fewer cells than columns, render an empty cell.
        final colStyle =
            colIndex < columns.length
                ? columns[colIndex].style
                : const SpreadsheetStyle();
        final mergedStyle = colStyle.merge(row.style);
        final cssMap = mergedStyle.toCssMap();

        rowCells.add(
          td(
            classes: 'spreadsheet-cell empty-cell',
            styles: cssMap.isNotEmpty ? Styles(raw: cssMap) : null,
            [const Component.text('\u00A0')],
          ),
        );
      }
    }

    return tr(classes: 'spreadsheet-row', rowCells);
  }
}
