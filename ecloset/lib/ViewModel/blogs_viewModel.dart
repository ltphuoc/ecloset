import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/ViewModel/base_model.dart';

class BlogsViewModel extends BaseModel {
  // StoreDAO? _storeDAO;
  // List<BlogDTO>? blogs;
  List blogs = [
    {
      "id": 1,
      "images":
          'https://nikechinhhang.net/wp-content/uploads/2021/01/mua-giay-nike-giam-gia-4.png',
    },
    {
      "id": 2,
      'images':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM_esCUjDS0tPowfNBE4iW7DFqz7VsMM2wCQ&usqp=CAU',
    },
    {
      "id": 3,
      'images':
          'https://i.pinimg.com/originals/90/28/f5/9028f50cb6da21e72b363391287d0adf.png',
    },
  ];
  // BlogDTO? dialogBlog;
  BlogsViewModel() {
    // _storeDAO = StoreDAO();
  }

  Future<void> getBlogs() async {
    try {
      setState(ViewStatus.Loading);
      // RootViewModel root = Get.find<RootViewModel>();
      // CampusDTO currentStore = root.currentStore;
      // if (root.status == ViewStatus.Error) {
      //   setState(ViewStatus.Error);
      //   return;
      // }
      // if (blogs != null) {
      //   return;
      // }
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      // blogs = null;
      setState(ViewStatus.Completed);
    }
  }
}
