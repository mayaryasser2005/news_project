import 'package:flutter/cupertino.dart';
import 'package:news_project/data/model/catagory_model.dart';
import 'package:news_project/ui/category_item.dart';

class CategoryTab extends StatelessWidget {
  Function onClick;

  CategoryTab({required this.onClick, super.key});

  var catagorys = CatagoryModel.getCatagories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            "pick your catagory of intersted",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      onClick(catagorys[index]);
                    },
                    child: CategoryItem(
                      catagoryModel: catagorys[index],
                      isOdd: index.isOdd,
                    ));
              },
              itemCount: catagorys.length,
            ),
          )
        ],
      ),
    );
  }
}
