part of 'shared.dart';

class PaginationWeb extends StatefulWidget {
  final int currentPage;
  final int totalPage;
  final Function(int) onTap;
  const PaginationWeb({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.onTap,
  });

  @override
  State<PaginationWeb> createState() => _PaginationWebState();
}

class _PaginationWebState extends State<PaginationWeb> {
  @override
  Widget build(BuildContext context) {
    final x = widget.currentPage == 1;
    final y = widget.currentPage != 1 && widget.currentPage != widget.totalPage;
    final z = !x && widget.currentPage == widget.totalPage;
    final pageList =
        List.generate(widget.totalPage, (index) => (index + 1)).toList();

    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (widget.currentPage == 1) return;
              widget.onTap(widget.currentPage - 1);
            },
            child: Container(
              width: sizeQuery(12),
              height: sizeQuery(12),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.red),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_left,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
          paginationNumber(
            "1",
            callBack: () {
              if (widget.currentPage == 1) return;
              widget.onTap(1);
            },
          ),
          paginationNumber(
            (widget.currentPage != 1 && widget.currentPage != widget.totalPage)
                ? widget.currentPage.toString()
                : '...',
            selected: y,
            callBack: () async {
              if (pageList.isNotEmpty || (pageList.length > 1)) {
                final x = await showMenu(
                  context: context,
                  position:
                      RelativeRect.fromLTRB(sizeQuery(90), sizeQuery(90), 0, 0),
                  items: pageList
                      .map(
                        (e) => PopupMenuItem(
                          value: e,
                          child: AppText(
                            text: e.toString(),
                            size: FontAppSize.font_12,
                            color: AppColor.black,
                          ),
                        ),
                      )
                      .toList(),
                );
                if (x != null) {
                  widget.onTap(x);
                }
              }
            },
          ),
          paginationNumber(
            widget.totalPage == 1 ? '...' : widget.totalPage.toString(),
            callBack: () {
              if (widget.totalPage != 1) {
                widget.onTap(widget.totalPage);
              }
            },
          ),
          InkWell(
            onTap: () {
              if (widget.currentPage == widget.totalPage) return;
              widget.onTap(widget.currentPage + 1);
            },
            child: Container(
              width: sizeQuery(12),
              height: sizeQuery(12),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.red),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_right,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell paginationNumber(
    String i, {
    bool selected = false,
    required Function() callBack,
  }) {
    return InkWell(
      onTap: callBack,
      child: Container(
        margin: EdgeInsets.only(
          left: i == '1' ? sizeQuery(1) : sizeQuery(.5),
          right: i == '10' ? sizeQuery(1) : sizeQuery(.5),
        ),
        width: sizeQuery(12),
        height: sizeQuery(12),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? AppColor.red : AppColor.white),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: AppText(
            text: i,
            size: FontAppSize.font_12,
            color: selected ? AppColor.white : AppColor.black,
          ),
        ),
      ),
    );
  }
}
