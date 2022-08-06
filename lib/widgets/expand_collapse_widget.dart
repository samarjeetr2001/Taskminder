import 'package:flutter/material.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';

import '../config/app-theme/core_app_theme.dart';



class ExpandCollapseWidget extends StatefulWidget {
  ExpandCollapseWidget({
    Key? key,
    required this.expandedChild,
    required this.collapsedChild,
    required this.buttonText,
    required this.onTap,
    required this.expandedHeight,
    required this.collapsedHeight,
    this.disabled = false,
  }) : super(key: key);
  final Widget expandedChild;
  final Widget collapsedChild;
  final String buttonText;
  final Function() onTap;
  final double expandedHeight;
  final double collapsedHeight;
  final bool disabled;

  @override
  State<ExpandCollapseWidget> createState() => _ExpandCollapseWidgetState();
}

class _ExpandCollapseWidgetState extends State<ExpandCollapseWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 550),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _isExpanded
          ? _expandedWidget(
              child: widget.expandedChild,
              height: widget.expandedHeight,
              buttonText: widget.buttonText,
              onTap: widget.onTap,
            )
          : InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = true;
                });
              },
              child: _collapsedWidget(
                  child: widget.collapsedChild, height: widget.collapsedHeight),
            ),
    );
  }

  Widget _collapsedWidget({required Widget child, required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          child,
          Spacer(),
          Icon(Icons.arrow_drop_down_outlined),
          SizedBox(width: CoreAppTheme.smallSize),
        ],
      ),
    );
  }

  Widget _expandedWidget({
    required Widget child,
    required double height,
    required String buttonText,
    required Function() onTap,
  }) {
    return Container(
      height: height,
      child: Column(
        children: [
          Container(height: height - 50, child: child),
          Spacer(),
          InkWell(
            onTap: () {
              if (!widget.disabled)
                setState(() {
                  _isExpanded = false;
                });
              onTap();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: CoreAppTheme.primaryColor,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  buttonText,
                  style: AppTheme.textStyleNormal
                      .copyWith(color: CoreAppTheme.backgroundColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
