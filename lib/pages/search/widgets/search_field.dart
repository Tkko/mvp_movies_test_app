import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_movies/app/app.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final bool enabled;
  final Widget trailing;
  final Widget leading;
  final String hint;
  final bool autofocus;

  SearchField({
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.autofocus = true,
    this.trailing,
    this.focusNode,
    this.hint,
    this.leading,
  });

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  void onClear() {
    setState(() {
      widget.controller.clear();
      widget.onChanged?.call('');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showClearButton = widget.enabled && widget.controller.text.isNotEmpty;
    final hasLeading = widget.leading != null;

    return Material(
      child: Container(
        height: 48.w,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          left: hasLeading ? 0 : 12.w,
        ),
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Row(
          children: [
            if (hasLeading) widget.leading,
            Expanded(
              child: TextField(
                enabled: widget.enabled,
                controller: widget.controller,
                onChanged: (s) {
                  setState(() {});
                  widget.onChanged?.call(s);
                },
                onSubmitted: widget.onSubmitted,
                autocorrect: false,
                focusNode: widget.focusNode,
                autofocus: widget.autofocus && widget.enabled,
                scrollPadding: EdgeInsets.zero,
                style: context.theme.textTheme.bodyText1.copyWith(
                  height: 1,
                ),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintStyle: context.theme.textTheme.bodyText1.copyWith(
                    height: 1,
                  ),
                  hintText: widget.hint,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            if (showClearButton)
              ChipCancelButton(
                onTap: widget.enabled ? onClear : null,
              ),
            if (widget.trailing != null && !showClearButton) widget.trailing,
          ],
        ),
      ),
    );
  }
}

class ChipCancelButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChipCancelButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        canRequestFocus: false,
        borderRadius: BorderRadius.circular(40.w),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Ink(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: context.theme.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'close'.svg,
              width: 20.w,
            ),
          ),
        ),
      ),
    );
  }
}
