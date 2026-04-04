// API Tỉnh/Thành phố - Quận/Huyện - Phường/Xã
// Nguồn: https://esgoo.net
// Sử dụng: Gọi hàm loadProvinceAPI() sau khi DOM ready
// Yêu cầu: Cần có 3 select element với id: #tinh, #quan, #phuong

function loadProvinceAPI() {
    // Lấy tỉnh thành
    $.getJSON('https://esgoo.net/api-tinhthanh-new/1/0.htm', function (data_tinh) {
        if (data_tinh.error == 0) {
            $.each(data_tinh.data, function (key_tinh, val_tinh) {
                $("#tinh").append('<option value="' + val_tinh.id + '">' + val_tinh.full_name + '</option>');
            });

            // Khi chọn tỉnh → load quận/huyện
            $("#tinh").change(function (e) {
                var idtinh = $(this).val();
                $("#quan").html('<option value="0">Quận Huyện</option>');
                $("#phuong").html('<option value="0">Phường Xã</option>');

                $.getJSON('https://esgoo.net/api-tinhthanh-new/2/' + idtinh + '.htm', function (data_quan) {
                    if (data_quan.error == 0) {
                        $.each(data_quan.data, function (key_quan, val_quan) {
                            $("#quan").append('<option value="' + val_quan.id + '">' + val_quan.full_name + '</option>');
                        });

                        // Khi chọn quận → load phường/xã
                        $("#quan").change(function (e) {
                            var idquan = $(this).val();
                            $("#phuong").html('<option value="0">Phường Xã</option>');

                            $.getJSON('https://esgoo.net/api-tinhthanh-new/3/' + idquan + '.htm', function (data_phuong) {
                                if (data_phuong.error == 0) {
                                    $.each(data_phuong.data, function (key_phuong, val_phuong) {
                                        $("#phuong").append('<option value="' + val_phuong.id + '">' + val_phuong.full_name + '</option>');
                                    });
                                }
                            });
                        });
                    }
                });
            });
        }
    });
}
