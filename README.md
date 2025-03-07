Profil Resmini WebP olarak yükle.
Cache Network Image de bir problem var !!

"No data available" Bunun için standart bir widget oluşturulmalı !
    return Obx(() {
            if (aboutController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final about = aboutController.data.value;
            if (about == null) {
              return Center(child: Text("No data available"));
            }
            return body(context, about);
          });