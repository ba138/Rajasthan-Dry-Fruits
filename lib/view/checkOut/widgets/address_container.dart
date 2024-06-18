import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';

class AddressCheckOutWidget extends StatefulWidget {
  const AddressCheckOutWidget({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.titleColor,
    required this.title,
    required this.phNo,
    required this.address,
    required this.onpress,
  });
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String title;
  final String phNo;
  final String address;
  final Function onpress;

  @override
  State<AddressCheckOutWidget> createState() => _AddressCheckOutWidgetState();
}

class _AddressCheckOutWidgetState extends State<AddressCheckOutWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.2),
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(width: 2, color: widget.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPressed = !isPressed;
                        if (isPressed) {
                          widget.onpress();
                        }
                      });
                    },
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor),
                        color: isPressed
                            ? AppColor.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: widget.title.length > 15
                            ? '${widget.title.substring(0, 15)}...'
                            : widget.title,
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.titleColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\n${widget.phNo}\n',
                            style: const TextStyle(
                              color: AppColor.textColor1,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: widget.address.length > 20
                                ? '${widget.address.substring(0, 20)}...'
                                : widget.address,
                            style: const TextStyle(
                              color: AppColor.textColor1,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
