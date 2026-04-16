$(document).ready(function () {
    
    // Thêm vào giỏ hàng chung
    $(document).on('click', '.add-to-cart', function () {
        var Id = $(this).data("product_id");

        $.ajax({
            type: "POST",
            url: "/Cart/Add",
            data: { Id: Id },
            success: function (result) {
                if (result) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: 'Thêm vào giỏ hàng thành công!',
                        timer: 1500,
                        showConfirmButton: false
                    });
                }
            },
            error: function () {
                Swal.fire('Lỗi', 'Không thể thêm vào giỏ hàng.', 'error');
            }
        });
    });

    // Thêm vào Wishlist chung
    $(document).on('click', '.add-to-wishlist', function (e) {
        e.preventDefault();
        var Id = $(this).data("product_id");
        var btn = $(this);

        $.ajax({
            type: "POST",
            url: "/Home/AddWishList",
            data: { Id: Id },
            success: function (result) {
                if (result && result.message) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Hoàn tất',
                        text: result.message,
                        timer: 1500,
                        showConfirmButton: false
                    });
                    btn.addClass("active");
                } else {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: "Đã xử lý wishlist thành công.",
                        timer: 1500,
                        showConfirmButton: false
                    });
                    btn.addClass("active");
                }
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    Swal.fire('Cảnh báo', 'Bạn cần đăng nhập để dùng tính năng này.', 'warning');
                    return;
                }

                if (xhr.responseJSON && xhr.responseJSON.message) {
                    Swal.fire('Lỗi', xhr.responseJSON.message, 'error');
                    return;
                }

                Swal.fire('Lỗi', 'Có lỗi xảy ra khi thêm wishlist.', 'error');
            }
        });
    });

    // Xóa khỏi Wishlist (trên trang Wishlist)
    $(document).on('click', '.btn-remove-wishlist', function () {
        var Id = $(this).data('product_id');
        var $productWrapper = $(this).closest('.product-wrapper');

        $.ajax({
            type: 'POST',
            url: '/Home/RemoveWishList',
            data: { Id: Id },
            success: function (result) {
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công',
                    text: result.message || 'Đã xóa sản phẩm khỏi Yêu thích.',
                    timer: 1500,
                    showConfirmButton: false
                });

                // Fade out then remove
                if ($productWrapper.length > 0) {
                    $productWrapper.fadeOut(400, function () {
                        $(this).remove();
                        // Reload if no products left
                        if ($('.btn-remove-wishlist').length === 0) {
                            location.reload();
                        }
                    });
                }
            },
            error: function (xhr) {
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    Swal.fire('Lỗi', xhr.responseJSON.message, 'error');
                    return;
                }
                Swal.fire('Lỗi', 'Không thể xóa sản phẩm khỏi Yêu thích.', 'error');
            }
        });
    });
});
