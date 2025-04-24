import 'package:flutter/material.dart';
import 'package:mobile/features/Problems/presentation/widgets/data_table.dart';

class HeaderCell extends StatelessWidget {
  final String label;
  final double width;
  final Alignment alignment;
  final bool isSorted;
  final SortDirection? sortDirection;
  final VoidCallback? onSort;
  final VoidCallback? onMenu;

  const HeaderCell({
    required this.label,
    required this.width,
    this.alignment = Alignment.centerLeft,
    this.isSorted = false,
    this.sortDirection,
    this.onSort,
    this.onMenu,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onSort,
      child: Container(
        width: width,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        alignment: alignment,
        child: Row(
          mainAxisAlignment: alignment == Alignment.center
              ? MainAxisAlignment.center
              : alignment == Alignment.centerRight
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: alignment == Alignment.center
                    ? TextAlign.center
                    : alignment == Alignment.centerRight
                        ? TextAlign.right
                        : TextAlign.left,
              ),
            ),
            if (onSort != null)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  isSorted
                      ? (sortDirection == SortDirection.ascending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward)
                      : Icons.unfold_more_sharp,
                  size: 16,
                  color: isSorted
                      ? theme.colorScheme.primary
                      : theme.disabledColor.withOpacity(0.5),
                ),
              ),
            if (onMenu != null)
              IconButton(
                icon: const Icon(Icons.more_vert, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: 'Menu',
                onPressed: onMenu,
                splashRadius: 18,
              ),
            if (alignment == Alignment.centerLeft &&
                (onSort != null || onMenu != null))
              const Spacer(),
          ],
        ),
      ),
    );
  }
}
