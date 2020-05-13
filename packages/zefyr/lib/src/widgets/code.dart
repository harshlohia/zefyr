// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:notus/notus.dart';

import 'common.dart';
import 'theme.dart';

/// Represents a code snippet in Zefyr editor.
class ZefyrCode extends StatelessWidget {
  const ZefyrCode({Key key, @required this.node, this.onCopy})
      : super(key: key);

  /// Document node represented by this widget.
  final BlockNode node;

  final Function(String text) onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final zefyrTheme = ZefyrTheme.of(context);

    var items = <Widget>[];
    var text = '';
    for (var line in node.children) {
      text += line.toPlainText();
      items.add(_buildLine(line, zefyrTheme.attributeTheme.code.textStyle));
    }

    // TODO: move background color and decoration to BlockTheme
    final color = theme.primaryColorBrightness == Brightness.light
        ? Colors.grey.shade200
        : Colors.grey.shade800;
    final contrastColor = theme.primaryColorBrightness == Brightness.light
        ? Colors.grey.shade800
        : Colors.grey.shade200;
    return Padding(
      padding: zefyrTheme.attributeTheme.code.padding,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  Icons.content_copy,
                  color: contrastColor,
                ),
                onPressed: () {
                  onCopy(text);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: items,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine(Node node, TextStyle style) {
    LineNode line = node;
    return ZefyrLine(node: line, style: style);
  }
}
