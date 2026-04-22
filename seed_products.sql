USE ShoppingCart;
GO
-- 1. Insert Categories
IF NOT EXISTS (SELECT * FROM Categories WHERE Name = N'Laptop Gaming')
    INSERT INTO Categories (Name, Slug, Description, Status) VALUES (N'Laptop Gaming', 'laptop-gaming', '', 1);
IF NOT EXISTS (SELECT * FROM Categories WHERE Name = N'Laptop Văn phòng')
    INSERT INTO Categories (Name, Slug, Description, Status) VALUES (N'Laptop Văn phòng', 'laptop-van-phong', '', 1);
IF NOT EXISTS (SELECT * FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật')
    INSERT INTO Categories (Name, Slug, Description, Status) VALUES (N'Laptop Đồ họa - Kĩ thuật', 'laptop-do-hoa-ki-thuat', '', 1);
IF NOT EXISTS (SELECT * FROM Categories WHERE Name = N'Laptop Like New')
    INSERT INTO Categories (Name, Slug, Description, Status) VALUES (N'Laptop Like New', 'laptop-like-new', '', 1);
IF NOT EXISTS (SELECT * FROM Categories WHERE Name = N'Linh kiện - Phụ kiện')
    INSERT INTO Categories (Name, Slug, Description, Status) VALUES (N'Linh kiện - Phụ kiện', 'linh-kien-phu-kien', '', 1);

-- 2. Insert Products and ProductCategories
DECLARE @ProductId BIGINT;
DECLARE @CategoryId INT;
DECLARE @MainCategoryId INT;
SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Aspire 7 A715-59G-73LB NH.QX6SV.002 (Core i7-12650H, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-acer-aspire-7-a715-59g-73lb-nhqx6sv002-core-i7-12650h-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-1', N'CPU: Intel Core i7-12650H (up to 4.7GHz, 24MB, 10 nhân, 16 luồng) | RAM: 16GB (16GBx1) DDR4 3200MHz (2 slot, up to 32GB ) | Ổ cứng: 512GB SSD, PCIe Gen4, 16 Gb/s, NVMe | GPU: RTX 3050 6GB (supporting 2560 NVIDIA CUDA Cores) | Màn hình: 15.6 inch FHD (1920 x 1080) IPS SlimBezel, 144Hz | Webcam: HD camera | Cổng kết nối: 2 x USB Type C 2 x USB Standard-A ports, supporting: 1 port for USB 2.0, 1 port for USB 3.2 Gen 1 1 x HDMI 2.1 1 x headphone jack 3.5mm DC-in jack cho AC adapter Mini Displayport 1.4 | Trọng lượng: 2.07 kg | Pin: 54.8Wh 3-cell | Hệ điều hành: Window 11 bản quyền', 22590000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/04/Acer-Aspire-7-A715-59G-55MD-NH.QX6SV.005-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Yoga Pro 7 14S ASP9 (Ryzen AI 9 H365, 32GB, 1TB, 14.5 3K 120Hz Touch)', 'new-100-lenovo-yoga-pro-7-14s-asp9-ryzen-ai-9-h365-32gb-1tb-145-3k-120hz-touch-2', N'CPU: AMD Ryzen AI 9 H365 (10 nhân – 20 luồng, xung nhịp tối đa 5.0 GHz) | RAM: 32GB LPDDR5 7500 MHz | Ổ cứng: 1TB PCIe® 4.0 x4 NVME 2242 M.2 SSD | GPU: Intel® Arc™ 130T | Màn hình: 14 inch, 16:10, 3K, 120Hz, 100% DCI-P3 Touch | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 1 x USB-C 3.2 1 x USB-A 3.2 Gen 1 1 x HDMI 2.1 1 x USB 4 1 x Jack tai nghe | Pin: 4cell 73 Wh | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 32190000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/lenovo-yoga-7-pro-14-2024-h1_1732853477.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Vivobook S14 M3407GA-SF030W (Ryzen AI 7 445, 16GB, 512GB, 14 FHD+ OLED)', 'new-100-asus-vivobook-s14-m3407ga-sf030w-ryzen-ai-7-445-16gb-512gb-14-fhd-oled-3', N'CPU: AMD Ryzen™ AI 7 445 (2.00GHz up to 4.6 GHz, 14MB Cache); AMD XDNA™ NPU up to 50TOPS | Ram: 16GB DDR5 on board | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: AMD Radeon™ Graphics | Màn hình: 14″ FHD+ (1920 x 1200) 16:10 OLED, Glossy display, 60Hz, 300nits Brightness, 95% DCI-P3 color gamut, 1,000,000:1 contrast ratio, 1.07 billion colors | Webcam: 1080p FHD camera với nắp che linh hoạt | Cổng kết nối: 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-C with support for display / power delivery (data speed up to 5Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack | Trọng lượng: 1.40 kg | Pin: 70WHrs, 4S1P, 4-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 26890000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/04/ASUS-Vivobook-S14-M3407GA-SF030W-3.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Zenbook 14 UM3406GA-QD075WS (Ryzen AI 7 445, 16GB, 512GB, 14 FHD+ OLED)', 'new-100-asus-zenbook-14-um3406ga-qd075ws-ryzen-ai-7-445-16gb-512gb-14-fhd-oled-4', N'CPU: AMD Ryzen™ AI 7 445 (2.00GHz up to 4.6 GHz, 14MB Cache); AMD XDNA™ NPU lên đến 50TOPS | RAM: 16GB LPDDR5X on board | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: AMD Radeon™ Graphics | Màn hình: 14″ FHD+ (1920 x 1200) OLED 16:10, 60Hz, 0.2ms, 400nits, 600nits HDR peak brightness, 100% DCI-P3, VESA CERTIFIED Display HDR True Black 600, 1.07 billion colors, 1,000,000:1, TÜV Rheinland-certified, SGS Eye Care Display | Webcam: Camera FHD có chức năng IR hỗ trợ Windows Hello; Có nắp che vật lý | Cổng kết nối: 1x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x USB 3.2 Gen 2 Type-C with support for display / power delivery (data speed up to 10Gbps) 1x USB 4.0 Gen 3 Type-C with support for display / power delivery (data speed up to 40Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack | Pin: 75WHrs, 4S1P, 4-cell Li-ion | Trọng lượng: 1.2 kg | Hệ điều hành: Window 11 bản quyền', 29190000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/04/ASUS-Zenbook-14-UM3406-10.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MacBook Neo 2026 (Apple A18 Pro, 8GB, 256GB, 13 2.5K Liquid Retina) – Vàng Citrus', 'new-100-macbook-neo-2026-apple-a18-pro-8gb-256gb-13-25k-liquid-retina-vang-citrus-5', N'Loại card đồ họa: GPU 5 lõi Công nghệ dò tia tốc độ cao bằng phần cứng Neural Engine 16 lõi Băng thông bộ nhớ 60GB/s | Dung lượng RAM: 8GB | Ổ cứng: 256GB | Kích thước màn hình: 13 inches | Công nghệ màn hình: Màn hình Liquid Retina Màn hình có đèn nền LED Mật độ 219 pixel mỗi inch Độ sáng 500 nit Hỗ trợ 1 tỷ màu Màu sRGB Hỗ trợ một màn hình ngoài có độ phân giải gốc lên đến 4K ở tần số 60Hz | Pin: Thời gian xem video trực tuyến lên đến 16 giờ Thời gian duyệt web trên mạng không dây lên đến 11 giờ Pin lithium-ion 36.5 watt‑giờ tích hợp | Hệ điều hành: macOS | Độ phân giải màn hình: 2408 x 1506 pixels | Loại CPU: Chip Apple A18 Pro CPU 6 lõi với 2 lõi hiệu năng và 4 lõi tiết kiệm điện | Cổng giao tiếp: Một cổng USB 3 (USB-C) hỗ trợ: Sạc / DisplayPort / USB 3 (lên đến 10Gb/s) Một cổng USB 2 (USB-C) hỗ trợ: Sạc / USB 2 (lên đến 480Mb/s) Jack cắm tai nghe 3,5 mm', 16490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/MacBook-Neo-13-2026-vang.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 14 2024 (Xiaoxin Pro 14) (Ryzen 7-8745H, 24GB, 1TB, Radeon 780M, 14.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-14-2024-xiaoxin-pro-14-ryzen-7-8745h-24gb-1tb-radeon-780m-140-2k-oled-120hz-6', N'CPU: AMD Ryzen 7 8745H (8 cores x 16 threads, up to 4.9 GHz turbo boost) | RAM: 24GB LPDDR5x 7500Mhz | Ổ cứng: 01TB PCIe 4.0 NVMe M.2 SSD | GPU: AMD Radeon™ 780M | Màn hình: 14″ 2.8K (2880×1800) OLED 120Hz, tỷ lệ khung hình 16:10, độ sáng 400 nits | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 1x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1x USB-A (USB 5Gbps / USB 3.2 Gen 1), Always On 1x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x USB-C® (USB4® 40Gbps), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x SD card reader | Pin: 4 Cells, 84 Wh | Trọng lượng: ~1,46kg | Hệ điều hành: Window 11 bản quyền', 18990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-IdeaPad-5-Pro-14-XiaoXin-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Zenbook 14 UM3406KA 2026 (Ryzen AI 7-H 350, 32GB, 1TB, 14 3K OLED 120Hz)', 'new-100-asus-zenbook-14-um3406ka-2026-ryzen-ai-7-h-350-32gb-1tb-14-3k-oled-120hz-7', N'CPU: AMD Ryzen™ AI 7 350 Processor 2.0GHz (24MB Cache, up to 5.0GHz, 8 cores, 16 Threads); AMD XDNA™ NPU lên đến 50TOPS | RAM: 32GB LPDDR5X on board | Ổ cứng: 1TB M.2 NVMe™ PCIe® 4.0 SSD | GPU: AMD Radeon™ Graphics | Màn hình: 14 inch 3K (2880 x 1800) OLED 16:10 120Hz/0.2ms, 400 nits, 100% DCI-P3 Glossy display, TÜV Rheinland-certified | Webcam: Camera FHD có chức năng IR hỗ trợ Windows Hello; Có nắp che vật lý | Cổng kết nối: 1x USB 3.2 Gen 1 Type-A (tốc độ dữ liệu lên đến 5Gbps) 1x USB 3.2 Gen 2 Type-C (hỗ trợ xuất hình ảnh/sạc, tốc độ dữ liệu lên đến 10Gbps) 1x USB 4.0 Gen 3 Type-C (hỗ trợ xuất hình ảnh/sạc, tốc độ dữ liệu lên đến 40Gbps) 1x HDMI 2.1 TMDS 1x Giắc âm thanh combo 3.5mm | Pin: 75WHrs, 4S1P, 4-cell Li-ion | Trọng lượng: 1.2 kg | Hệ điều hành: Window 11 bản quyền', 27890000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Asus-Zenbook-14-UM3406KA-2.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 16 G8+ 2026 (Ryzen 7 H 255, 32GB, 1TB, 16 3K+ 165Hz) – Lunar Grey', 'new-100-lenovo-thinkbook-16-g8-2026-ryzen-7-h-255-32gb-1tb-16-3k-165hz-lunar-grey-8', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~4.9GHz, 8MB L2 Cache, 16MB L3 Cache) | RAM: 32GB LPDDR5x 7500MHz, onboard | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD | GPU: AMD Radeon™ 780M | Màn hình: 16″ 3K (3200 × 2000) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 500nits, tần số quét 165Hz, 100% sRGB, 100% DCI-P3 | Webcam: 1080p IR RGB camera, cùng 2 mic thu tầm xa và màn trập cơ học Privacy Shutter | Cổng kết nối: 1x Cổng mạng LAN, 2x cổng USB-A 3.2 Gen 1, 1x khe đọc-ghi thẻ SD, 1x Khe cắm chìm USB-A 2.0 1x cổng HDMI 2.1, 2x cổng USB4 type C (có thể sạc 140W), 1x jack tai nghe, 1x Cổng TGX (cắm eGPU) | Pin: 4 cell 99.9wh hỗ trợ sạc nhanh, củ sạc 140w GaN-C | Trọng lượng: 1.5 kg | Hệ điều hành: Window 11 bản quyền', 28590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Lenovo-Thinkbook-16-G8-2026-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 14 G8+ 2026 (Ryzen 7 H 255, 32GB, 1TB, 14.5 3K 120Hz) – Lunar Grey', 'new-100-lenovo-thinkbook-14-g8-2026-ryzen-7-h-255-32gb-1tb-145-3k-120hz-lunar-grey-9', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~4.9GHz, 8MB L2 Cache, 16MB L3 Cache) | RAM: 32GB LPDDR5x 7500MHz, onboard | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD | GPU: AMD Radeon™ 780M | Màn hình: 14.5″ 3K (3072 × 1920) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 500nits, tần số quét 120Hz, 100% sRGB, 100% DCI-P3 | Webcam: 1080p IR RGB camera, cùng 2 mic thu tầm xa và màn trập cơ học Privacy Shutter | Cổng kết nối: 1x Cổng mạng LAN, 2x cổng USB-A 3.2 Gen 1, 1x khe đọc-ghi thẻ SD, 1x Khe cắm chìm USB-A 2.0 1x cổng HDMI 2.1, 2x cổng USB4 type C (có thể sạc 140W), 1x jack tai nghe, 1x Cổng TGX (cắm eGPU) | Pin: 4 cell 99.9wh hỗ trợ sạc nhanh, củ sạc 140w GaN-C | Trọng lượng: 1.5 kg | Hệ điều hành: Window 11 bản quyền', 27490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Lenovo-Thinkbook-14-G8-2026-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 14 G8+ 2026 (Ryzen 7 H 255, 32GB, 1TB, 14.5 3K 120Hz) – White', 'new-100-lenovo-thinkbook-14-g8-2026-ryzen-7-h-255-32gb-1tb-145-3k-120hz-white-10', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~4.9GHz, 8MB L2 Cache, 16MB L3 Cache) | RAM: 32GB LPDDR5x 7500MHz, onboard | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD | GPU: AMD Radeon™ 780M | Màn hình: 14.5″ 3K (3072 × 1920) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 500nits, tần số quét 120Hz, 100% sRGB, 100% DCI-P3 | Webcam: 1080p IR RGB camera, cùng 2 mic thu tầm xa và màn trập cơ học Privacy Shutter | Cổng kết nối: 1x Cổng mạng LAN, 2x cổng USB-A 3.2 Gen 1, 1x khe đọc-ghi thẻ SD, 1x Khe cắm chìm USB-A 2.0 1x cổng HDMI 2.1, 2x cổng USB4 type C (có thể sạc 140W), 1x jack tai nghe, 1x Cổng TGX (cắm eGPU) | Pin: 4 cell 99.9wh hỗ trợ sạc nhanh, củ sạc 140w GaN-C | Trọng lượng: 1.5 kg | Hệ điều hành: Window 11 bản quyền', 27490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Thinkbook-14-G8-2026-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo Pro 14 2025 (Ryzen 7 H 255, 32GB, 1TB, AMD Radeon 780M, 14 2K+ 120Hz)', 'new-100-lenovo-lecoo-pro-14-2025-ryzen-7-h-255-32gb-1tb-amd-radeon-780m-14-2k-120hz-11', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, có thể đạt tới 4.9GHz với turbo boost, 24MB Cache) | RAM: 32GB DDR5-5600MHz (hỗ trợ nâng cấp) | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD (2 slots) | GPU: AMD Radeon™ 780M | Màn hình: 14″, 2.8K (2880×1800) IPS, LED, độ sáng 400nits, tỷ lệ khung hình 16:10, độ phủ màu 100% sRGB, tần số quét màn 120Hz, màn giảm ánh sáng xanh bảo vệ mắt, DC dimmer | Webcam: FHD camera | Cổng kết nôi: 1x khe đọc ghi thẻ microSD, 1x jack tai nghe, 3x cổng USB-A 3.2 Gen 1, 1x cổng mạng LAN, 1x cổng USB-C 3.2 Gen 2 (cũng là cổng sạc máy), 1x cổng USB4, HDMI 2.1, 1x cổng Oculink (chính là cổng TGX như trên Thinkbook 14 G7+ được sử dụng để kết nối với e-GPU) | Trọng lượng: 1.43 kg | Pin: 80wh | Hệ điều hành: Windows 11 bản quyền', 21490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/lenovo-lecoo-pro-14-2025-thegioiso365-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Aspire 7 A715-59G-55MD NH.QX6SV.005 (Core i5-13420H, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-acer-aspire-7-a715-59g-55md-nhqx6sv005-core-i5-13420h-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-12', N'CPU: Intel Core i5-13420H (up to 4.6GHz, 12MB, 8 nhân, 12 luồng) | RAM: 16GB (16GBx1) DDR4 3200MHz (2 slot, up to 32GB ) | Ổ cứng: 512GB SSD, PCIe Gen4, 16 Gb/s, NVMe | GPU: RTX 3050 6GB (supporting 2560 NVIDIA CUDA Cores) | Màn hình: 15.6 inch FHD (1920 x 1080) IPS SlimBezel, 144Hz | Webcam: HD camera | Cổng kết nối: 2 x USB Type C 2 x USB Standard-A ports, supporting: 1 port for USB 2.0, 1 port for USB 3.2 Gen 1 1 x HDMI 2.1 1 x headphone jack 3.5mm DC-in jack cho AC adapter Mini Displayport 1.4 | Trọng lượng: 2.07 kg | Pin: 54.8Wh 3-cell | Hệ điều hành: Window 11 bản quyền', 22990000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/04/Acer-Aspire-7-A715-59G-55MD-NH.QX6SV.005-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MacBook Neo 2026 (Apple A18 Pro, 8GB, 256GB, 13 2.5K Liquid Retina) – Hồng Phớt', 'new-100-macbook-neo-2026-apple-a18-pro-8gb-256gb-13-25k-liquid-retina-hong-phot-13', N'Loại card đồ họa: GPU 5 lõi Công nghệ dò tia tốc độ cao bằng phần cứng Neural Engine 16 lõi Băng thông bộ nhớ 60GB/s | Dung lượng RAM: 8GB | Ổ cứng: 256GB | Kích thước màn hình: 13 inches | Công nghệ màn hình: Màn hình Liquid Retina Màn hình có đèn nền LED Mật độ 219 pixel mỗi inch Độ sáng 500 nit Hỗ trợ 1 tỷ màu Màu sRGB Hỗ trợ một màn hình ngoài có độ phân giải gốc lên đến 4K ở tần số 60Hz | Pin: Thời gian xem video trực tuyến lên đến 16 giờ Thời gian duyệt web trên mạng không dây lên đến 11 giờ Pin lithium-ion 36.5 watt‑giờ tích hợp | Hệ điều hành: macOS | Độ phân giải màn hình: 2408 x 1506 pixels | Loại CPU: Chip Apple A18 Pro CPU 6 lõi với 2 lõi hiệu năng và 4 lõi tiết kiệm điện | Cổng giao tiếp: Một cổng USB 3 (USB-C) hỗ trợ: Sạc / DisplayPort / USB 3 (lên đến 10Gb/s) Một cổng USB 2 (USB-C) hỗ trợ: Sạc / USB 2 (lên đến 480Mb/s) Jack cắm tai nghe 3,5 mm', 16490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/MacBook-Neo-13-2026-hong-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MacBook Neo 2026 (Apple A18 Pro, 8GB, 256GB, 13 2.5K Liquid Retina) – Bạc', 'new-100-macbook-neo-2026-apple-a18-pro-8gb-256gb-13-25k-liquid-retina-bac-14', N'Loại card đồ họa: GPU 5 lõi Công nghệ dò tia tốc độ cao bằng phần cứng Neural Engine 16 lõi Băng thông bộ nhớ 60GB/s | Dung lượng RAM: 8GB | Ổ cứng: 256GB | Kích thước màn hình: 13 inches | Công nghệ màn hình: Màn hình Liquid Retina Màn hình có đèn nền LED Mật độ 219 pixel mỗi inch Độ sáng 500 nit Hỗ trợ 1 tỷ màu Màu sRGB Hỗ trợ một màn hình ngoài có độ phân giải gốc lên đến 4K ở tần số 60Hz | Pin: Thời gian xem video trực tuyến lên đến 16 giờ Thời gian duyệt web trên mạng không dây lên đến 11 giờ Pin lithium-ion 36.5 watt‑giờ tích hợp | Hệ điều hành: macOS | Độ phân giải màn hình: 2408 x 1506 pixels | Loại CPU: Chip Apple A18 Pro CPU 6 lõi với 2 lõi hiệu năng và 4 lõi tiết kiệm điện | Cổng giao tiếp: Một cổng USB 3 (USB-C) hỗ trợ: Sạc / DisplayPort / USB 3 (lên đến 10Gb/s) Một cổng USB 2 (USB-C) hỗ trợ: Sạc / USB 2 (lên đến 480Mb/s) Jack cắm tai nghe 3,5 mm', 16490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/MacBook-Neo-13-2026-bac-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MacBook Neo 2026 (Apple A18 Pro, 8GB, 256GB, 13 2.5K Liquid Retina) – Xanh Indigo', 'new-100-macbook-neo-2026-apple-a18-pro-8gb-256gb-13-25k-liquid-retina-xanh-indigo-15', N'Loại card đồ họa: GPU 5 lõi Công nghệ dò tia tốc độ cao bằng phần cứng Neural Engine 16 lõi Băng thông bộ nhớ 60GB/s | Dung lượng RAM: 8GB | Ổ cứng: 256GB | Kích thước màn hình: 13 inches | Công nghệ màn hình: Màn hình Liquid Retina Màn hình có đèn nền LED Mật độ 219 pixel mỗi inch Độ sáng 500 nit Hỗ trợ 1 tỷ màu Màu sRGB Hỗ trợ một màn hình ngoài có độ phân giải gốc lên đến 4K ở tần số 60Hz | Pin: Thời gian xem video trực tuyến lên đến 16 giờ Thời gian duyệt web trên mạng không dây lên đến 11 giờ Pin lithium-ion 36.5 watt‑giờ tích hợp | Hệ điều hành: macOS | Độ phân giải màn hình: 2408 x 1506 pixels | Loại CPU: Chip Apple A18 Pro CPU 6 lõi với 2 lõi hiệu năng và 4 lõi tiết kiệm điện | Cổng giao tiếp: Một cổng USB 3 (USB-C) hỗ trợ: Sạc / DisplayPort / USB 3 (lên đến 10Gb/s) Một cổng USB 2 (USB-C) hỗ trợ: Sạc / USB 2 (lên đến 480Mb/s) Jack cắm tai nghe 3,5 mm', 16490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/MacBook-Neo-13-2026-xanh-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 16P G6 ADR 2026 (Ryzen 9-8945HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-thinkbook-16p-g6-adr-2026-ryzen-9-8945hx-32gb-1tb-rtx-5060-8gb-16-2k-240hz-16', N'CPU: MD Ryzen™ 9 8945HX  (16 nhân 32 luồng, xung nhịp cơ bản từ 2.5GHz có thể đạt max với turbo boost tới 5.4GHz, L2 Cache 16MB, L3 Cache 64MB, Default TDP 55W) | RAM: 32GB DDR5 5200MHz, có 2 slot RAM đang lắp 2 thanh 16GB | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD, có 2 slot SSD | GPU: MD Radeon™ 610M + NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ 2.5K (2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, tỷ lệ tương phản 1200:1, độ sáng 500nits, tần số quét 240Hz, 100% DCI-P3, HDR400,  chỉ số DeltaE <1, Dolby® Vison, NVIDIA® G-SYNC®, TÜV Low Blue Light | Camera: HD camera (720P) | Kết nối: 3x USB-A 2x USB-C 3.2 Gen 2 1x khe đọc-ghi thẻ SD 1x HDMI 1x cổng cắm sạc 1x khe khóa vật lý Kensington 1x jack tai nghe | Trọng lượng: 2.15kg | Pin: 4cell, 85wh | Hệ điều hành: Windows 11 bản quyền', 40490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Thinkbook-16P-G6-ADR-2026-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell 15 DC15250 2025 (Core i7 1355U, 16GB, 1TB, 15.6 FHD 120Hz Touch)', 'new-100-dell-15-dc15250-2025-core-i7-1355u-16gb-1tb-156-fhd-120hz-touch-17', N'CPU: Core i7 1355U (10C/12T, 12MB, up to 5.00 GHz) | RAM: 16GB DDR4 3200 MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: Intel UHD Graphics | Màn hình: 15.6″ FHD (1920×1080), 120Hz, Touch, WVA/IPS (Wide Viewing Angle), 250 nits, 45% NTSC, Anti glare | Webcam: FHD | Cổng kết nối: 1 HDMI 1.4 port 1 USB 3.2 Gen 1 port 1 USB 2.0 port 1 USB 3.2 Gen 1 Type-C port 1 SD-card slot 1 universal audio port | Pin: 3 cell – 41Whr | Trọng lượng: 1.66 Kg | Hệ điều hành: Window 11 bản quyền', 20690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/60660_60661_laptop_dell_15_dc15250_7.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell 15 DC15255 (Ryzen 7-7730U, 16GB, 512GB, 15.6 FHD Touch)', 'new-100-dell-15-dc15255-ryzen-7-7730u-16gb-512gb-156-fhd-touch-18', N'CPU: Ryzen 7-7730U (8C/16T, 16MB, up to 4.50 GHz) | RAM: 16GB DDR4 3200 MT/s | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: AMD Radeon™ Graphics | Màn hình: 15.6″ FHD (1920×1080), 60Hz, Touch, WVA/IPS (Wide Viewing Angle), 250 nits, 45% NTSC, Anti glare | Webcam: FHD | Cổng kết nối: 1 HDMI 1.4 port 1 USB 3.2 Gen 1 port 1 USB 2.0 port 1 USB 3.2 Gen 1 Type-C port 1 SD-card slot 1 universal audio port | Pin: 3 cell – 41Whr | Trọng lượng: 1.66 Kg | Hệ điều hành: Window 11 bản quyền', 17490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Dell-15-DC15250-2025-thegioiso365.vn-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 2025 (Xiaoxin Pro 16 IMH9) (Ultra 7 155H, 16GB, 2TB, RTX 3050 6GB, 16.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-16-2025-xiaoxin-pro-16-imh9-ultra-7-155h-16gb-2tb-rtx-3050-6gb-160-2k-oled-120hz-19', N'CPU: Intel Core Ultra 7 155H (1.40GHz up to 4.80GHz, 24MB Cache) | RAM: 16GB LPDDR5x 7500Mhz | Ổ cứng: 2TB (1TBx2) SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 16.0inch 2K (2048×1280) OLED, 500nits, Glossy, 100% DCI-P3, 120Hz, Eyesafe®, DisplayHDR™ True Black 500 | Webcam: 1080p IR | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,91kg | Hệ điều hành: Window 11 bản quyền', 24990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-XiaoXin-Pro-16-2024-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 2025 (XiaoXin Pro 16GT AI) (Ryzen AI 7 H 350, 24GB, 2TB, 16.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-16-2025-xiaoxin-pro-16gt-ai-ryzen-ai-7-h-350-24gb-2tb-160-28k-oled-120hz-20', N'CPU: AMD Ryzen™ AI 7 H 350 (8 nhân – 16 luồng, 2 Ghz – 5.0 Ghz, 16MB Cache) | RAM: 24GB DDR5 8000 Mhz | Ổ cứng: 2TB M.2 NVMe PCIe SSD | GPU: AMD Radeon 860M | Màn hình: 16 inch, 2.8K (2880×1800), OLED, 100% sRGB, 100% DCI-P3, 120Hz, 1100 nits | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 84Wh | Trọng lượng: 1.72 kg | Hệ điều hành: Window 11 bản quyền', 21590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Iw2NQ1UaijAReklQLUg5oisly-9064.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 (Xiaoxin Pro 16 AHP9) (Ryzen 5 8645HS, 16GB, 512GB, RTX 3050 6GB, 16.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-16-xiaoxin-pro-16-ahp9-ryzen-5-8645hs-16gb-512gb-rtx-3050-6gb-160-2k-oled-120hz-21', N'CPU: AMD Ryzen™ 5 8645H (4.30GHz up to 5.00GHz, 16MB Cache) | RAM: 16GB LPDDR5x 6400Mhz | Ổ cứng: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 16.0inch 2K (2048×1280) OLED, 500nits, Glossy, 100% DCI-P3, 120Hz, Eyesafe®, DisplayHDR™ True Black 500 | Webcam: 1080p IR | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,91kg | Hệ điều hành: Window 11 bản quyền', 20590000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-XiaoXin-Pro-16-2024-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 14 2025 (XiaoXin Pro 14c) (Ryzen AI 7 H 350, 32GB, 1TB, 14.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-14-2025-xiaoxin-pro-14c-ryzen-ai-7-h-350-32gb-1tb-140-28k-oled-120hz-22', N'CPU: AMD Ryzen™ AI 7 H 350 (8 nhân – 16 luồng, 2 Ghz – 5.0 Ghz, 16MB Cache) | RAM: 32GB DDR5 5600 Mhz | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: AMD Radeon 860M | Màn hình: 14″ 2.8K (2880×1800), OLED, 100% sRGB, 100% DCI-P3, 120Hz, 1100 nits | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 60Wh | Trọng lượng: 1.39 kg | Hệ điều hành: Window 11 bản quyền', 23590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/XiaoXin-Pro-14c-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c AHP10) (Ryzen 7-8840HS, 16GB, 512GB, AMD 780M, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ahp10-ryzen-7-8840hs-16gb-512gb-amd-780m-14-fhd-23', N'CPU: AMD Ryzen™ 7 8840HS (3.3 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB LPDDR5X 5600MHz  (onboard 8GB + 1 thanh 8GB ) | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 780M | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 13990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/IdeaPad-Slim-3-14IRH10R-CT2-01-w.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 14 2025 (XiaoXin Pro 14 GT) (Core Ultra 5 225H, 32GB, 1TB, 14.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-14-2025-xiaoxin-pro-14-gt-core-ultra-5-225h-32gb-1tb-140-2k-oled-120hz-24', N'CPU: Intel® Core™ Ultra 5 225H (14 nhân 14 luồng, xung nhịp tối đa có thể đạt P-core 4.9GHz / E-core 4.3GHz, 18 MB Intel® Smart Cache) Intel AI Boost | RAM: 32GB LPDDR5x 8533 onboard | Ổ cứng: 1TB PCIe® 4.0 x4 NVME 2242 M.2 SSD | GPU: Intel® Arc™ 130T | Màn hình: 14″ 2.8K (2880×1800) OLED, màn gương, 120Hz, 16:10, upto 1100nits, Eyesafe® Certified 2.0, DisplayHDR™ True Black 1000 | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 1 x HDMI 2.1 2 x USB-C Thunderbolt 4 1 x SD full size 2 x USB-A 3.2 Gen 1 1 x Jack 3.5mm | Pin: 4cell 84wh | Trọng lượng: 1.39 kg | Hệ điều hành: Window 11 bản quyền', 25690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/ideapad-5-pro-2025-h1_1742026720.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c) (Core i5-13420H, 16GB, 512GB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-14c-core-i5-13420h-16gb-512gb-14-fhd-25', N'CPU: Intel Core i5-13420H, P-core 2.1GHz up to 4.6GHz, E-core 1.5GHz up to 3.4GHz, 12MB | RAM: 16 GB DDR5 4800Mhz (8GB Soldered + 8GB SO-DIMM), hỗ trợ tối đa 24GB | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel UHD Graphics | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 13490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3598_lenovo_xiaoxin_14c_ahp10_1-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 16IRH10 83K20002VN (Core i5-13420H, 16GB, 512GB, 16 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-16irh10-83k20002vn-core-i5-13420h-16gb-512gb-16-fhd-26', N'CPU: Intel Core i5-13420H (3.4 GHz up to 4.6 GHz, 8 Cores, 12 Threads, 12MB Cache) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® UHD Graphics | Màn hình: 16″ FHD+ (1920×1200) IPS, màn nhám, chống lóa, không cảm ứng, tần số quét màn 60Hz, tỷ lệ khung hình 16:10, độ sáng 300nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x SD Card Reader 1x USB-C® 3.2 Gen 2 1x HDMI 1x Headphone / microphone combo jack (3.5mm) 1x DC-N power port | Pin: 50 Wh | Trọng lượng: ~1,8 kg | Hệ điều hành: Window 11 bản quyền', 14690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/lenovo_ideapad_slim_3_16irh10_luna_grey_1_7112d5f200.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 16c APH10) (Ryzen 7-8745HS, 16GB, 512GB, AMD 780M, 16 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-16c-aph10-ryzen-7-8745hs-16gb-512gb-amd-780m-16-fhd-27', N'CPU: AMD Ryzen™ 7 8745HS (3.8 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB (8GB onboard + 8GB in slot) (ram hỗ trợ DDR5 5600MHz) | Ổ cứng: 512 GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 780M | Màn hình: 16″ FHD+ (1920×1200) IPS, màn nhám, chống lóa, không cảm ứng, tần số quét màn 60Hz, tỷ lệ khung hình 16:10, độ sáng 300nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x SD Card Reader 1x USB-C® 3.2 Gen 2 1x HDMI 1x Headphone / microphone combo jack (3.5mm) 1x DC-N power port | Pin: 50 Wh | Trọng lượng: ~1,8 kg | Hệ điều hành: Window 11 bản quyền', 14690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3651_ideapad_slim_3_16_2025__6_-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 14IRH10 83K00008VN (Core i5-13420H, 16GB, 512GB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-14irh10-83k00008vn-core-i5-13420h-16gb-512gb-14-fhd-28', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 16GB (8GB Soldered DDR5-4800MHz + 8GB SO-DIMM DDR5-4800MHz) (Up to 24GB) | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® UHD Graphics | Màn hình: 14 inch FHD+ (1920×1200) IPS, 300nits, Anti-glare, 45% NTSC | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,39kg | Hệ điều hành: Window 11 bản quyền', 14690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/51729_laptop_lenovo_ideapad_slim_3_14irh10_83k00008vn__3_-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 14 2025 (XiaoXin Pro 14c) (Ryzen 7 H 255, 24GB, 1TB, 14.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-14-2025-xiaoxin-pro-14c-ryzen-7-h-255-24gb-1tb-140-28k-oled-120hz-29', N'CPU: AMD Ryzen™ AI 7 H 255 (8 nhân – 16 luồng, 2 Ghz – 4.9 Ghz, 16MB Cache) | RAM: 24GB DDR5 5600 Mhz | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: AMD Radeon 780M | Màn hình: 14″ 2.8K (2880×1800), OLED, 100% sRGB, 100% DCI-P3, 120Hz, 1100 nits | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 60Wh | Trọng lượng: 1.39 kg | Hệ điều hành: Window 11 bản quyền', 19190000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3846_screenshot_2025_05_20_195610.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 (XiaoXin 16 AHP9) (Ryzen 7 8745H, 16GB, 512GB, AMD 780M, 16 FHD+ IPS)', 'new-100-lenovo-ideapad-slim-5-xiaoxin-16-ahp9-ryzen-7-8745h-16gb-512gb-amd-780m-16-fhd-ips-30', N'CPU: AMD Ryzen™ 7 8745H (3.2 GHz up to 4.9 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB LPDDR5X 6400MHz | Ổ cứng: 512 GB M.2 NVMe PCIe SSD | CPU: AMD Radeon Graphic 780M | Màn hình: 16 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: 1080P Full HD IR Camera With Face Recognition | Cổng kết nối: 2x cổng USB-C 3.2 Gen 2 1x HDMI 1x Jack tai nghe 3.5mm 1x khe đọc ghi thẻ MicroSD 2x cổng USB-A 3.2 Gen 1 | Trọng lượng: 1.89 kg | Pin: 57Wh 100W Type – C | Hệ điều hành: Windows 11 bản quyền', 15090000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/photo_2024-12-25_19-58-12-copy-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 (Xiaoxin Pro 16 AHP9) (Ryzen 7-8845H, 32GB, 1TB, Radeon 780M, 16.0 2K+)', 'new-100-lenovo-ideapad-5-pro-16-xiaoxin-pro-16-ahp9-ryzen-7-8845h-32gb-1tb-radeon-780m-160-2k-31', N'CPU: AMD Ryzen 7 8845H (8 cores x 16 threads, up to 5.1 GHz turbo boost) | RAM: 32GB LPDDR5x 7500Mhz | Ổ cứng: SSD 01TB SSD PCIe 4.0 | GPU: AMD Radeon™ 780M Graphics | Màn hình: 16″ 2K+, 100% sRGB, 350 nits | Webcam: 1080p IR | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,91kg | Hệ điều hành: Window 11 bản quyền', 20590000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-XiaoXin-Pro-16-2024-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 16c APH10) (Ryzen 5-8640HS, 16GB, 512GB, AMD 760M, 16 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-16c-aph10-ryzen-5-8640hs-16gb-512gb-amd-760m-16-fhd-32', N'CPU: AMD Ryzen™ 5-8640HS (3.5 GHz up to 4.9 GHz, 6 Cores, 12 Threads, 16MB Cache) | RAM: 16GB (8GB onboard + 8GB in slot) (ram hỗ trợ DDR5 5600MHz) | Ổ cứng: 512 GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 760M | Màn hình: 16″ FHD+ (1920×1200) IPS, màn nhám, chống lóa, không cảm ứng, tần số quét màn 60Hz, tỷ lệ khung hình 16:10, độ sáng 300nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x SD Card Reader 1x USB-C® 3.2 Gen 2 1x HDMI 1x Headphone / microphone combo jack (3.5mm) 1x DC-N power port | Pin: 50 Wh | Trọng lượng: ~1,8 kg | Hệ điều hành: Window 11 bản quyền', 12490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3651_ideapad_slim_3_16_2025__6_-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c) (Ryzen 7 7735HS, 16GB, 1TB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ryzen-7-7735hs-16gb-1tb-14-fhd-33', N'CPU: AMD Ryzen™ 7 7735HS (3.2 GHz up to 4.75 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 680M | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 14590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/IdeaPad-Slim-3-14IRH10R-CT2-01-w.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c) (Ryzen 7 7735HS, 24GB, 512GB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ryzen-7-7735hs-24gb-512gb-14-fhd-34', N'CPU: AMD Ryzen™ 7 7735HS (3.2 GHz up to 4.75 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 24GB DDR5 5600MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 680M | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 17990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/IdeaPad-Slim-3-14IRH10R-CT2-01-w.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 16 2025 (XiaoXin Pro 16c) (Ryzen 7 H 255, 24GB, 1TB, 16.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-16-2025-xiaoxin-pro-16c-ryzen-7-h-255-24gb-1tb-160-28k-oled-120hz-35', N'CPU: AMD Ryzen™ AI 7 H 255 (8 nhân – 16 luồng, 2 Ghz – 4.9 Ghz, 16MB Cache) | RAM: 24GB DDR5 5600 Mhz | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: AMD Radeon 780M | Màn hình: 16 inch, OLED 2.8K (2880×1800), 1100 nits, 120Hz, 100% sRGB | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 80Wh | Trọng lượng: 1.76 kg | Hệ điều hành: Window 11 bản quyền', 20190000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/ideapad-slim-5-2025-16-ai-h1_1742808678.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 15 2025 (Xiaoxin 15c AHP10) (Ryzen 5 8640HS, 8GB, 512GB, AMD 760M, 15.3 FHD+)', 'new-100-lenovo-ideapad-slim-3-15-2025-xiaoxin-15c-ahp10-ryzen-5-8640hs-8gb-512gb-amd-760m-153-fhd-36', N'CPU: AMD Ryzen™ 5 8640HS (3.5 GHz up to 4.9 GHz, 6 Cores, 12 Threads, 16MB Cache) | RAM: 8GB DDR5 5600MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 760M | Màn hình: 15.3″ FHD+(1920×1200) | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x USB-C® (USB 5Gbps) tích hợp tính năng PD 3.0 & DP 1.2 1x HDMI 1x khe đọc-ghi thẻ SD 1x jack tai nghe 3.5 | Pin: 60 Wh | Trọng lượng: ~1,49 kg | Hệ điều hành: Window 11 bản quyền', 12190000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/ideapad_slim_3_15cahp10_2025_0.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 14 2025 (XiaoXin Pro 14c) (Intel Core 5 220H, 24GB, 1TB, 14.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-14-2025-xiaoxin-pro-14c-intel-core-5-220h-24gb-1tb-140-28k-oled-120hz-37', N'CPU: Intel® Core™ 5 220H (12 nhân 16 luồng, xung nhịp cơ bản 2.7GHz, xung nhịp tối đa có thể đạt 4.9GHz, 18 MB Intel® Smart Cache) | RAM: 24GB DDR5 (không nâng cấp ram) | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: Intel® Graphics | Màn hình: 14-inch 2.8K 120Hz 16:10 (2880×1800), OLED, 120Hz ,600 nits, 100% DCI-P3, HDR True Black 500 | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 60Wh | Trọng lượng: 1.39 kg | Hệ điều hành: Window 11 bản quyền', 18290000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/XiaoXin-Pro-14c-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c) (Core 7-240H, 8GB, 512GB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-14c-core-7-240h-8gb-512gb-14-fhd-38', N'CPU: Core 7-240H (2.5 GHz up to 5.2 GHz, 10 Cores, 16 Threads, 24MB Cache) | RAM: 8GB DDR5 5600MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® Graphics | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,39kg | Hệ điều hành: Window 11 bản quyền', 14390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3598_lenovo_xiaoxin_14c_ahp10_1-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 2025 (XiaoXin Pro 16 GT) (Core Ultra 5 225H, 32GB, 1TB, 16.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-16-2025-xiaoxin-pro-16-gt-core-ultra-5-225h-32gb-1tb-160-2k-oled-120hz-39', N'CPU: Intel® Core™ Ultra 5 225H (14 nhân 14 luồng, xung nhịp tối đa có thể đạt P-core 4.9GHz / E-core 4.3GHz, 18 MB Intel® Smart Cache) Intel AI Boost | RAM: 32GB LPDDR5x 8533 onboard | Ổ cứng: 1TB PCIe® 4.0 x4 NVME 2242 M.2 SSD | GPU: Intel® Arc™ 130T | Màn hình: 16 inch, 2.8K (2880×1800), OLED, 100% sRGB, 100% DCI-P3, 120Hz, 1100 nits | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 1 x HDMI 2.1 2 x USB-C Thunderbolt 4 1 x SD full size 2 x USB-A 3.2 Gen 1 1 x Jack 3.5mm | Pin: 4cell 84wh | Trọng lượng: 1.72 kg | Hệ điều hành: Window 11 bản quyền', 25690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/GFsxlpobUR6vBuI60xgyXTX3E-4132.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Zenbook 14 UX3405 2025 (Ultra 9 285H, 32GB, 1TB, 14 3K 120Hz OLED) – Ponder Blue', 'new-100-asus-zenbook-14-ux3405-2025-ultra-9-285h-32gb-1tb-14-3k-120hz-oled-ponder-blue-40', N'CPU: Intel® Core™ Ultra 9-285H (24MB Cache, 2.5 GHz – 5.4 GHz, 16 nhân, 16 luồng) | RAM: 32GB LPDDR5X | Ổ cứng: 01TB SSD | GPU: Intel® Arc™ Graphics | Màn hình: 14 inch 2.8K (2880 x 1800) OLED 16:10 LED 400nits/550 HDR 120Hz | Webcam: FHD camera with IR function to support Windows Hello With privacy shutter | Cổng kết nối: 1x USB 3.2 Gen 1 Type-A 2x Thunderbolt 4 supports display / power delivery 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack | Pin: 75WHrs, 2S2P, 4-cell Li-ion | Trọng lượng: 1.2 kg | Hệ điều hành: Window 11 bản quyền', 31890000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3781_zenbook_14_ux3405ca_product_4_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Zenbook 14 UX3405 2025 (Ultra 9 285H, 32GB, 1TB, 14 3K 120Hz OLED) – Foggy Silver', 'new-100-asus-zenbook-14-ux3405-2025-ultra-9-285h-32gb-1tb-14-3k-120hz-oled-foggy-silver-41', N'CPU: Intel® Core™ Ultra 9-285H (24MB Cache, 2.5 GHz – 5.4 GHz, 16 nhân, 16 luồng) | RAM: 32GB LPDDR5X | Ổ cứng: 01TB SSD | GPU: Intel® Arc™ Graphics | Màn hình: 14 inch 2.8K (2880 x 1800) OLED 16:10 LED 400nits/550 HDR 120Hz | Webcam: FHD camera with IR function to support Windows Hello With privacy shutter | Cổng kết nối: 1x USB 3.2 Gen 1 Type-A 2x Thunderbolt 4 supports display / power delivery 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack | Pin: 75WHrs, 2S2P, 4-cell Li-ion | Trọng lượng: 1.2 kg | Hệ điều hành: Window 11 bản quyền', 31990000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3606_asus_zenbook_14_ux3405_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 16 2025 (XiaoXin Pro 16c) (Ryzen AI 7 H 350, 32GB, 1TB, 16.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-16-2025-xiaoxin-pro-16c-ryzen-ai-7-h-350-32gb-1tb-160-28k-oled-120hz-42', N'CPU: AMD Ryzen AI 7 H 350 (2 GHz up to 5 GHz, 8 Cores, 16 Threads, 24MB Cache) | RAM: 32GB LPDDR5x-8000 MHz | Ổ cứng: 1TB PCIe NVMe M.2 SSD gen 4 | GPU: AMD Radeon 860M | Màn hình: 16 inch, OLED 2.8K (2880×1800), 1100 nits, 120Hz, 100% sRGB | Webcam: 1080P FHD RGB/IR Hybrid with Dual Microphone | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 80Wh | Trọng lượng: 1.76 kg | Hệ điều hành: Window 11 bản quyền', 25390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/ideapad-slim-5-2025-16-ai-h1_1742808678.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 16c) (Core i5-13420H, 16GB, 512GB, 16 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-16c-core-i5-13420h-16gb-512gb-16-fhd-43', N'CPU: Intel Core i5-13420H (3.4 GHz up to 4.6 GHz, 8 Cores, 12 Threads, 12MB Cache) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® UHD Graphics | Màn hình: 16″ FHD+ (1920×1200) IPS, màn nhám, chống lóa, không cảm ứng, tần số quét màn 60Hz, tỷ lệ khung hình 16:10, độ sáng 300nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x SD Card Reader 1x USB-C® 3.2 Gen 2 1x HDMI 1x Headphone / microphone combo jack (3.5mm) 1x DC-N power port | Pin: 50 Wh | Trọng lượng: ~1,8 kg | Hệ điều hành: Window 11 bản quyền', 14690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3651_ideapad_slim_3_16_2025__6_-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 16 2025 (XiaoXin Pro 16) (Core 5 220H, 24GB, 1TB, 16.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-16-2025-xiaoxin-pro-16-core-5-220h-24gb-1tb-160-28k-oled-120hz-44', N'CPU: Intel® Core™ 5 220H (12 nhân, 16 luồng, xung nhịp 2.7 Ghz – 4.9 Ghz, L3 Cache 18MB) | RAM: 24GB DDR5 4800 MHz | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: Intel® Graphics | Màn hình: 16 inch, OLED 2.8K (2880×1800), 1100 nits, 120Hz, 100% sRGB | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 80Wh | Trọng lượng: 1.76 kg | Hệ điều hành: Window 11 bản quyền', 19790000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/ideapad-slim-5-2025-16-ai-h1_1742808678.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 2025 (Xiaoxin Pro 16 IMH9) (Ultra 7 155H, 16GB, 1.5TB, RTX 3050 6GB, 16.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-16-2025-xiaoxin-pro-16-imh9-ultra-7-155h-16gb-15tb-rtx-3050-6gb-160-2k-oled-120hz-45', N'CPU: Intel Core Ultra 7 155H (1.40GHz up to 4.80GHz, 24MB Cache) | RAM: 16GB LPDDR5x 7500Mhz | Ổ cứng: 1.5TB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 16.0inch 2K (2048×1280) OLED, 500nits, Glossy, 100% DCI-P3, 120Hz, Eyesafe®, DisplayHDR™ True Black 500 | Webcam: 1080p IR | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,91kg | Hệ điều hành: Window 11 bản quyền', 24590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-XiaoXin-Pro-16-2024-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 16 2025 (XiaoXin Pro 16) (Core Ultra 5 225H, 24GB, 1TB, 16.0 2.8K OLED 120Hz)', 'new-100-lenovo-ideapad-slim-5-16-2025-xiaoxin-pro-16-core-ultra-5-225h-24gb-1tb-160-28k-oled-120hz-46', N'CPU: Intel® Core™ Ultra 5 225H (14 nhân 14 luồng, xung nhịp tối đa có thể đạt P-core 4.9GHz / E-core 4.3GHz, 18 MB Intel® Smart Cache) Intel AI Boost | RAM: 24GB DDR5 4800 MHz | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: Intel® Graphics | Màn hình: 16 inch, OLED 2.8K (2880×1800), 1100 nits, 120Hz, 100% sRGB | Webcam: FHD 1080p + IR, with privacy shutter | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 80Wh | Trọng lượng: 1.76 kg | Hệ điều hành: Window 11 bản quyền', 19790000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/ideapad-slim-5-2025-16-ai-h1_1742808678.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 Plus 7440F 2025 (Intel Core 5 – 210H, 16GB, 1TB, Intel Iris Xe Graphics, 14 2K+ 90Hz)', 'new-100-dell-inspiron-14-plus-7440f-2025-intel-core-5-210h-16gb-1tb-intel-iris-xe-graphics-14-2k-90hz-47', N'CPU: Intel® Core 5 – 210H ( 8 Cores, 12 Threads, 12MB Cache, 2.2GHz up to 4.8 GHz ) | RAM: 16GB DDR5 6400MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: Intel Iris Xe Graphics | Màn hình: 14” QHD (2560×1440), 90Hz | Webcam: 1080p | Cổng kết nối: 2x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2x USB 3.2 Gen 1 Type-A ports 1x Universal audio port 1x HDMI 1.4 port | Pin: 4 Cell, 64 Wh, integrated | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 18690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/9740_9317_7440_dell.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c) (Ryzen 7-8745HS, 16GB, 512GB, AMD 780M, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ryzen-7-8745hs-16gb-512gb-amd-780m-14-fhd-48', N'CPU: AMD Ryzen™ 7 8745HS (3.8 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB LPDDR5X 5600MHz  (onboard 8GB + 1 thanh 8GB ) | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 780M | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 15890000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3598_lenovo_xiaoxin_14c_ahp10_1-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 Plus 7440F 2025 (Intel Core 7 – 240H, 16GB, 1TB, Intel Iris Xe Graphics, 14 2K+ 90Hz)', 'new-100-dell-inspiron-14-plus-7440f-2025-intel-core-7-240h-16gb-1tb-intel-iris-xe-graphics-14-2k-90hz-49', N'CPU: Intel Core 7 – 240H ( 10 Cores, 16 Threads, 24MB Cache, 2.5GHz up to 5.2 GHz ) | RAM: 16GB DDR5 6400MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: Intel Iris Xe Graphics | Màn hình: 14” QHD (2560×1440), 90Hz | Webcam: 1080p | Cổng kết nối: 2x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2x USB 3.2 Gen 1 Type-A ports 1x Universal audio port 1x HDMI 1.4 port | Pin: 4 Cell, 64 Wh, integrated | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 20490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/9740_9317_7440_dell.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 Plus 7440F 2025 (Intel Core 5 – 210H, 16GB, 512GB, Intel Iris Xe Graphics, 14 FHD+)', 'new-100-dell-inspiron-14-plus-7440f-2025-intel-core-5-210h-16gb-512gb-intel-iris-xe-graphics-14-fhd-50', N'CPU: Intel® Core 5 – 210H ( 8 Cores, 12 Threads, 12MB Cache, 2.2GHz up to 4.8 GHz ) | RAM: 16GB DDR5 6400MT/s | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: Intel Iris Xe Graphics | Màn hình: 14” FHD+, 60Hz | Webcam: 1080p | Cổng kết nối: 2x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2x USB 3.2 Gen 1 Type-A ports 1x Universal audio port 1x HDMI 1.4 port | Pin: 4 Cell, 64 Wh, integrated | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 16990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/9740_9317_7440_dell.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 16 G8+ 2026 (Ryzen 7 H 255, 32GB, 1TB, 16 3K+ 165Hz) – White', 'new-100-lenovo-thinkbook-16-g8-2026-ryzen-7-h-255-32gb-1tb-16-3k-165hz-white-51', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~4.9GHz, 8MB L2 Cache, 16MB L3 Cache) | RAM: 32GB LPDDR5x 7500MHz, onboard | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD | GPU: AMD Radeon™ 780M | Màn hình: 16″ 3K (3200 × 2000) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 500nits, tần số quét 165Hz, 100% sRGB, 100% DCI-P3 | Webcam: 1080p IR RGB camera, cùng 2 mic thu tầm xa và màn trập cơ học Privacy Shutter | Cổng kết nối: 1x Cổng mạng LAN, 2x cổng USB-A 3.2 Gen 1, 1x khe đọc-ghi thẻ SD, 1x Khe cắm chìm USB-A 2.0 1x cổng HDMI 2.1, 2x cổng USB4 type C (có thể sạc 140W), 1x jack tai nghe, 1x Cổng TGX (cắm eGPU) | Pin: 4 cell 99.9wh hỗ trợ sạc nhanh, củ sạc 140w GaN-C | Trọng lượng: 1.5 kg | Hệ điều hành: Window 11 bản quyền', 28590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Thinkbook-16-G8-2026-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 14 G8 IRL-21SG007MVA (Core 5-210H, 16GB, 512GB, 14 FHD+)', 'new-100-lenovo-thinkbook-14-g8-irl-21sg007mva-core-5-210h-16gb-512gb-14-fhd-52', N'CPU: Intel Core 5 210H (3.6 GHz up to 4.8 Hz, 8 Cores, 12 Threads, 12MB Cache) | RAM: 16GB DDR5 5600 MHz ( up to 64GB) | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: Intel Graphics | Màn hình: 14″ WUXGA (1920×1200) IPS 300nits Anti-glare, 45% NTSC, 60Hz | Webcam: 1080p IR | Cổng kết nối: 2 x USB-A 3.2 Gen 1 1 x Thunderbolt 4 supports display / power delivery 1 x USB-C 3.2 Gen 2 1 x HDMI 2.1 TMDS 1 x 3.5mm Combo Audio Jack 1 x RJ45 | Pin: 4cell 45Wh | Trọng lượng: 1.42 kg | Hệ điều hành: No OS', 18590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3597_thinkbook_14_g8_2025_h1_1740068778.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro 13 Premium PA13250 2025 (Core Ultra 7 268V, 32GB, 512GB, 13.3 2K+ Touch)', 'new-100-dell-pro-13-premium-pa13250-2025-core-ultra-7-268v-32gb-512gb-133-2k-touch-53', N'CPU: Intel® Core™ Ultra 7 268V, vPro® (48 TOPS NPU, 8 cores, up to 5.0 GHz) | RAM: 32GB LPDDR5x, 8533 MT/s (onboard) | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Graphics | Màn hình: 13.3″ 2K+ (2560 x 1600) IPS, 16:10, 60Hz, Touch, Anti-Glare, 300nits | Webcam: 8MP HDR + IR Camera, TNR, Camera Shutter, Microphone | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) with DisplayPort™ Alt Mode/USB Type-C/USB4/Power Delivery ports 1 USB 3.2 Gen 1 (5 Gbps) with PowerShare port 1 HDMI 2.1 port 1 headset (headphone and microphone combo) port | Pin: 3-cell, 60Wh, ExpressCharge™, ExpressCharge™ Boost | Trọng lượng: 1.071 kg | Hệ điều hành: Window 11 bản quyền', 45890000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-13-premium-pa13250-13-inch-2025-1742975135.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 15s IRH8 2025 (Core i5-13420H, 8GB, 512GB, 15.6 FHD)', 'new-100-lenovo-ideapad-15s-irh8-2025-core-i5-13420h-8gb-512gb-156-fhd-54', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 8GB DDR5-4800MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® UHD Graphics | Màn hình: 15.6 inch FHD (1920×1080) IPS, 300nits, Anti-glare, 45% NTSC | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2× USB 3.1 Gen1 1× USB 3.2 Type C Card Reader 3.5 MM Audio Jack HDMI-Compatible | Pin: 50 Wh | Trọng lượng: ~1,5kg | Hệ điều hành: Window 11 bản quyền', 12390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/9205_2024_5_13_638512072644689606_82xm00ejvn_thumb.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 15ARP10 (Xiaoxin 15c) (Ryzen 5 7535HS, 8GB, 256GB, 15.3 FHD+)', 'new-100-lenovo-ideapad-slim-3-15arp10-xiaoxin-15c-ryzen-5-7535hs-8gb-256gb-153-fhd-55', N'CPU: AMD Ryzen™ 5 7535HS (3.3 GHz up to 4.55 GHz, 6 Cores, 12 Threads, 16MB Cache) | RAM: 8GB DDR5 4800MHz | Ổ cứng: 256GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 660M | Màn hình: 15.3″ FHD+ | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x USB-C® (USB 5Gbps) tích hợp tính năng PD 3.0 & DP 1.2 1x HDMI 1x khe đọc-ghi thẻ SD 1x jack tai nghe 3.5 | Pin: 60 Wh | Trọng lượng: ~1,49 kg | Hệ điều hành: Window 11 bản quyền', 13390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/ideapad_slim_3_15cahp10_2025_1747989305.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 14ARP10 (Ryzen 7-7735HS, 16GB, 1TB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-14arp10-ryzen-7-7735hs-16gb-1tb-14-fhd-56', N'CPU: AMD Ryzen 7 7735HS (3.20GHz up to 4.75GHz, 16MB Cache) | RAM: 16GB (8GB Soldered DDR5-4800MHz + 8GB SO-DIMM DDR5-4800MHz) (Up to 24GB) | Ổ cứng: 1TB M.2 NVMe PCIe SSD | GPU: AMD Radeon™ 680M | Màn hình: 14 inch FHD+ (1920×1200) IPS, 300nits, Anti-glare, 45% NTSC | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,39kg | Hệ điều hành: Window 11 bản quyền', 15490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/51729_laptop_lenovo_ideapad_slim_3_14irh10_83k00008vn__3_-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 15 2025 (Xiaoxin 15c IRH10) (Core i5-13420H, 16GB, 512GB, 15.3 FHD+)', 'new-100-lenovo-ideapad-slim-3-15-2025-xiaoxin-15c-irh10-core-i5-13420h-16gb-512gb-153-fhd-57', N'CPU: Intel Core i5-13420H (3.4 GHz up to 4.6 GHz, 8 Cores, 12 Threads, 12MB Cache) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® UHD Graphics | Màn hình: 15.3″ FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x USB-C® (USB 5Gbps) tích hợp tính năng PD 3.0 & DP 1.2 1x HDMI 1x khe đọc-ghi thẻ SD 1x jack tai nghe 3.5 | Pin: 60 Wh | Trọng lượng: ~1,49 kg | Hệ điều hành: Window 11 bản quyền', 14590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/ideapad_slim_3_15cahp10_2025_1747989305.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 15 2025 (Xiaoxin 15c IRH10) (Core i5-13420H, 8GB, 512GB, 15.3 FHD+)', 'new-100-lenovo-ideapad-slim-3-15-2025-xiaoxin-15c-irh10-core-i5-13420h-8gb-512gb-153-fhd-58', N'CPU: Intel Core i5-13420H (3.4 GHz up to 4.6 GHz, 8 Cores, 12 Threads, 12MB Cache) | RAM: 8GB DDR5 5200MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: Intel® UHD Graphics | Màn hình: 15.3″ FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x USB-C® (USB 5Gbps) tích hợp tính năng PD 3.0 & DP 1.2 1x HDMI 1x khe đọc-ghi thẻ SD 1x jack tai nghe 3.5 | Pin: 60 Wh | Trọng lượng: ~1,49 kg | Hệ điều hành: Window 11 bản quyền', 13990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/ideapad_slim_3_15cahp10_2025_1747989305.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 Plus 7440F 2025 (Intel Core 7 – 240H, 16GB, 1TB, Intel Iris Xe Graphics, 14 2K+ 120Hz)', 'new-100-dell-inspiron-14-plus-7440f-2025-intel-core-7-240h-16gb-1tb-intel-iris-xe-graphics-14-2k-120hz-59', N'CPU: Intel Core 7 – 240H ( 10 Cores, 16 Threads, 24MB Cache, 2.5GHz up to 5.2 GHz ) | RAM: 16GB DDR5 6400MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: Intel Iris Xe Graphics | Màn hình: 14” QHD (2560×1440), 120Hz, 300Nits | Webcam: 1080p | Cổng kết nối: 2x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2x USB 3.2 Gen 1 Type-A ports 1x Universal audio port 1x HDMI 1.4 port | Pin: 4 Cell, 64 Wh, integrated | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 21290000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/9740_9317_7440_dell.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP EliteBook 860 G10 (Core i7-1365U, 16GB, 512GB, Iris Xe Graphics, 16 FHD+ IPS)', 'new-100-hp-elitebook-860-g10-core-i7-1365u-16gb-512gb-iris-xe-graphics-16-fhd-ips-60', N'CPU: Intel® Core™ i7-1365U (3.90GHz up to 5.20GHz, 12MB Cache) | RAM: 16GB (1x16GB) DDR5 4800MHz (2 khe) | Ổ cứng: 512GB PCIe NVMe M.2 SSD | GPU: Intel® Iris® Xe Graphics | Màn hình: 16.0 inch FHD (1920 x 1200), IPS, narrow bezel, anti-glare, 250 nits, 45% NTSC | Webcam: 720p HD camera | Cổng kết nối: (2) Thunderbolt 4 with USB4 Type-C ports; 40 Gbps signaling rate (USB Power Delivery and DisplayPort 1.4) (2) SuperSpeed USB 3.2 Gen 1.0 Type-A ports; 5 Gbps signaling rate (one charging port) (1) HDMI 2.1 port (cable sold separately) (1) Headphone/microphone combo jack (1) SmartCard Reader (optional) (1) Nano SIM card slot (optional) | Pin: 3Cell 51WHrs | Trọng lượng: 1.7 kg | Hệ điều hành: Window 11 bản quyền', 15690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/hp-elitebook-860-g10-2023-16-inch.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ExpertBook B1 BM1403CDA-S60974W (Ryzen 5-7535HS, 16GB, 512GB, AMD Radeon 660M, 14 FHD)', 'new-100-asus-expertbook-b1-bm1403cda-s60974w-ryzen-5-7535hs-16gb-512gb-amd-radeon-660m-14-fhd-61', N'CPU: AMD Ryzen™ 5 7535HS Processor (16MB Cache, up to 4.55 GHz, 6 cores, 12 Threads) | Ram: 16GB DDR5 SO-DIMM, Bộ nhớ tối đa lên tới:64GB | Ổ cứng: 512GB M.2 2280 NVMe™ PCIe® 4.0 SSD | GPU: AMD Radeon™ 660M | Màn hình: 14.0-inch, FHD (1920 x 1080) 16:9, Góc nhìn rộng, Màn hình chống chói, Đèn nền LED, 300 nit, NTSC: 45%, Tỷ lệ màn hình trên kích thước:87 % | Webcam: 720p HD camera, với nắp che linh hoạt | Cổng kết nối: 2x USB 3.2 Thế hệ 1 Loại A 2x USB 3.2 Thế hệ 2 Loại C hỗ trợ màn hình / power delivery 1x HDMI 1.4 1 Jack cắm âm thanh combo 3.5mm 1x RJ45 Gigabit Ethernet | Trọng lượng: 1.4 kg | Pin: 42WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 12390000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Asus-ExpertBook-B1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ExpertBook P1 P1503CVA (Core i5-13420H, 16GB, 512GB, 15.6 FHD)', 'new-100-asus-expertbook-p1-p1503cva-core-i5-13420h-16gb-512gb-156-fhd-62', N'CPU: Intel® Core™ i5-13420H (2.1 GHz – 4.6 GHz/ 12MB/ 8 nhân, 12 luồng) | Ram: 16GB DDR5 SO-DIMM, Bộ nhớ tối đa lên tới:64GB | Ổ cứng: 512GB M.2 2280 NVMe™ PCIe® 4.0 SSD | GPU: AMD Radeon™ 660M | Màn hình: 15.6″ ( 1920 x 1080 ) Full HD 16:9 , IPS , 60Hz , không cảm ứng , 300 nits , 45% NTSC , Màn hình chống lóa | Webcam: 720p HD camera, với nắp che linh hoạt | Cổng kết nối: 2x USB 3.2 Thế hệ 1 Loại A 2x USB 3.2 Thế hệ 2 Loại C hỗ trợ màn hình / power delivery 1x HDMI 1.4 1 Jack cắm âm thanh combo 3.5mm 1x RJ45 Gigabit Ethernet | Trọng lượng: 1.7 kg | Pin: 63WHrs 3-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 16490000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/12/expertbook_p1_p1503cva_product_photo_1a_misty_grey_04_webcam_off_2400x2400_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 7445 2in1 (Ryzen 5 – 8640HS, 16GB, 512GB, AMD Radeon Graphics, 14 FHD+ Touch) – Ice Blue', 'new-100-dell-inspiron-7445-2in1-ryzen-5-8640hs-16gb-512gb-amd-radeon-graphics-14-fhd-touch-ice-blue-63', N'CPU: AMD Ryzen™ 5 8640HS 6-core/12-thread Processor with Radeon™ Graphics | RAM: 16GB DDR5, 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | GPU: AMD Radeon™ Graphics | Màn hình: 14.0″ 16:10 FHD+ (1920 x 1200) Touch 250nits WVA Display with ComfortView Support | Webcam: 30 fps FHD camera, dual-array microphones | Cổng kết nối: 1x HDMI 1.4 2x USB Type-C ( Power Delivery và DisplayPort) 2x USB Type-A 1x SD Card Reader 1x Headphone & Microphone Audio Jack. | Trọng lượng: 1.7 kg | Pin: 4 Cell, 54Wh | Hệ điều hành: Window 11 bản quyền', 19490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/11/bu40rlvz-2393-dell-inspiron-7445-2-in-1-ryzen-5-8640hs-ram-16gb-ssd-512gb-14-fhd-touch-new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 7445 2in1 (Ryzen 5 – 8640HS, 8GB, 512GB, AMD Radeon Graphics, 14 FHD+ Touch) – Midnight Blue', 'new-100-dell-inspiron-7445-2in1-ryzen-5-8640hs-8gb-512gb-amd-radeon-graphics-14-fhd-touch-midnight-blue-64', N'CPU: AMD Ryzen™ 5 8640HS 6-core/12-thread Processor with Radeon™ Graphics | RAM: 8GB, 1x8GB, DDR5, 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | GPU: AMD Radeon™ Graphics | Màn hình: 14.0″ 16:10 FHD+ (1920 x 1200) Touch 250nits WVA Display with ComfortView Support | Webcam: 30 fps FHD camera, dual-array microphones | Cổng kết nối: 1x HDMI 1.4 2x USB Type-C ( Power Delivery và DisplayPort) 2x USB Type-A 1x SD Card Reader 1x Headphone & Microphone Audio Jack. | Trọng lượng: 1.7 kg | Pin: 4 Cell, 54Wh | Hệ điều hành: Window 11 bản quyền', 16590000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/3388_dell_inspiron_7445_1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 3 (Xiaoxin 14C ARP10) (Ryzen 7 170, 16GB, 512GB, 14 FHD+)', 'new-100-lenovo-ideapad-slim-3-xiaoxin-14c-arp10-ryzen-7-170-16gb-512gb-14-fhd-65', N'CPU: AMD Ryzen™ 7 170 (8 nhân 16 luồng, xung nhịp cơ bản 3.2 GHz và boost tối đa 4.75 GHz) | RAM: 16GB DDR5-4800 | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon™ 680M | Màn hình: 14″ FHD+ (1920×1200) IPS, màn nhám, chống lóa, không cảm ứng, tần số quét màn 60Hz, tỷ lệ khung hình 16:10, độ sáng 300nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x SD Card Reader 1x USB-C® 3.2 Gen 2 1x HDMI 1x Headphone / microphone combo jack (3.5mm) 1x DC-N power port | Pin: 50 Wh | Trọng lượng: ~1,39kg | Hệ điều hành: Window 11 bản quyền', 15990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/lenovo-xiaoxin-14c-arp10-lenovo-ideapad-slim-3-ryz_639076149896304407.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 5445 (Ryzen 7-8840HS, 16GB, 512GB, 14 2K+)', 'new-100-dell-inspiron-14-5445-ryzen-7-8840hs-16gb-512gb-14-2k-66', N'CPU: AMD Ryzen™ 7 8840HS 8-core/16-thread Processor with Radeon™ Graphics | RAM: 16GB, DDR5, 5600 MT/s | Ổ cứng: 512GB, M.2, PCIe NVMe, SSD | GPU: AMD Radeon™ 780M Graphics | Màn hình: 14.0″ 2K+ (2240×1400), 300 nits, 100% sRGB, ComfortView Plus | Webcam: FHD camera | Cổng kết nối: 2 x cổng USB 3.2 Gen 1 (5 Gbps) 1 x USB 3.2 Gen 2 (10 Gbps) Type-C ® (Hỗ trợ DisplayPort™ Alt Mode 1.4/Power Delivery) 1 x Cổng tai nghe (kết hợp tai nghe/micrô) 1 x HDMI Cổng 1.4 | Pin: 4 Cell, 41Wh | Trọng lượng: 1.54 kg | Hệ điều hành: Window 11 bản quyền', 16990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/06/3289_dell_inspiron_14_5445_2024_1715338903.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 16 5640 (Core 7 – 150U, 16GB, 1TB, 16 inch FHD+ Touch)', 'new-100-dell-inspiron-16-5640-core-7-150u-16gb-1tb-16-inch-fhd-touch-67', N'CPU: Intel Core 7-150U (1.80GHz up to 5.40GHz, 12MB Cache) | RAM: 16GB DDR5 5200MHz (2x8GB) | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: Intel Graphics | Màn hình: 16.0inch FHD+ 16:10, Anti-Glare, Touch, 300nits, WVA, Display w/ ComfortView Plus Support | Webcam: 1080p at 30 fps FHD camera, Dual-array microphones, built-in camera shutter | Cổng kết nối: 2 x USB 3.2 Gen 1 (5 Gbps) ports 1 x USB 3.2 Gen 2 (10 Gbps) Type-C®port with DisplayPort™ 1.4 and PowerDelivery 1 x headset (headphone and microphone combo) port 1 x HDMI 1.4 port 1 x power-adapter port | Trọng lượng: 1.87 kg | Pin: 4Cell 54WHrs | Hệ điều hành: Window 11 bản quyền', 20690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/12/Dell-inspiron-5640-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 7440 2in1 (Core 5-120U, 16GB, 512GB, 14.0 FHD+ Touch)', 'new-100-dell-inspiron-14-7440-2in1-core-5-120u-16gb-512gb-140-fhd-touch-68', N'Bộ vi xử lý: Intel Core 5 120U, 10 nhân (2P + 8E) / 12 luồng, P-core 1.4 / 5.0GHz, E-core 900MHz / 3.8GHz, 12MB | Bộ nhớ trong (RAM): 16GB DDR5 5200MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | Card màn hình: Intel Graphics | Màn hình: 14″ 16:10 FHD+ (1920 x 1200) Touch 250nits WVA Display with ComfortView Support | Kết nối: 2 x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2 x USB 3.2 Gen 1 Type-A ports 1 x Universal audio port 1 x HDMI 1.4 port | Pin: 4 Cell, 64 Wh | Trọng lượng: 1.71 kg | Hệ điều hành: Window 11 bản quyền', 18990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/06/3578_3418_3335_3298_dell_inspiron_14_7440_2_in_1_2024.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 7440 2in1 2024 (Core 7-150U, 16GB, 1TB, 14.0 FHD+ Touch)', 'new-100-dell-inspiron-14-7440-2in1-2024-core-7-150u-16gb-1tb-140-fhd-touch-69', N'CPU: Intel® Core™ 7 150U(10 Cores, 12 Threads, 12MB Cache, 4.0GHz up to 5.4 GHz, Max Turbo 55W) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: Intel Graphics | Màn hình: 14″ 16:10 FHD+ (1920 x 1200) Touch 250nits WVA Display with ComfortView Support | Webcam: FHD camera | Cổng kết nối: 2 x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2 x USB 3.2 Gen 1 Type-A ports 1 x Universal audio port 1 x HDMI 1.4 port | Pin: 4 Cell, 64 Wh | Trọng lượng: 1.71 kg | Hệ điều hành: Window 11 bản quyền', 22490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/06/3578_3418_3335_3298_dell_inspiron_14_7440_2_in_1_2024.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 7440 2in1 (Core 5-120U, 8GB, 512GB, 14.0 FHD+ Touch)', 'new-100-dell-inspiron-14-7440-2in1-core-5-120u-8gb-512gb-140-fhd-touch-70', N'Bộ vi xử lý: Intel Core 5 120U, 10 nhân (2P + 8E) / 12 luồng, P-core 1.4 / 5.0GHz, E-core 900MHz / 3.8GHz, 12MB | Bộ nhớ trong (RAM): 8GB DDR5 5200MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | Card màn hình: Intel Graphics | Màn hình: 14″ 16:10 FHD+ (1920 x 1200) Touch 250nits WVA Display with ComfortView Support | Kết nối: 2 x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2 x USB 3.2 Gen 1 Type-A ports 1 x Universal audio port 1 x HDMI 1.4 port | Pin: 4 Cell, 64 Wh | Trọng lượng: 1.71 kg | Hệ điều hành: Window 11 bản quyền', 18590000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/06/3578_3418_3335_3298_dell_inspiron_14_7440_2_in_1_2024.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 7440 2in1 2024 (Core 7-150U, 16GB, 512GB, 14.0 FHD+ Touch)', 'new-100-dell-inspiron-14-7440-2in1-2024-core-7-150u-16gb-512gb-140-fhd-touch-71', N'CPU: Intel® Core™ 7 150U(10 Cores, 12 Threads, 12MB Cache, 4.0GHz up to 5.4 GHz, Max Turbo 55W) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: Intel Graphics | Màn hình: 14″ 16:10 FHD+ (1920 x 1200) Touch 250nits WVA Display with ComfortView Support | Cổng kết nối: 2 x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2 x USB 3.2 Gen 1 Type-A ports 1 x Universal audio port 1 x HDMI 1.4 port | Pin: 4 Cell, 64 Wh | Trọng lượng: 1.71 kg | Hệ điều hành: Window 11 bản quyền', 21490000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/06/3578_3418_3335_3298_dell_inspiron_14_7440_2_in_1_2024.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 14 (Xiaoxin Pro 14 IMH9) (Ultra 9 185H, 32GB, 1TB, 14.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-14-xiaoxin-pro-14-imh9-ultra-9-185h-32gb-1tb-140-2k-oled-120hz-72', N'CPU: Intel Core Ultra 9-185H (16 nhân, 22 luồng, tốc độ tối đa 5.1GHz) | RAM: 32GB LPDD5X 7467MHz | Ổ cứng: 1TB SSD M.2 2280 PCIe® 4.0×4 NVMe® | GPU: Intel® Arc™ Graphics | Màn hình: OLED 14 inch 2.8K (2880×1800), 120Hz, 600 nits, 100% DCI-P3, HDR True Black 500 | Webcam: 1080P Full HD IR Camera hỗ trợ nhận diện khuôn mặt | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,46kg | Hệ điều hành: Window 11 bản quyền', 23690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/02/Xiaoxin-Pro-14-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad 5 Pro 16 2025 (Xiaoxin Pro 16 IMH9) (Ultra 9 185H, 32GB, 1TB, RTX 4050 6GB, 16.0 2K+ OLED 120Hz)', 'new-100-lenovo-ideapad-5-pro-16-2025-xiaoxin-pro-16-imh9-ultra-9-185h-32gb-1tb-rtx-4050-6gb-160-2k-oled-120hz-73', N'CPU: Intel Core Ultra 9 185H (1.80GHz up to 5.10GHz, 24MB Cache) | RAM: 32GB LPDDR5x 7500Mhz | Ổ cứng: 1TB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 16.0inch 2K (2048×1280) OLED, 500nits, Glossy, 100% DCI-P3, 120Hz, Eyesafe®, DisplayHDR™ True Black 500 | Webcam: 1080p IR | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,91kg | Hệ điều hành: Window 11 bản quyền', 28690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-XiaoXin-Pro-16-2024-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell XPS 13 9350 2025 (Ultra 9 288V, 32GB, 1TB, Intel Arc Graphics, 13.4 3K OLED Touch)', 'new-100-dell-xps-13-9350-2025-ultra-9-288v-32gb-1tb-intel-arc-graphics-134-3k-oled-touch-74', N'CPU: Intel® Core™ Ultra 9 288V (12MB Cache, 8 cores, up to 5.1 GHz) | RAM: 32GB, LPDDR5X, 8533MT/s | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: Intel® Arc™ Graphics | Màn hình: 13.4″, 3K Oled Touch, Anti-Glare, 500 nit, EyeSafe, InfinityEdge | Webcam: FHD webcam | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) ports with Power Delivery (Type-C®) | Trọng lượng: 1.2 kg | Pin: 3Cell 55Whr | Hệ điều hành: Window 11 bản quyền', 53690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/Dell-xps-9350-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 16 2025 (XiaoXin 16 AHP10R) (Ryzen 7 H 255, 16GB, 512GB, 16 FHD+)', 'new-100-lenovo-ideapad-slim-5-16-2025-xiaoxin-16-ahp10r-ryzen-7-h-255-16gb-512gb-16-fhd-75', N'CPU: AMD Ryzen™ AI H 255 (8 nhân – 16 luồng, 2 Ghz – 4.9 Ghz, 16MB Cache) | RAM: 16GB DDR5 5600 Mhz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon 780M | Màn hình: 16-inch FHD+ 16:10 (1920×1200), 60Hz ,400 nits, 100% sRGB, HDR True Black 500 | Webcam: Full HD 1080 | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 50Wh | Trọng lượng: 1.81 kg | Hệ điều hành: Window 11 bản quyền', 19090000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/02/Xiaoxin-16-AHP10Rz-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 14 2025 (Xiaoxin 14 AHP10R) (Ryzen 7 H 255, 16GB, 512GB, 14 FHD+ 120Hz)', 'new-100-lenovo-ideapad-slim-5-14-2025-xiaoxin-14-ahp10r-ryzen-7-h-255-16gb-512gb-14-fhd-120hz-76', N'CPU: AMD Ryzen™ 7 H 255 (3.8 GHz up to 4.9 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB DDR5 5600 Mhz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon 780M | Màn hình: 14-inch FHD+ 16:10 (1920×1200),400 nits, 100% sRGB, HDR True Black 500, 120Hz | Webcam: Full HD 1080 | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 2x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 4K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x khe đọc ghi thẻ MicroSD4 | Pin: 50Wh | Trọng lượng: 1.46 kg | Hệ điều hành: Window 11 bản quyền', 19190000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/02/Xiaoxin-14-AHP10R-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell 14 Plus DB14250 2025 (Core Ultra 9 288V, 32GB, 1TB, 14 2K+)', 'new-100-dell-14-plus-db14250-2025-core-ultra-9-288v-32gb-1tb-14-2k-77', N'CPU: Intel® Core™ Ultra 9 288V (48 TOPS NPU, 8 cores, up to 5.1 GHz) | RAM: 32GB LPDDR5x 8533MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: Intel Arc 140V (8 Cores, 1.95 – 2.05 GHz) | Màn hình: 14″ 2K+ (2560 x 1600 Pixels), WVA/IPS, 60 Hz, 300 nits, Anti Glare | Webcam: HD camera (1080P) | Cổng kết nối: 1 USB 3.2 Gen 1 (5 Gbps) port 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with DisplayPort™ 1.4 and Power Delivery 1 Thunderbolt™ 4 port with DisplayPort™ 2.1 and Power Delivery 1 HDMI 2.1 port 1 Universal Audio jack | Pin: 4 cell – 64 WHr | Trọng lượng: 1.55 Kg | Hệ điều hành: Window 11 bản quyền', 30990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/Dell-14-Plus-DB14250.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 16 Plus 7640F 1605L (Core 5 – 210H, 16GB, 512GB, Intel UHD Graphics, 16 FHD)', 'new-100-dell-inspiron-16-plus-7640f-1605l-core-5-210h-16gb-512gb-intel-uhd-graphics-16-fhd-78', N'CPU: Intel Core 5 – 210H (12MB cache, 8 cores, 12 threads, up to 4.8 GHz) | RAM: 16GB, 2x8GB, LPDDR5X, 6400MT/s | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | GPU: Intel UHD Graphics | Màn hình: 16inch 16:10 FHD+ (1920 x 1200) WVA, Anti-Glare, 300 nits, 100% sRGB, ComfortView Plus | Webcam: FHD 1080p với màn trập riêng tư | Cổng kết nối: 1 x Thunderbolt™ 4 (hỗ trợ DisplayPort và Power Delivery) 2 x USB 3.2 Gen 1 Type-A 1 x HDMI 1.4 1 x Jack tai nghe/mic 3.5mm 1 x Khe cắm thẻ SD | Pin: 4cell, 54Whr | Trọng lượng: 1.9 kg | Hệ điều hành: Window 11 bản quyền', 16890000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/05/dell-inspiton-16-plus-7640-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell XPS 13 9350 PP9H1 (Ultra 7 258V, 32GB, 512GB, Intel Arc Graphics, 13.4 2K+ 120Hz – Platinum)', 'new-100-dell-xps-13-9350-pp9h1-ultra-7-258v-32gb-512gb-intel-arc-graphics-134-2k-120hz-platinum-79', N'CPU: Intel® Core™ Ultra 7 258V (12MB Cache, 8 cores, up to 4.8 GHz) | RAM: 32GB, LPDDR5X, 8533MT/s | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: Intel® Arc™ Graphics | Màn hình: QHD+ (2560×1600) WVA, cảm ứng, 120Hz, 500 nits, chống lóa, hỗ trợ InfinityEdge, Dolby Vision, Eyesafe® | Webcam: FHD webcam | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) ports with Power Delivery (Type-C®) | Trọng lượng: 1.2 kg | Pin: 3Cell 55Whr | Hệ điều hành: Window 11 bản quyền', 43690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/12/Dell-xps-9350-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell 14 Plus DB14250 2025 (Core Ultra 5 226V, 16GB, 512GB, 14 2K+)', 'new-100-dell-14-plus-db14250-2025-core-ultra-5-226v-16gb-512gb-14-2k-80', N'CPU: Core Ultra 5 226V (8C/8T, 8MB, up to 4.50 GHz) | RAM: 16GB LPDDR5x 8533MT/s | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: Intel Arc 130V (7 Cores, 1.85GHz) | Màn hình: 14″ 2K+ (2560 x 1600 Pixels), WVA/IPS, 60 Hz, 300 nits, Anti Glare | Webcam: HD camera (1080P) | Cổng kết nối: 1 USB 3.2 Gen 1 (5 Gbps) port 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with DisplayPort™ 1.4 and Power Delivery 1 Thunderbolt™ 4 port with DisplayPort™ 2.1 and Power Delivery 1 HDMI 2.1 port 1 Universal Audio jack | Pin: 4 cell – 64 WHr | Trọng lượng: 1.55 Kg | Hệ điều hành: Window 11 bản quyền', 20690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/Dell-14-Plus-DB14250.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro 14 Plus PB14250 2025 (Core Ultra 5 235U, 16GB, 256GB, 14 FHD+)', 'new-100-dell-pro-14-plus-pb14250-2025-core-ultra-5-235u-16gb-256gb-14-fhd-81', N'CPU: Intel® Core™ Ultra 5 235U, vPro® (12 TOPS NPU, 12 lõi, lên đến 4,9 GHz) | RAM: 16GB LPDDR5x, 8533 MT/s (onboard) | Ổ cứng: 256GB SSD PCIe 4.0 | GPU: Intel Arc Graphics | Màn hình: 14″ Non-Touch, FHD+, IPS, Anti-Glare, 300 nits, 45% NTSC | Webcam: 5 MP + IR Cam | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) with DisplayPort™ 2.1 Alt Mode/USB Type-C®/USB4/Power Delivery ports 1 USB 3.2 Gen 1 Type-A port with PowerShare 1 USB 3.2 Gen 1 Type-A port 1 HDMI 2.1 port 1 global headset jack 1 RJ45 Ethernet port | Pin: 3-cell, 55 Wh, ExpressCharge™ Capable, ExpressCharge™ Boost Capable | Trọng lượng: 1.40 Kg | Hệ điều hành: Window 11 bản quyền', 23790000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/Dell-Pro-14-Plus-PB14250.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro 14 Premium PA14250 2025 (Core Ultra 5 236V, 16GB, 256GB, 14 FHD+)', 'new-100-dell-pro-14-premium-pa14250-2025-core-ultra-5-236v-16gb-256gb-14-fhd-82', N'CPU: Intel® Core™ Ultra 5 236V, vPro® (40 TOPS NPU, 8 cores, up to 4.7 GHz) | RAM: 16 GB: LPDDR5x, 8533 MT/s (onboard) | Ổ cứng: 256GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Graphics | Màn hình: 14″ FHD+ (1920*1200) IPS, 16:10, 60Hz, Non-Touch, Anti-Glare, 300 nits | Webcam: 8MP HDR + IR Camera, TNR, Camera Shutter, Microphone | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) with DisplayPort™ Alt Mode/USB Type-C/USB4/Power Delivery ports 1 USB 3.2 Gen 1 (5 Gbps) with PowerShare port 1 HDMI 2.1 port 1 headset (headphone and microphone combo) port | Pin: 3-cell, 60Wh, ExpressCharge™, ExpressCharge™ Boost | Trọng lượng: 1.171 kg | Hệ điều hành: Window 11 bản quyền', 31690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-13-premium-pa13250-13-inch-2025-1742975135.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro 13 Premium PA13250 2025 (Core Ultra 5 236V, 16GB, 256GB, 13.3 FHD+)', 'new-100-dell-pro-13-premium-pa13250-2025-core-ultra-5-236v-16gb-256gb-133-fhd-83', N'CPU: Intel® Core™ Ultra 5 236V, vPro® (40 TOPS NPU, 8 cores, up to 4.7 GHz) | RAM: 16 GB: LPDDR5x, 8533 MT/s (onboard) | Ổ cứng: 256GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Graphics | Màn hình: 13.3″ FHD+ (1920*1200) IPS, 16:10, 60Hz, Non-Touch, Anti-Glare, 300 nits | Webcam: 8MP HDR + IR Camera, TNR, Camera Shutter, Microphone | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) with DisplayPort™ Alt Mode/USB Type-C/USB4/Power Delivery ports 1 USB 3.2 Gen 1 (5 Gbps) with PowerShare port 1 HDMI 2.1 port 1 headset (headphone and microphone combo) port | Pin: 3-cell, 60Wh, ExpressCharge™, ExpressCharge™ Boost | Trọng lượng: 1.071 kg | Hệ điều hành: Window 11 bản quyền', 36190000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-13-premium-pa13250-13-inch-2025-1742975135.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 18 Plus MB18250 2025 (Core Ultra 7 265HX, 32GB, 512GB, RTX PRO 2000 8GB, 18 QHD+)', 'new-100-dell-pro-max-18-plus-mb18250-2025-core-ultra-7-265hx-32gb-512gb-rtx-pro-2000-8gb-18-qhd-84', N'CPU: Intel Core Ultra 7 265HX vPro Up To 5.3GHz (20 Cores, 20 Threads, 36MB Cache – 13 TOPS NPU) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: NVIDIA® RTX™ PRO 2000 Blackwell, 8GB GDDR7 | Màn hình: 18″ QHD+ LCD 2560×1600 with 500 nits, DCI-P3 100%, Non-Touch | Webcam: FHD IR Cam | Cổng kết nối: 1 Audio jack port 1 Thunderbolt™ 4 (40 Gbps) port with Power Delivery and DisplayPort™ 1 USB 3.2 Gen 1 (5 Gbps) port with PowerShare 1 USB 3.2 Gen 1 (5 Gbps) port 1 RJ45 ethernet port (2.5 Gbps) 1 HDMI 2.1 port 2 Thunderbolt™ 5 (80 Gbps) ports with Power Delivery and DisplayPort™ | Pin: 6 cell, 96Whr, ExpressCharge™ Capable, standard battery | Trọng lượng: 3.25 kg | Hệ điều hành: Window 11 bản quyền', 128990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-18-plus-mb18250-mobile-workstation-2025-1753669412.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 16 Plus MB16250 2025 (Core Ultra 7 265HX, 32GB, 512GB, RTX PRO 2000 8GB, 16 FHD+)', 'new-100-dell-pro-max-16-plus-mb16250-2025-core-ultra-7-265hx-32gb-512gb-rtx-pro-2000-8gb-16-fhd-85', N'CPU: Intel Core Ultra 7 265HX vPro Up To 5.3GHz (20 Cores, 20 Threads, 36MB Cache – 13 TOPS NPU) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: NVIDIA® RTX™ PRO 2000 Blackwell, 8GB GDDR7 | Màn hình: 16″ FHD+ (1920*1200), IPS, 120Hz, Non-Touch, 100% DCI-P3, 500 nits | Webcam: FHD IR Cam | Cổng kết nối: 1 Global headset port 1 Thunderbolt™ 4 (40 Gbps) port with Power Delivery and DisplayPort™ 1 USB 3.2 Gen 1 (5 Gbps) port with PowerShare 1 USB 3.2 Gen 1 (5 Gbps) port 1 RJ45 ethernet port (2.5 Gbps) 1 HDMI 2.1 port 2 Thunderbolt™ 5 (80 Gbps) ports with Power Delivery and DisplayPort™ | Pin: 6 cell, 96Whr, ExpressCharge™ Capable, standard battery | Trọng lượng: 2.55 Kg | Hệ điều hành: Window 11 bản quyền', 75690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-16-plus-mb16250-1753696338.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 16 Premium MA16250 2025 (Ultra 7 255H, 32GB, 512GBGB, 16 FHD+)', 'new-100-dell-pro-max-16-premium-ma16250-2025-ultra-7-255h-32gb-512gbgb-16-fhd-86', N'CPU: Intel® Core™ Ultra 7 255H (13 TOPS NPU, 16 cores, 16 threads, up to 5.10 GHz, 45W) | RAM: 32GB LPDDR5x 8400 MT/s | Ổ cứng: 512GB PCIe Gen4 M.2 | GPU: Intel® Graphics | Màn hình: 16″ FHD+ (1920*1200), IPS, VRR 120Hz, Non-Touch, Anti-Glare, 100% DCI-P3, 500 nits | Webcam: FHD IR Cam | Cổng kết nối: 2 x USB Type-C Thunderbolt™ 5 (80/120 Gbps) ports with Power Delivery and DisplayPort™ 2.1 1 x USB Type-C Thunderbolt™ 4 (40 Gbps) port with Power Delivery and DisplayPort™ 2.1 1 x HDMI 2.1 port 1 x global headset port | Pin: 6 cell, 96Whr, ExpressCharge™ Capable, standard battery | Trọng lượng: 2.19 kg | Hệ điều hành: Window 11 bản quyền', 69290000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-16-premium-ma16250-1755660293.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 14 Premium MA14250 2025 (Core Ultra 7 255H, 16GB, 256GB, 14 FHD+)', 'new-100-dell-pro-max-14-premium-ma14250-2025-core-ultra-7-255h-16gb-256gb-14-fhd-87', N'CPU: Ultra 7 255H Up To 5.1GHz (16 Cores, 16 Threads, 24MB Cache – 13 TOPS NPU) | RAM: 16GB LPDDR5x 8400 MT/s | Ổ cứng: 256GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Pro 140T | Màn hình: 14″ FHD+ (1920 x 1200) Non-Touch, 16:10, 60Hz, WVA, Anti-Glare, 300 nit, 45% NTSC | Webcam: FHD IR Cam | Cổng kết nối: 2x USB-C Thunderbolt 4 2x USB-A 3.2 Gen 1 HDMI 2.1 Input Jack 3.5mm RJ45 lên đến 1000 Mbps 1 Global headset | Pin: 4 cell, 72Whr, ExpressCharge™ Capable, standard battery | Trọng lượng: 1.61 Kg | Hệ điều hành: Window 11 bản quyền', 56990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-14-premium-ma14250-1755684335.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 14 MC14255 2025 (Ryzen AI 5 Pro 340, 16GB, 256GB, 14 FHD+)', 'new-100-dell-pro-max-14-mc14255-2025-ryzen-ai-5-pro-340-16gb-256gb-14-fhd-88', N'CPU: AMD Ryzen AI 5 PRO 340 (22MB cache, 6 cores, 12 threads, up to 4.8 GHz max boost, 45W) | RAM: 16GB: 1x16GB, LPDDR5x, 8000 MT/s, Dual Channel, non-ECC | Ổ cứng: 256GB PCIe Gen4 M.2 SSD | GPU: AMD Radeon Integrated Graphics | Màn hình: 14″ FHD+ (1920 x 1200) Non-Touch, 16:10, 60Hz, WVA, Anti-Glare, 300 nit, 45% NTSC | Webcam: FHD IR Cam | Cổng kết nối: 2x USB-C Thunderbolt 4 2x USB-A 3.2 Gen 1 HDMI 2.1 Input Jack 3.5mm RJ45 lên đến 1000 Mbps 1 Global headset | Pin: 4 cell, 72Whr, ExpressCharge™ Capable, standard battery | Trọng lượng: 1.79 Kg | Hệ điều hành: Window 11 bản quyền', 42290000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-14-mc14250-1752805873.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 16 MC16255 2025 (Ryzen AI 5 Pro 340, 16GB, 256GB, 16 FHD+)', 'new-100-dell-pro-max-16-mc16255-2025-ryzen-ai-5-pro-340-16gb-256gb-16-fhd-89', N'CPU: AMD Ryzen AI 5 PRO 340 (22MB cache, 6 cores, 12 threads, up to 4.8 GHz max boost, 45W) | RAM: 16GB: 1x16GB, LPDDR5x, 8000 MT/s, Dual Channel, non-ECC | Ổ cứng: 256GB, M.2 2230, SSD Gen4, Class 35 | GPU: AMD Radeon 840M | Màn hình: 16 inch FHD+ (1920 x 1200 pixels), Non-Touch, WVA/IPS Tần số quét: 60Hz, 300 nits, 45% NTSC, Anti glare | Webcam: FHD IR Cam | Cổng kết nối: 2 x Thunderbolt™ 4 1 x USB 3.2 Gen 1 port with PowerShare 1 x USB 3.2 Gen 1 1 x HDMI 2.1 1 x RJ45 (1 Gbps) Ethernet 1 x Global headset 1 x microSD-card slot | Pin: 4 cell 64 WHr, Li-ion polymer | Trọng lượng: 2.08 kg | Hệ điều hành: Window 11 bản quyền', 40590000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-16-mc16250-1752803085.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 14 MC14250 2025 (Core Ultra 7 255H, 16GB, 512GB, 14 FHD+)', 'new-100-dell-pro-max-14-mc14250-2025-core-ultra-7-255h-16gb-512gb-14-fhd-90', N'CPU: Ultra 7 255H Up To 5.1GHz (16 Cores, 16 Threads, 24MB Cache – 13 TOPS NPU) | RAM: 16GB DDR5, 7500 MT/s | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Pro 140T | Màn hình: 14″ FHD+ (1920 x 1200) Non-Touch, 16:10, 60Hz, WVA, Anti-Glare, 300 nit, 45% NTSC | Webcam: FHD IR Cam | Cổng kết nối: 2x USB-C Thunderbolt 4 2x USB-A 3.2 Gen 1 HDMI 2.1 Input Jack 3.5mm RJ45 lên đến 1000 Mbps 1 Global headset | Pin: 4 cell, 72Whr, ExpressCharge™ Capable, standard battery | Trọng lượng: 1.79 Kg | Hệ điều hành: Window 11 bản quyền', 46690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-14-mc14250-1752805873.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Pro Max 16 MC16250 2025 (Core Ultra 7 265H, 16GB, 512GB, 16 FHD+)', 'new-100-dell-pro-max-16-mc16250-2025-core-ultra-7-265h-16gb-512gb-16-fhd-91', N'CPU: 15th Generation Intel® Core™ Ultra 7 265H vPro (16-Core, 16-Thread, 24MB Cache, up to 5.3GHz Max Turbo Frequency – 13 TOPS NPU) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Pro 140T | Màn hình: 16″ FHD+ (1920*1200), 60Hz, Non-Touch, Anti-Glare, 45% NTSC, 300 nits | Webcam: FHD IR Cam | Cổng kết nối: 2 x Thunderbolt™ 4 1 x USB 3.2 Gen 1 port with PowerShare 1 x USB 3.2 Gen 1 1 x HDMI 2.1 1 x RJ45 (1 Gbps) Ethernet 1 x Global headset 1 x microSD-card slot | Pin: 4 cell 64 WHr, Li-ion polymer | Trọng lượng: 2.20 Kg | Hệ điều hành: Window 11 bản quyền', 47690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/dell-pro-max-16-mc16250-1752803085.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo ThinkBook 16 G7+ 2025 AHP (Ryzen 7 H 255, 24GB, 512GB, 16.0 2K+ 120Hz)', 'new-100-lenovo-thinkbook-16-g7-2025-ahp-ryzen-7-h-255-24gb-512gb-160-2k-120hz-92', N'CPU: Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~4.9GHz, 8MB L2 Cache, 16MB L3 Cache) | RAM: 24GB LPDDR5x 7500MT/s | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: AMD Radeon 780M | Màn hình: 16 inch, 16:10, 2K+, IPS, 100% sRGB, 100% DCI-P3, 120Hz, 500 nits | Webcam: 1080p IR | Cổng kết nối: 1 x USB-A 3.2 Gen 2 2 x USB-A 3.2 Gen 1 1 x HDMI 2.1 1 x USB4 1 x Jack 3.5mm 1 x RJ45 1 x SD 1 x USB 2.0 | Pin: 4cell 85Wh | Trọng lượng: 1.9 kg | Hệ điều hành: Window 11 bản quyền', 21690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3617_lenovo_thinkbook_16_g7_-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo ThinkBook 16 G7+ 2025 AHP (Ryzen 7 260, 32GB, 1TB, 16.0 3K+ 120Hz)', 'new-100-lenovo-thinkbook-16-g7-2025-ahp-ryzen-7-260-32gb-1tb-160-3k-120hz-93', N'CPU: Ryzen 7 260 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~5.1GHz, 8MB L2 Cache, 16MB L3 Cache, default TDP 28W, 4nm, Zen 5) | RAM: 32GB LPDDR5x 7500MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: AMD Radeon 780M | Màn hình: 16 inch, 16:10, 3.2K, IPS, 100% sRGB, 100% DCI-P3, 120Hz, 500 nits | Webcam: 1080p IR | Cổng kết nối: 1 x USB-A 3.2 Gen 2 2 x USB-A 3.2 Gen 1 1 x HDMI 2.1 1 x USB4 1 x Jack 3.5mm 1 x RJ45 1 x SD 1 x USB 2.0 | Pin: 4cell 85Wh | Trọng lượng: 1.9 kg | Hệ điều hành: Window 11 bản quyền', 24890000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3617_lenovo_thinkbook_16_g7_-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 14 G7+ 2025 AHP (Ryzen 7 H 255, 24GB, 512GB, 14.5 2K+ 90Hz)', 'new-100-lenovo-thinkbook-14-g7-2025-ahp-ryzen-7-h-255-24gb-512gb-145-2k-90hz-94', N'CPU: Ryzen 7 H 255 (3.8 GHz up to 4.9 GHz, 8 Cores, 16 Threads, 24MB Cache) | RAM: 24GB LPDDR5x-7500 MHz (không nâng cấp được ram) | Ổ cứng: 512GB PCIe® NVMe™ M.2 SSD gen 4 | GPU: AMD Radeon 780M | Màn hình: 14.5″ 2.5K IPS, 16:10, 1200:1, 500nits, 90Hz, 100% DCI-P3, DeltaE <1, Dolby® Vison, TÜV Low Blue Light. | Webcam: 1080P FHD RGB/IR Hybrid with Dual Microphone | Cổng kết nối: 1x USB 3.2 Gen 2 Type-C 1x USB 4.0 Type-C 1x HDMI 2.1 1x USB 3.2 Gen 1 Type-A 1x Headphone / mic combo 3.5 1x RJ45 1x USB 3.2 Gen 1 Type-A 1x SD, 1x USB 2.0 Type-A | Pin: 4cell 85Wh | Trọng lượng: 1.5 kg | Hệ điều hành: Window 11 bản quyền', 23390000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3624_thinkbook_14_g7__2025_1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Vivobook 14 X1404V (Core i5-1334U, 12GB, 256GB, 14.0 FHD)', 'new-100-asus-vivobook-14-x1404v-core-i5-1334u-12gb-256gb-140-fhd-95', N'CPU: Intel® Core™ i5-1334U Processor 1.3 GHz (12MB Cache, up to 4.6 GHz, 10 cores, 12 Threads) | Ram: 12GB DDR4 | Ổ cứng: 256GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: Intel® UHD Graphics | Màn hình: 14 inch FHD 16:9, 60Hz, 250nits Brightness, 45% NTSC color gamut, Anti-glare display, TÜV Rheinland-certified | Webcam: 720p HD camera, với nắp che linh hoạt | Cổng kết nối: 1x USB 2.0 Type-A (data speed up to 480Mbps) 1x USB 3.2 Gen 1 Type-C (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 1.4 1x 3.5mm Combo Audio Jack 1x DC-in | Trọng lượng: 1.4 kg | Pin: 42WHrs, 3-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 10990000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/tai-xuong.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell 15 DC15250 2025 (Core i5 1334U, 8GB, 512GB, 15.6 FHD 120Hz)', 'new-100-dell-15-dc15250-2025-core-i5-1334u-8gb-512gb-156-fhd-120hz-96', N'CPU: Core i5 1334U (10C/12T, 12MB, up to 4.60 GHz) | RAM: 8GB DDR4 3200 MT/s | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: Intel UHD Graphics | Màn hình: 15.6″ FHD (1920×1080), 120Hz, Non-Touch, WVA/IPS (Wide Viewing Angle), 250 nits, 45% NTSC, Anti glare | Webcam: FHD | Cổng kết nối: 1 HDMI 1.4 port 1 USB 3.2 Gen 1 port 1 USB 2.0 port 1 USB 3.2 Gen 1 Type-C port 1 SD-card slot 1 universal audio port | Pin: 3 cell – 41Whr | Trọng lượng: 1.66 Kg | Hệ điều hành: Window 11 bản quyền', 13290000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/60660_60661_laptop_dell_15_dc15250_7.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP EliteBook 645 G10 (Ryzen 5-7530U, 16GB, 512GB, 14 FHD IPS)', 'new-100-hp-elitebook-645-g10-ryzen-5-7530u-16gb-512gb-14-fhd-ips-97', N'CPU: AMD Ryzen 5-7530U ( 2.0 GHz Base clock, up to 4.5 GHz boost clock, 16 MB L3 cache, 6 cores, and 12 threads ) | RAM: 16GB (1x16GB) DDR4 3200MHz (2 khe) | Ổ cứng: 512GB PCIe NVMe M.2 SSD | GPU: AMD Radeon Graphics | Màn hình: 14.0 inch FHD (1920 x 1080), IPS, narrow bezel, anti-glare, 250 nits, 45% NTSC | Webcam: 720p HD camera | Cổng kết nối: (3) SuperSpeed USB 3.2 Gen 1.0 Type-A ports; 5 Gbps signaling rate (1) SuperSpeed USB 3.2 Gen 2.0 Type-C port; 10 Gbps signaling rate (USB Power Delivery, DisplayPort 1.4) (1) AC power input port (1) HDMI 2.1 port (cable sold separately) (1) RJ-45 Ethernet port (1) Headphone/microphone combo jack | Pin: 3Cell 51WHrs | Trọng lượng: 1.41 kg | Hệ điều hành: Window 11 bản quyền', 11990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/screenshot.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook X Flip 14 2in1 (Ultra 5 226V, 16GB, 512GB, 14 2K Touch)', 'new-100-hp-omnibook-x-flip-14-2in1-ultra-5-226v-16gb-512gb-14-2k-touch-98', N'CPU: Intel Core Ultra 5-226V (8 Cores, Upto 4.5GHz, 40 TOPS NPU) | RAM: 16GB LPDDR5x-7500 MHz RAM, 512GB PCIe Gen4 NVMe M.2 SSD | Ổ cứng: 512GB PCIe NVMe SSD | GPU: Intel Arc Graphics | Màn hình: 14” 2K IPS 400 nits Touch Display | Webcam: 5MP IR camera with temporal noise reduction and integrated dual array digital microphones | Cổng kết nối: 2x USB Type-A 2x USB Type-C 1x HDMI 1x Headphone/Microphone combo jack | Pin: 3-cell, 59Wh Li-ion polymer | Trọng lượng: 1.4 kg | Hệ điều hành: Window 11 bản quyền', 22390000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/HP-Omnibook-X-Flip-Thegioiso365.vn-8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 5430 (Core i7-1360P, 16GB, 512GB, Iris Xe Graphics, 14 2.5K)', 'new-100-dell-inspiron-14-5430-core-i7-1360p-16gb-512gb-iris-xe-graphics-14-25k-99', N'CPU: Intel Core i7-1360P (12 cores, 16 Threads, up to 5.0GHz, 18MB cache) | RAM: 16GB LPDDR5 | Ổ cứng: SSD 512GB M.2 NVMe | GPU: Intel Iris Xe Graphics | Màn hình: 14″ 2.5K+  16:10 | Webcam: HD camera | Cổng kết nối: 2x USB 3.2 Gen 1 Type A 1x USB Type-C Thunderbolt 4.0 port with DisplayPort and Power Delivery 1x HDMI 1.4 port 1x  SD-card slot 1x Jack tai nghe 3.5mm 1x Power-adapter port 4.5 mm x 2.9 mm DC-in | Trọng lượng: 1.55 kg | Pin: 4-Cell, 54Wh | Hệ điều hành: Window 11 bản quyền', 17890000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/04/Dell_Inspiron_5430.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook X Flip 14 2in1 (Ryzen AI 7 350, 24GB, 1TB, 14 2K Touch)', 'new-100-hp-omnibook-x-flip-14-2in1-ryzen-ai-7-350-24gb-1tb-14-2k-touch-100', N'CPU: AMD Ryzen™ AI 7 H 350 (8 nhân – 16 luồng, 2 Ghz – 5.0 Ghz, 16MB Cache) | RAM: 24GB LPDDR5x-7500 MHz RAM, 512GB PCIe Gen4 NVMe M.2 SSD | Ổ cứng: 1TB PCIe NVMe SSD | GPU: AMD Radeon™ 860M Graphics | Màn hình: 14” 2K IPS 400 nits Touch Display | Webcam: 5MP IR camera with temporal noise reduction and integrated dual array digital microphones | Cổng kết nối: 2x USB Type-A 2x USB Type-C 1x HDMI 1x Headphone/Microphone combo jack | Pin: 3-cell, 59Wh Li-ion polymer | Trọng lượng: 1.4 kg | Hệ điều hành: Window 11 bản quyền', 24690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/HP-Omnibook-X-Flip-Thegioiso365.vn-8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook X Flip 14 2in1 (Ultra 7 256V, 16GB, 1TB, 14 2K Touch)', 'new-100-hp-omnibook-x-flip-14-2in1-ultra-7-256v-16gb-1tb-14-2k-touch-101', N'CPU: Intel Core Ultra 7-256V (8 Cores, Upto 4.8GHz, 47 TOPS NPU) | RAM: 16GB LPDDR5x-7500 MHz RAM, 512GB PCIe Gen4 NVMe M.2 SSD | Ổ cứng: 1TB PCIe NVMe SSD | GPU: Intel Arc Graphics | Màn hình: 14” 2K IPS 400 nits Touch Display | Webcam: 5MP IR camera with temporal noise reduction and integrated dual array digital microphones | Cổng kết nối: 2x USB Type-A 2x USB Type-C 1x HDMI 1x Headphone/Microphone combo jack | Pin: 3-cell, 59Wh Li-ion polymer | Trọng lượng: 1.4 kg | Hệ điều hành: Window 11 bản quyền', 24690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/HP-Omnibook-X-Flip-Thegioiso365.vn-8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Latitude 5450 (Core Ultra 7 165U, 32GB, 512GB, 14 FHD)', 'new-100-dell-latitude-5450-core-ultra-7-165u-32gb-512gb-14-fhd-102', N'Bộ xử lí CPU :: Intel® Core™ Ultra 7 165U vPro (12-Core, 14-Thread, 12MB Cache, up to 4.9GHz Max Turbo) | Dung lượng RAM:: 32GB DDR5 5600MHz | Hỗ trợ RAM tối đa: Onboard | Đĩa cứng :: 512 GB M.2 2230 TLC Gen 4 PCIe NVMe SSD | Màn hình:: 14.0″ FHD (1920×1080) Non-Touch, AG, IPS, 250 nits | Card onboard (Share):: Intel® Graphics | Card đồ họa rời:: Không | Hệ Điều Hành :: Win 11 Pro | Chuẩn Wifi :: Intel® Wi-Fi 6E AX211, 2×2, 802.11ax | Bluetooth :: Bluetooth 5.3 | Cổng Kết Nối :: 2x Thunderbolt 4; 1x USB 3.2; 1x USB 3.2; 1x Universal audio; 1x HDMI 2.0; 1x microSD-card slot | Dung lượng PIN :: 3-cell, 54 Wh, ExpressCharge™ | Thời gian sử dụng :: up to 6 giờ | Camera :: 720p HD | Keyboard Backlit :: Có | Bảo mật & FingerPrinter Reader:: Có | Trọng lượng:: 1.40 kg | Kích thước: Height: 16.92 – 18.43 mm Width: 305.70 mm Depth: 207.50 mm | Màu Sắc :: xám Titan | Chất liệu máy :: Nhựa tái chế + Carbon | Nguồn gốc :: New 100% – Full Box', 22390000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/11/notebook-latitude-14-5450t-ir-gallery-12-6fgn-l8-www.laptopvip.vn-1726455356.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 14 Plus 7430 (Core i5-13420H, 16GB, 1TB, Intel Graphics, 14 2.5K)', 'new-100-dell-inspiron-14-plus-7430-core-i5-13420h-16gb-1tb-intel-graphics-14-25k-103', N'CPU: 13th Generation Intel® Core™ i5-13420H (8 cores, 12 Threads, 3.4GHz Up to 4.6GHz, 12 MB Intel® Smart Cache) | RAM: 16GB, LPDDR5 4800MHz | Ổ cứng: 1 TB, M.2, PCIe NVMe, SSD | GPU: Intel® Graphics | Màn hình: 14.0″ 16:10 2.5K (2560 x 1600) 90Hz Anti-Glare Non-Touch 300nits WVA Display w/ ComfortView Plus | Camera: 1080p HD | Cổng: 2 USB 3.2 Gen 1 ports 1 Thunderbolt™ 4 port with DisplayPort™ and Power Delivery 1 Headset Jack 1 HDMI 2.0 1 power-adapter port | Trọng lượng: 1.66 kg | Pin: 4 Cells, 64 Wh | Hệ điều hành: Windows 11 bản quyền', 16690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/10/3226_3093_dell_7430_plus.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Inspiron 7440 Plus (Core i5-13420H, 16GB, 1TB, Intel Iris Xe Graphics, 14 FHD+ 90Hz)', 'new-100-dell-inspiron-7440-plus-core-i5-13420h-16gb-1tb-intel-iris-xe-graphics-14-fhd-90hz-104', N'CPU: Intel Core i5-13420H (12MB cache, 8 cores, 12 threads, up to 4.6 GHz) | RAM: 16GB, 2x8GB, LPDDR5X 4800MT/s | Ổ cứng: 1TB M.2 PCIe NVMe Solid State Drive | GPU: Intel Iris Xe Graphics | Màn hình: 14.0-inch FHD+ (1920 x 1200) Anti-Glare Non-Touch 300nits WVA Display w/ ComfortView Plus 90Hz | Webcam: 1080p | Cổng kết nối: 1 x HDMI 1.4 The maximum resolution supported over HDMI is 1920×1080 @60Hz. No 4K/2K output 1 x Intel Thunderbolt 4.0 2 x USB 3.2 Gen 1 Type-A 1 x Universal audio jack 3.5mm Universal audio jack 1 x Power jack | Trọng lượng: 1.7 kg | Pin: 4 Cell, 64 Wh, integrated | Hệ điều hành: Window 11 bản quyền', 16290000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/03/3591_3426_3166_laptop_dell_inspiron_14_7440_plus.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell XPS 13 9350 2025 Platinum (Ultra 5 226V, 16GB, 512GB, Intel Arc Graphics, 13.4 FHD+ 120Hz)', 'new-100-dell-xps-13-9350-2025-platinum-ultra-5-226v-16gb-512gb-intel-arc-graphics-134-fhd-120hz-105', N'CPU: Intel® Core™ Ultra 5 226V (12MB Cache, 8 cores, up to 4.5 GHz) | RAM: 16GB, LPDDR5X, 8533MT/s | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: Intel® Arc™ Graphics | Màn hình: 13.4″, FHD+ 1920 x 1200, 30-120Hz, Non-Touch, Anti-Glare, 500 nit, EyeSafe, InfinityEdge | Webcam: FHD webcam | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) ports with Power Delivery (Type-C®) | Trọng lượng: 1.2 kg | Pin: 3Cell 55Whr | Hệ điều hành: Window 11 bản quyền', 31590000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/Dell-xps-9350-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Latitude 7350 Detachable (Core Ultra 5 – 134U, 16GB, 256GB, 13 3K Touch)', 'new-100-dell-latitude-7350-detachable-core-ultra-5-134u-16gb-256gb-13-3k-touch-106', N'CPU: Intel® Core™ Ultra 5 134U (12 MB cache, 12 cores, 14 threads, up to 4.40 GHz Turbo) | RAM: 16GB LPDDR5x 6400 MT/s dual-channel (onboard) | HARD DISK: 256 GB, M.2 2230, TLC PCIe Gen 4 NVMe, SSD | VGA: Integrated Intel(R) Graphics | LCD: 13″, 3K 2880×1920, IPS, Touch, AR, AS, Gorilla® Glass Victus®, Low Blue Light, Active Pen Support | PORTS: Thunderbolt 4 với Power Delivery 3.0 và DisplayPort (USB Type-C) | DIMENSION: Chiều rộng: 292.94 mm (11.53 in) Chiều sâu: 208.00 mm (8.19 in) Chiều cao tối thiểu: 8.90 mm (0.35 in) | WEIGHT: 0.79 kg', 30990000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/03/Dell-detachable-7350-6.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell XPS 13 9350 2025 (Ultra 7 268V, 32GB, 512GB, Intel Arc Graphics, 13.4 2K+ Touch 120Hz Graphite)', 'new-100-dell-xps-13-9350-2025-ultra-7-268v-32gb-512gb-intel-arc-graphics-134-2k-touch-120hz-graphite-107', N'CPU: Intel® Core™ Ultra 7 256V (12MB Cache, 8 cores, up to 5.0 GHz) | RAM: 32GB, LPDDR5X, 8533MT/s | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: Intel® Arc™ Graphics | Màn hình: 13.4″, 2K+, 30-120Hz, Touch, Anti-Glare, 500 nit, EyeSafe, InfinityEdge | Webcam: FHD webcam | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) ports with Power Delivery (Type-C®) | Trọng lượng: 1.2 kg | Pin: 3Cell 55Whr | Hệ điều hành: No-OS', 44890000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/Untitled-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell XPS 13 9350 2025 (Ultra 7 258V, 32GB, 512GB, Intel Arc Graphics, 13.4 FHD+ 120Hz)', 'new-100-dell-xps-13-9350-2025-ultra-7-258v-32gb-512gb-intel-arc-graphics-134-fhd-120hz-108', N'CPU: Intel® Core™ Ultra 7 256V (12MB Cache, 8 cores, up to 4.8 GHz) | RAM: 32GB, LPDDR5X, 8533MT/s | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: Intel® Arc™ Graphics | Màn hình: 13.4″, FHD+ 1920 x 1200, 30-120Hz, Non-Touch, Anti-Glare, 500 nit, EyeSafe, InfinityEdge | Webcam: FHD webcam | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) ports with Power Delivery (Type-C®) | Trọng lượng: 1.2 kg | Pin: 3Cell 55Whr | Hệ điều hành: Window 11 bản quyền', 39290000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/12/Dell-xps-9350-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook 5 Flip 14-fp0013dx (Core 5 120U, 8GB, 512GB, 14 2K Touch)', 'new-100-hp-omnibook-5-flip-14-fp0013dx-core-5-120u-8gb-512gb-14-2k-touch-109', N'CPU: Intel Core 5 – 120U (10 Cores / up to 5.0 GHz, 12MB) | RAM: 8GB LPDDR5 5200MHz | Ổ cứng: 512GB PCIe NVMe SSD | GPU: Intel Graphics | Màn hình: 14″ (1920 x 1200) 2K, LED, Touch, 300 nits | Webcam: MP Front-Facing | Cổng kết nối: 2 x USB-C 3.1 1 x USB-A 3.1 1 x USB-A 3.0 1x HDMI 2.1 1x Jack 3.5mm | Pin: 4-cell, 68Wh | Trọng lượng: 1.65 kg | Hệ điều hành: Window 11 bản quyền', 15190000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/piit3n75-2074-hp-omnibook-5-flip-2-in-1-intel-core-7-150u-16gb-512gb-intel-graphics-14-fhd-new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Vivobook S 14 Flip TP3402VA-LZ632W (Core i5-13420H, 16GB, 512GB, Intel UHD Graphics, 14 FHD+ Touch)', 'new-100-asus-vivobook-s-14-flip-tp3402va-lz632w-core-i5-13420h-16gb-512gb-intel-uhd-graphics-14-fhd-touch-110', N'CPU: Intel® Core™ i5-13420H Processor 2.1 GHz (12MB Cache, up to 4.6 GHz, 8 cores, 12 Threads) | Ram: 8GB DDR4 on board + 8GB DDR4 SO-DIMM | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: Intel® UHD Graphics | Màn hình: Cảm ứng 14.0-inch WUXGA (1920 x 1200) 16:10, IPS, 60Hz, 300nits Brightness, 45% NTSC color gamut, Glossy display, TÜV Rheinland-certified | Webcam: 1080p FHD camera với nắp che linh hoạt | Cổng kết nối: 1x USB 2.0 Type-A (data speed up to 480Mbps) 1x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x USB 3.2 Gen 2 Type-C with support for display / power delivery (data speed up to 10Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack 1x DC-in | Trọng lượng: 1.50 kg | Pin: 50WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 17290000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/vivobook_s_14_flip_tp3402v_refresh_product_photo_2s_cool_silver_05_2400x2400_2.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 16 G7 AHP (Ryzen 7-8845H, 16GB, 1TB, 16.0 2K+ IPS 120Hz)', 'new-100-lenovo-thinkbook-16-g7-ahp-ryzen-7-8845h-16gb-1tb-160-2k-ips-120hz-111', N'CPU: Ryzen 7 8845H (3.8 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: AMD Radeon™ 780M | Màn hình: 16″ (2560×1600) IPS, 350nits, 100% sRGB, 120Hz, TCON | Camera: 1080p IR | Kết nối: 1x USB type C 1x Thunderbolt 4 1x HDMI 2.1 1x Headphone / mic combo 3.5 2x USB type A 1x TGX 1x Đầu đọc thẻ SD, 1x RJ45 | Trọng lượng: 1.7 kg | Pin: 4cell 71Wh | Hệ điều hành: Windows 11 bản quyền', 18290000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3660_3239_thinkbook_g7_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 14 G7+ 2025 AHP (Ryzen AI 7 H 260, 32GB, 1TB, 14.5 3K 120Hz)', 'new-100-lenovo-thinkbook-14-g7-2025-ahp-ryzen-ai-7-h-260-32gb-1tb-145-3k-120hz-112', N'CPU: Ryzen AI 7 H 260 (2 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 24MB Cache) | RAM: 32GB LPDDR5x-7500 MHz (không nâng cấp được ram) | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: AMD Radeon 780M | Màn hình: 14.5″ 3K (3072×1920) IPS, 16:10, 1200:1, 500nits, 120Hz, 100% DCI-P3, DeltaE <1, Dolby® Vison, TÜV Low Blue Light. | Webcam: 1080P FHD RGB/IR Hybrid with Dual Microphone | Cổng kết nối: 1x USB 3.2 Gen 2 Type-C 1x USB 4.0 Type-C 1x HDMI 2.1 1x USB 3.2 Gen 1 Type-A 1x Headphone / mic combo 3.5 1x RJ45 1x USB 3.2 Gen 1 Type-A 1x SD, 1x USB 2.0 Type-A | Pin: 4cell 85Wh | Trọng lượng: 1.5 kg | Hệ điều hành: Window 11 bản quyền', 26490000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3624_thinkbook_14_g7__2025_1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook X Flip 14 2in1 (Ryzen AI 5 340, 16GB, 512GB, 14 2K Touch)', 'new-100-hp-omnibook-x-flip-14-2in1-ryzen-ai-5-340-16gb-512gb-14-2k-touch-113', N'CPU: AMD Ryzen AI 5 340, 6-Core, 2.00 GHz up to 4.80 GHz, 16 MB Cache | RAM: 16GB LPDDR5x-7500 MHz RAM, 512GB PCIe Gen4 NVMe M.2 SSD | Ổ cứng: 512GB PCIe NVMe SSD | GPU: Radeon 840M Graphics | Màn hình: 14” 2K IPS 400 nits Touch Display | Webcam: 5MP IR camera with temporal noise reduction and integrated dual array digital microphones | Cổng kết nối: 2x USB Type-A 2x USB Type-C 1x HDMI 1x Headphone/Microphone combo jack | Pin: 3-cell, 59Wh Li-ion polymer | Trọng lượng: 1.4 kg | Hệ điều hành: Window 11 bản quyền', 18990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/HP-Omnibook-X-Flip-Thegioiso365.vn-8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook X Flip 16 2in1 (Ryzen AI 5 340, 16GB, 512GB, 16 2K Touch)', 'new-100-hp-omnibook-x-flip-16-2in1-ryzen-ai-5-340-16gb-512gb-16-2k-touch-114', N'CPU: AMD Ryzen AI 5 340, 6-Core, 2.00 GHz up to 4.80 GHz, 16 MB Cache | RAM: 16GB LPDDR5x-7500 MHz RAM, 512GB PCIe Gen4 NVMe M.2 SSD | Ổ cứng: 512GB PCIe NVMe SSD | GPU: Radeon 840M Graphics | Màn hình: 16” 2K IPS 400 nits Touch Display | Webcam: 5MP IR camera with temporal noise reduction and integrated dual array digital microphones | Cổng kết nối: 2x USB Type-A 2x USB Type-C 1x HDMI 1x Headphone/Microphone combo jack | Pin: 3-cell, 59Wh Li-ion polymer | Trọng lượng: 1.89 kg | Hệ điều hành: Window 11 bản quyền', 19490000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/s-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP OmniBook 5 Flip 14-fp0023dx (Core 7 150U, 16GB, 512GB, 14 2K Touch)', 'new-100-hp-omnibook-5-flip-14-fp0023dx-core-7-150u-16gb-512gb-14-2k-touch-115', N'CPU: Intel Core 7 – 150U (10 Cores / up to 5.4 GHz, 12MB) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 512GB PCIe NVMe SSD | GPU: Intel Graphics | Màn hình: 14″ (1920 x 1200) 2K, LED, Touch, 300 nits | Webcam: MP Front-Facing | Cổng kết nối: 2 x USB-C 3.1 1 x USB-A 3.1 1 x USB-A 3.0 1x HDMI 2.1 1x Jack 3.5mm | Pin: 4-cell, 68Wh | Trọng lượng: 1.65 kg | Hệ điều hành: Window 11 bản quyền', 20790000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/piit3n75-2074-hp-omnibook-5-flip-2-in-1-intel-core-7-150u-16gb-512gb-intel-graphics-14-fhd-new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Vivobook 14 A1407CA-LY008WS (Ultra 5 225H, 16GB, 512GB, Intel Arc Graphics, 14.0 FHD+ IPS)', 'new-100-asus-vivobook-14-a1407ca-ly008ws-ultra-5-225h-16gb-512gb-intel-arc-graphics-140-fhd-ips-116', N'CPU: Intel Core Ultra 5 225H 1.7 GHz (18MB Cache, up to 4.9 GHz, 14 cores, 16 Threads); Intel® AI Boost NPU up to 13 | Ram: 16GB DDR5 (2 khe, tối đa 32GB) | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: Intel® Arc™ Graphics | Màn hình: 14 FHD+ (1920 x 1200) 16:10 IPS 60Hz 400nits 100% sRGB Anti-glare display | Webcam: 1080p FHD camera ; With privacy shutter | Cổng kết nối: 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-C with support for display / power delivery (data speed up to 5Gbps) 1x HDMI 1.4 1x 3.5mm Combo Audio Jack | Trọng lượng: 1.46 kg | Pin: 42WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 19190000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/asus_vivobook_14_a1407_3.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP EliteBook 640 G10 (Core i7-1355U, 16GB, 512GB, Iris Xe Graphics, 14 FHD IPS)', 'new-100-hp-elitebook-640-g10-core-i7-1355u-16gb-512gb-iris-xe-graphics-14-fhd-ips-117', N'CPU: Intel® Core™ i7-1355U (1.70GHz up to 5.00GHz, 12MB Cache) | RAM: 16GB (1x16GB) DDR4 3200MHz (2 khe) | Ổ cứng: 512GB PCIe NVMe M.2 SSD | GPU: Intel® Iris® Xe Graphics | Màn hình: 14.0 inch FHD (1920 x 1080), IPS, narrow bezel, anti-glare, 250 nits, 45% NTSC | Webcam: 720p HD camera | Cổng kết nối: 1 x Thunderbolt™ 4 with USB4™ Type-C® 40 Gbps signaling rate (USB Power Delivery, DisplayPort™ 1.4) 1 x SuperSpeed USB Type-C® 10Gbps signaling rate (USB Power Delivery, DisplayPort™ 1.4) 2 x SuperSpeed USB Type-A 5Gbps signaling rate port (USB 3.2 Gen 1) 1 x HDMI 2.1 Port (Cable not included) 1 x Ethernet Port (RJ-45) 1 x Audio Combo Jack 1 x Power Connector 1 x Nano Security Lock Slot (Lock sold separately) | Pin: 3Cell 51WHrs | Trọng lượng: 1.41 kg | Hệ điều hành: Window 11 bản quyền', 14990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/screenshot.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Vivobook S 14 Q423SA-U5512 (Core Ultra 5 226V, 16GB, 512GB, Intel Arc Graphics, 14.0 FHD+ OLED)', 'new-100-asus-vivobook-s-14-q423sa-u5512-core-ultra-5-226v-16gb-512gb-intel-arc-graphics-140-fhd-oled-118', N'CPU: Intel® Core™ Ultra 5 226V (2.10GHz up to 4.50GHz, 8MB Cache) | Ram: 16GB LPDDR5X | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: Intel® Arc™ Graphics | Màn hình: 14.0inch FHD+ (1920 x 1200) OLED 16:10, 60Hz | Webcam: FHD camera with IR function to support Windows Hello With privacy shutter | Cổng kết nối: 2 x USB 3.2 Gen 1 Type-A 2 x Thunderbolt™ 4 with support for display / power delivery (data speed up to 40Gbps) 1 x HDMI 2.1 TMDS 1 x 3.5mm Combo Audio Jack Wi-Fi 7(802.11be) (Tri-band)2*2 Bluetooth 5.4 | Trọng lượng: 1.30 kg | Pin: 4Cell 75WHrs, 4S1P | Hệ điều hành: Windows 11 bản quyền', 16490000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/03/asus-2.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo IdeaPad Slim 5 (XiaoXin 14 AHP9) (Ryzen 7 8745H, 16GB, 512GB, AMD 780M, 14 FHD+ IPS)', 'new-100-lenovo-ideapad-slim-5-xiaoxin-14-ahp9-ryzen-7-8745h-16gb-512gb-amd-780m-14-fhd-ips-119', N'CPU: AMD Ryzen™ 7 8745H (3.2 GHz up to 4.9 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB LPDDR5X 6400MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | CPU: AMD Radeon Graphic 780M | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: 1080P Full HD | Cổng kết nối: 2x cổng USB-C 3.2 Gen 2 1x HDMI 1x Jack tai nghe 3.5mm 1x khe đọc ghi thẻ MicroSD 2x cổng USB-A 3.2 Gen 1 | Trọng lượng: 1.46 kg | Pin: 57Wh 100W Type – C | Hệ điều hành: Windows 11 bản quyền', 14990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/12/XiaoXin-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Văn phòng';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7670 (Core i7-12850HX, 32GB, 512GB, RTX A2000 8GB, 16 FHD IPS)', 'like-new-dell-precision-7670-core-i7-12850hx-32gb-512gb-rtx-a2000-8gb-16-fhd-ips-120', N'CPU: 12th Thế hệ Intel Core i7-12850HX, vPro (16 nhân 24 luồng, 25M Cache, 3.4GHz up to 4.8 GHz Turbo, 55W, vPro) | RAM: 32GB DDR5 | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A2000 8GB GDDR6 | Màn hình: 16-inch, FHD 1920 x 1080, 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x Thunderbolt 4 (USB Type-C) 1x USB 3.2 Gen 2 Type-C với chế độ alt DisplayPort 1x USB 3.2 Gen 1 với PowerShare 1x USB 3.2 Gen 1 | Pin: 6cell 83Wh | Trọng lượng: 2.6 kg | Hệ điều hành: Window bản quyền', 29690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7670-thinkpro-001.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion R7000P AHP9 (Ryzen 7-8845H, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 165Hz)', 'like-new-lenovo-legion-r7000p-ahp9-ryzen-7-8845h-16gb-1tb-rtx-4060-8gb-16-2k-165hz-121', N'CPU: Ryzen 7-8845H, up to 5.1GHz | RAM: 16 GB DDR5 | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 29490000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2026/04/Lenovo-Legion-Slim-5-6-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Asus Gaming Vivobook K3605ZC-RP564W (Core i5-12500H, 16GB, 512GB, RTX 3050 4GB, 16 FHD+ 144Hz)', 'like-new-asus-gaming-vivobook-k3605zc-rp564w-core-i5-12500h-16gb-512gb-rtx-3050-4gb-16-fhd-144hz-122', N'CPU: Intel® Core™ i5-12500H (2.50GHz up to 4.50GHz, 18MB Cache) | RAM: 16GB DDR4 3200MHz on board + 1 khe SO-DIMM | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA® GeForce® RTX™ 3050 4GB GDDR6 | Màn hình: 16″ FHD+ (1920×1200) 16:10, IPS, 144Hz, 45% NTSC, 300nits, Anti-glare display, TÜV Rheinland-certified | Cổng kết nôi: 1 x Type-C® USB 3.2 Gen 1 support power deliver 2 x USB 3.2 Gen 1 Type A 1 x HDMI 2.1 1 x 3.5mm combo audio jac 1 x DC-in | Trọng lượng: 1.8 kg | Pin: 3Cell 70WHrs, 3S1P | Hệ điều hành: Windows 11 Home bản quyền', 15990000, 4, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/06/vivobook_16x_k3605z_k3605v_product_photo_2k_indie_black_05_non-fingerprint_non-backlit.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo LOQ Essential 15IAX9E (Core i5-12450HX, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'like-new-lenovo-loq-essential-15iax9e-core-i5-12450hx-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-123', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: Intel® Core™ i5-12450HX (2.00GHz up to 4.40GHz, 12MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz | Bộ nhớ trong – Ram: 16GB (1 x 16GB) SO-DIMM DDR5-4800MHz (1 slots, up to 32GB) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: 1 x Card reader | Webcam: HD 720p with Privacy Shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 2 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 5Gbps / USB 3.2 Gen 1), data transfer only 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 57WHrs | Trọng lượng: 1.77 kg | Xuất xứ: Trung Quốc', 18590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/08/lenovo-loq-2024-i5-jpg_1726303572.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo LOQ 15ARP9 (Ryzen 7-7435HS, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'like-new-lenovo-loq-15arp9-ryzen-7-7435hs-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-124', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: AMD Ryzen™ 7-7435HS (3.10GHz up to 4.50GHz, 16MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz, G-SYNC® | Bộ nhớ trong – Ram: 16GB SO-DIMM DDR5-4800MHz | Ổ cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 4050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: — | Webcam: HD 720p with E-shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 11ax 2×2 | Cổng giao tiếp – Port: 3 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with Lenovo® PD 140W and DisplayPort™ 1.4 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 4Cell 60WHrs | Trọng lượng: 2.38 kg | Xuất xứ: Trung Quốc', 19390000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/08/loq-2024-_1734921958-copy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion Y9000P (Core i9-13900HX, 16GB, 1TB, RTX 4060 , 16 2.5K 240Hz)', 'like-new-lenovo-legion-y9000p-core-i9-13900hx-16gb-1tb-rtx-4060-16-25k-240hz-125', N'CPU: Intel Core i9-13900HX (24 Cores, 32 Threads, P-core up to 5.4GHz, E-core up to 3.9GHz, 36MB Cache) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 (140W) | MUX Swìtch: Có | Màn hình: 16.0 inch (1600 x 2560 ,16:10), 2.5k WQXGA IPS, 240Hz,  100% sRGB | Webcam: 720P | Cổng kết nối: 2x USB-C Display port 1.4 3x USB-A 3.2 Gen 1 1x USB-A 3.2 Gen 1 (One Always On) 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.53 kg | Pin: 4 Cell, 80 Wh | Hệ điều hành: Windows bản quyền', 29990000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/06/y9000.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion R9000P ARX8 (Ryzen 9-7945HX, 16GB, 1TB, RTX 4060 8GB, 16 2.5K 240Hz Glacier White)', 'like-new-lenovo-legion-r9000p-arx8-ryzen-9-7945hx-16gb-1tb-rtx-4060-8gb-16-25k-240hz-glacier-white-126', N'CPU: AMD Ryzen 9 7945HX (16 cores x 32 threads, 2.5 up to 5.4GHz, 64MB Cache) | RAM: 16GB RAM DDR5 5600MHz | Ổ cứng: 1 TB M.2 2280 PCIe 4.0 SSD | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 (140W) | MUX Swìtch: Có | Màn hình: 16 inch WQXGA (2560 x 1600), IPS, Anti-Glare, Non-Touch, 100%sRGB, 500 nits, 240Hz, LED Backlight, Narrow Bezel, Low Blue Light | Webcam: 720P | Cổng kết nối: 2x USB-C Thunderbolt 4 3x USB-A 3.2 Gen 1 1x USB-A 3.2 Gen 1 (One Always On) 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.53 Kg | Pin: 6-Cell, 80 Wh | Hệ điều hành: Windows bản quyền', 30990000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/z6546315741884_ce41fe035315c165642fe1008106e7df.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo IdeaPad Slim 3 15 2025 (Xiaoxin 15c AHP10) (Ryzen 7 8745HS, 16GB, 512GB, AMD 780M, 15.1 2K+ OLED 165Hz)', 'like-new-lenovo-ideapad-slim-3-15-2025-xiaoxin-15c-ahp10-ryzen-7-8745hs-16gb-512gb-amd-780m-151-2k-oled-165hz-127', N'CPU: AMD Ryzen™ 7 8745HS (3.8 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB DDR5 5600MHz (8GB onboard + 8GB ) upto 40GB | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 780M | Màn hình: 15.1″ 2.5K(2560×1600), 100% DCI-P3, OLED 165Hz | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 2x USB-A 3.2 Gen 1 1x USB-C® (USB 5Gbps) tích hợp tính năng PD 3.0 & DP 1.2 1x HDMI 1x khe đọc-ghi thẻ SD 1x jack tai nghe 3.5 | Pin: 60 Wh | Trọng lượng: ~1,49 kg | Hệ điều hành: Window 11 bản quyền', 12990000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/05/ideapad_slim_3_15cahp10_2025_1747989305.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion R7000 15AHP9 (Ryzen 7-8745H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'like-new-lenovo-legion-r7000-15ahp9-ryzen-7-8745h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-128', N'CPU: Ryzen 7-8745H (8 nhân 16 luồng, tần số cơ bản 3.8GHz, có thể đạt tới 4.9GHz với turbo boost, bộ nhớ đệm 8MB L2 / 16MB L3, 4nm, TDP 35-54W) | RAM: 16 GB DDR5 5600MHz | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4050 6GB GDDR6 | Màn hình: 15.6″ (1920×1080) IPS, 300nits, 100% sRGB, 144Hz | Webcam: HD Webcam | Cổng kết nối: 1 x E-camera shutter 1 x SD card 2 x USB-A 3.2 Gen 2 1 x RJ45 (mạng LAN) 1 x HDMI 2.1 1 x power input 2 x USB-C 3.2 gen 2 | Trọng lượng: 2.4 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 25290000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/08/3416_3355_3126_3004_c3zzbg9e5memiezohvjlvty9e_3819.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7680 (Core i7-13850HX, 64GB, 1TB, RTX 4090 16GB, 16 FHD+)', 'like-new-dell-precision-7680-core-i7-13850hx-64gb-1tb-rtx-4090-16gb-16-fhd-129', N'CPU: Intel® Core™ i7-13850HX (30MB Cache, 28 Threads, 20 Cores (8P+12E) up to 5.3GHz, 55w, vPro) | RAM: 64GB, 5600MT/s CAMM, non-ECC | Ổ cứng: 512GB M.2 PCIe NVMe Gen 4 2280 SSD | GPU: NVIDIA® RTX™ 4090, 16GB GDDR6 | Màn hình: 16″ FHD+ 1920×1200 WLED, WVA, 60Hz, anti-glare, non-touch, 100% DCI-P3, 500 nits, IR Camera with Mic | Webcam: HD Camera | Cổng kết nối: 2x ThunderBolt™ 4 3x USB 3.2 1x HDMI 2.1 1x RJ45 1x Headset 1x SD-card slot | Pin: 83 Wh, 6 Cell, Lithium Ion Polymer | Trọng lượng: 2.6 kg | Hệ điều hành: Window 11 bản quyền', 53290000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/10/dell-precision-7680-gen-13th-1683279550.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad X1 Carbon Gen 11 (Core i7-1365U, 32GB, 512GB, 14 FHD+)', 'like-new-lenovo-thinkpad-x1-carbon-gen-11-core-i7-1365u-32gb-512gb-14-fhd-130', N'CPU: 13th Generation Intel® Core™ i7-1365u™ (E-Core Max 2.10 GHz, P-Core Max 4.70 GHz with Turbo Boost, 12 Cores, 16 Threads, 18 MB Cache) | RAM: 32 GB LPDDR5 5200MHz (Soldered) | Ổ cứng: 512GB PCIe SSD Gen 4 Performance | GPU: Integrated Intel® Iris® Xe Graphics | Màn hình: 14.0″ WUXGA (1920 x 1200) IPS, anti-glare, low power, 400 nits | Webcam: 1080p FHD | Cổng kết nối: 2 x USB Type C 2 x USB Type A 1 x HDMI 1 x Jack tai nghe 3.5mm | Pin: 57WHr Li-Polymer | Trọng lượng: 1.12kg | Hệ điều hành: Window 11 bản quyền', 26690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/11/01-X1-Carbon-G11-Hero-Front-Facing-x1qh-.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion R7000 15AHP9 (Ryzen 7-8745H, 16GB, 512GB, RTX 4060 8GB, 15.6 FHD 144Hz)', 'like-new-lenovo-legion-r7000-15ahp9-ryzen-7-8745h-16gb-512gb-rtx-4060-8gb-156-fhd-144hz-131', N'CPU: Ryzen 7-8745H (8 nhân 16 luồng, tần số cơ bản 3.8GHz, có thể đạt tới 4.9GHz với turbo boost, bộ nhớ đệm 8MB L2 / 16MB L3, 4nm, TDP 35-54W) | RAM: 16 GB DDR5 5600MHz | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 15.6″ (1920×1080) IPS, 300nits, 100% sRGB, 144Hz | Webcam: HD Webcam | Cổng kết nối: 1 x E-camera shutter 1 x SD card 2 x USB-A 3.2 Gen 2 1 x RJ45 (mạng LAN) 1 x HDMI 2.1 1 x power input 2 x USB-C 3.2 gen 2 | Trọng lượng: 2.4 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 26390000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/08/3416_3355_3126_3004_c3zzbg9e5memiezohvjlvty9e_3819.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion Y7000P (Core i7-14650HX, 16GB, 512GB, RTX 4060 8GB, 16 2K+ 165Hz)', 'like-new-lenovo-legion-y7000p-core-i7-14650hx-16gb-512gb-rtx-4060-8gb-16-2k-165hz-132', N'CPU: 14th Generation Intel® Core™ i7-14650HX, 16C (8P + 8E) / 24T, P-core up to 5.2GHz, E-core up to 3.7GHz, 30MB Cache | RAM: 16 GB DDR5 | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 27290000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3174_3147_khuuf49zxptmtaygwzuivedgz_7317.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] HP EliteBook 850 G8 Notebook (Core i7-1185G7, 8GB, 256GB, 15.6 FHD)', 'like-new-hp-elitebook-850-g8-notebook-core-i7-1185g7-8gb-256gb-156-fhd-133', N'CPU: 11th Generation Intel® Core™ i7 1185G7 Processor Base Frequency 1.20GHz, Max Turbo 4.80GHz ( 4 Cores, 8 Threads, 12MB Smart Cache) | RAM: 8GB DDR4 3200MHz | Ổ cứng: 256 GB SSD NVMe PCIe | GPU: Intel Iris Xe Graphics | Màn hình: 15.6 FHD (1920 x 1080), 60Hz, 16:9, 250Nits, 45% NTSC | Webcam: 720P | Cổng kết nối: 2x Type C 2x USB 1x HDMI 1x 3.5mm | Pin: 3cell 56WHr | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 9740000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/08/HP-Elitebook-850-G8-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7670 (Core i7-12850HX, 16GB, 512GB, RTX A1000 4GB, 16 FHD IPS)', 'like-new-dell-precision-7670-core-i7-12850hx-16gb-512gb-rtx-a1000-4gb-16-fhd-ips-134', N'CPU: 12th Thế hệ Intel Core i7-12850HX, vPro (16 nhân 24 luồng, 25M Cache, 3.4GHz up to 4.8 GHz Turbo, 55W, vPro) | RAM: 16GB DDR5 | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A1000 4GB GDDR6 | Màn hình: 16-inch, FHD 1920 x 1080, 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x Thunderbolt 4 (USB Type-C) 1x USB 3.2 Gen 2 Type-C với chế độ alt DisplayPort 1x USB 3.2 Gen 1 với PowerShare 1x USB 3.2 Gen 1 | Pin: 6cell 83Wh | Trọng lượng: 2.6 kg | Hệ điều hành: Window bản quyền', 25690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7670-thinkpro-001.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7670 (Core i9-12950HX, 32GB, 1TB, RTX A3000 12GB, 16 FHD IPS)', 'like-new-dell-precision-7670-core-i9-12950hx-32gb-1tb-rtx-a3000-12gb-16-fhd-ips-135', N'CPU: 12th Thế hệ Intel Core i9-12950HX, vPro (16 nhân 24 luồng, 30M Cache, up to 5.0 GHz Turbo, 55W, vPro) | RAM: 32GB DDR5 | Ổ cứng: 1TB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A3000 12GB GDDR6 | Màn hình: 16-inch, FHD 1920 x 1080, 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x Thunderbolt 4 (USB Type-C) 1x USB 3.2 Gen 2 Type-C với chế độ alt DisplayPort 1x USB 3.2 Gen 1 với PowerShare 1x USB 3.2 Gen 1 | Pin: 6cell 83Wh | Trọng lượng: 2.6 kg | Hệ điều hành: Window bản quyền', 36590000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7670-thinkpro-001.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Latitude 7450 (Core Ultra 7 165U, 32GB, 512GB, 14 inch 2.5K Touch)', 'like-new-dell-latitude-7450-core-ultra-7-165u-32gb-512gb-14-inch-25k-touch-136', N'CPU: Intel® Core™ Ultra 7 165U, vPRO (12MB cache, 12 cores, 14 threads, up to 4.9 GHz Max Turbo) | RAM: 32 GB: LPDDR5x, 6400 MT/s (onboard) | HARD DISK: 512 GB, M.2 2230, TLC PCIe Gen 4 NVMe, SSD | VGA: Intel® Graphics | LCD: 14″ 2.5K ComfortView Plus, Touch | PORTS: 2x USB Type-C Thunderbolt™ 4.0 with Power Delivery & DisplayPort 2.1 2x USB 3.2 Gen 1, one with Power Share 1x HDMI 2.1 1x Optional external uSIM card tray (WWAN only) 1x Optional Touch Fingerprint Reader in Power Button 1x Universal Audio jack | DIMENSION: Height (front): 0.67 in. (17.10 mm) Height (rear): 0.72 in. (18.21 mm) Width: 12.32 in. (313.00 mm) Depth: 8.77 in. (222.8 mm) | WEIGHT: 1.33 kg', 19790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Dell-Latitude-7450-1-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkBook 16 G7+ 2025 AHP (Ryzen 7 H 255, 24GB, 512GB, 16.0 2K+ 120Hz)', 'like-new-lenovo-thinkbook-16-g7-2025-ahp-ryzen-7-h-255-24gb-512gb-160-2k-120hz-137', N'CPU: Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản ~3.8GHz, tối đa có thể đạt ~4.9GHz, 8MB L2 Cache, 16MB L3 Cache) | RAM: 24GB LPDDR5x 7500MT/s | Ổ cứng: 512GB SSD PCIe 4.0 | GPU: AMD Radeon 780M | Màn hình: 16 inch, 16:10, 2K+, IPS, 100% sRGB, 100% DCI-P3, 120Hz, 500 nits | Webcam: 1080p IR | Cổng kết nối: 1 x USB-A 3.2 Gen 2 2 x USB-A 3.2 Gen 1 1 x HDMI 2.1 1 x USB4 1 x Jack 3.5mm 1 x RJ45 1 x SD 1 x USB 2.0 | Pin: 4cell 85Wh | Trọng lượng: 1.9 kg | Hệ điều hành: Window 11 bản quyền', 18590000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3617_lenovo_thinkbook_16_g7_-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Legion Y7000 2025 (Core i7-14650HX, 16GB, 512GB, RTX 5060 8GB, 15.3 2K+ 180Hz)', 'like-new-lenovo-legion-y7000-2025-core-i7-14650hx-16gb-512gb-rtx-5060-8gb-153-2k-180hz-138', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 16GB DDR5 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ 2K+ (2560×1600) IPS, non-touch, 400nits, 180Hz, | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 29490000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3715_brcvhww7eofpn561dte0uyi6n_0720.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Asus TUF Gaming A15 FA506N (Ryzen 7-7445HS, 16GB, 512GB, RTX 3050 4GB, 15.6 FHD IPS 144Hz)', 'like-new-asus-tuf-gaming-a15-fa506n-ryzen-7-7445hs-16gb-512gb-rtx-3050-4gb-156-fhd-ips-144hz-139', N'CPU: AMD Ryzen™ 7-7445HS (3.55GHz up to 4.7GHz, 16MB Cache) | RAM: 16GB DDR5-5600MHz SO-DIMM (2x SO-DIMM slots, up to 32GB) | Ổ cứng: 512GB PCIe® 3.0 NVMe™ M.2 SSD (Còn trống 1 khe SSD M.2 PCle) | GPU: NVIDIA® GeForce RTX™ 3050 4GB GDDR6 | Màn hình: 15.6″ FullHD (1920 x 1080), 144Hz, G-sync, IPS Panel | Cổng kết nôi: 1x RJ45 LAN port 1x Thunderbolt™ 4 support DisplayPort™ 1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC 2x USB 3.2 Gen 1 Type-A 1x 3.5mm Combo Audio Jack | Trọng lượng: 2.2kg | Pin: 3 Cell 48WHr | Hệ điều hành: Windows 11 Home bản quyền', 18990000, 4, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23672_screenshot_1756286049.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Acer Predator Helios Neo 16 (Core i9-13900HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 165Hz)', 'like-new-acer-predator-helios-neo-16-core-i9-13900hx-16gb-1tb-rtx-4060-8gb-16-2k-165hz-140', N'CPU: Intel Core i9-13900HX (24 Cores/ 32 Threads, up to 5.40 GHz, 36MB | RAM: 16GB DDR5 4800MHz | Ổ cứng: 1TB PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB 140W | Màn hình: 16″ 2K+ IPS, LCD, LED, màn nhám, chống lóa, không cảm ứng, tần số quét màn 165Hz, tỷ lệ khung hình 16:10, độ phủ màu 100%sRGB | Webcam: HD Webcam | Cổng kết nối: 2x USB 3.2 Type-C Gen 2 1x USB 3.2 Type-A Gen 1 2x USB 3.2 Type-A Gen 2 1x microSD™ Card reader 1x HDMI 2.1 1x RJ45 1x Jack 3.5mm 1x Cổng nguồn | Pin: 4-cell, 90 Wh | Trọng lượng: 2.6kg | Hệ điều hành: Window 11 bản quyền', 28890000, 5, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Predator-Helios-Neo-2023-PHN16-71-54W3-400x400-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c AHP10) (Ryzen 5-8640HS, 8GB, 256GB, AMD 780M, 14 FHD+ OLED)', 'like-new-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ahp10-ryzen-5-8640hs-8gb-256gb-amd-780m-14-fhd-oled-141', N'CPU: AMD Ryzen™ 5 8640HS (3.5 GHz up to 4.9 GHz, 6 Cores, 12 Threads, 16MB Cache) | RAM: 8GB LPDDR5X 5600MHz | Ổ cứng: 256GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 780M | Màn hình: 14 inches FHD+ (1920×1200) OLED, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 10990000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3598_lenovo_xiaoxin_14c_ahp10_1-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Gaming G15 5520 (Core i5-12500H, 16GB, 512GB, RTX 3050Ti 4GB, 15.6 FHD)', 'like-new-dell-gaming-g15-5520-core-i5-12500h-16gb-512gb-rtx-3050ti-4gb-156-fhd-142', N'CPU: Intel Core i5-12500H  (14 cores/ 20 Threads, up to 4,70GHz, 24MB Cache) | RAM: 16GB DDR5 4800Mhz | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA GeForce RTX 3050Ti 4GB GDDR6 | Màn hình: 15.6 inch FHD 120Hz (16:9), 300 nits, 68% sRGB | Webcam: HD Webcam | Cổng kết nối: 3 cổng USB A 3.2 1 cổng type C 3.2 1 cổng Jack 3.5 1 cổng HDMI 2.1 Thunderbolt 4 1 cổng nguồn 1 cổng RJ45 | Trọng lượng: 2.5 kg | Pin: 3 Cells, 86Wh | Hệ điều hành: Windows bản quyền', 18690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/5520-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] MSI Thin 15 B13UC 1411VN (Core i7-13620H, 16GB, 512GB, RTX 3050 4GB, 15.6 FHD 144Hz)', 'like-new-msi-thin-15-b13uc-1411vn-core-i7-13620h-16gb-512gb-rtx-3050-4gb-156-fhd-144hz-143', N'CPU: Intel® Core™ i7-13620H (2.40GHz up to 4.90GHz, 24MB cache) | RAM: 16GB DDR4 3200MHz (2 Slots, Max 64GB) | Ổ cứng: 512GB NVMe PCIe SSD Gen4x4 w/o DRAM (1 Slot gen 4 + 1 Slot Sata HDD) | GPU: NVIDIA® GeForce RTX™ 3050 4GB GDDR6 | Màn hình: 15.6 inch FHD (1920 x 1080) 144Hz, 45%NTSC, IPS-Level | Cổng kết nôi: 1 x Type-C (USB3.2 Gen2 / DP) with PD charging 3 x Type-A USB3.2 Gen1 1 x HDMI™ 2.1 (8K @ 60Hz / 4K @ 120Hz) 1 x RJ45 1 x Mic-in, 1 x Headphone-out | Trọng lượng: 1.86 kg | Pin: 3Cell 52.4Whrs | Hệ điều hành: Windows 11 Home bản quyền', 16890000, 7, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3750_56447_laptop_msi_gaming_thin_15_b13ucx_2080vn_6.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Latitude 7430 (Core i7-1265U, 32GB, 256GB, Iris Xe, 14.0 FHD Alumium Case)', 'like-new-dell-latitude-7430-core-i7-1265u-32gb-256gb-iris-xe-140-fhd-alumium-case-144', N'CPU: 12th Generation Intel® Core™ i7 1265U Processor Base Frequency 3.50GHz, Max Turbo 4.70GHz ( 10 Cores, 12 Threads, 12MB Smart Cache) | RAM: 32GB DDR4 3200 MHz | Ổ cứng: SSD 256GB M2 PCIe NVMe | GPU: Iris Xe Graphics | Màn hình: 14-inch, FHD 1920 x 1080, 60 Hz, anti-glare, 45% NTSC, 250 nits, wide-viewing angle, narrow bent | Webcam: 720P | Cổng kết nối: 2x USB Type-C® Thunderbolt™ 4.0 ports with Power Delivery & DisplayPort 1.4 1x USB 3.2 Gen 1 port with PowerShare 1x headset (headphone and microphone combo) port 1x HDMI 2.0 port | Pin: 4 Cell, 58 Wh, ExpressCharge™ Capable | Trọng lượng: 1.44 kg | Hệ điều hành: Window 11 bản quyền', 14790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/dell-latitude-7430-laptop-l-12th-gen-i7-1265u-16gb-1tb-ssd-14-fhd-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Pro 14 Premium PA14250 2025 (Core Ultra 7 268V, 32GB, 512GB, 14 QHD+Touch)', 'like-new-dell-pro-14-premium-pa14250-2025-core-ultra-7-268v-32gb-512gb-14-qhdtouch-145', N'CPU: Intel® Core™ Ultra 7 268V, vPro® (40 TOPS NPU, 8 cores, up to 5.0 GHz) | RAM: 32 GB: LPDDR5x, 8533 MT/s (onboard) | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: Intel Arc Graphics | Màn hình: 14″ QHD+ (2560*1600) IPS, 16:10, 60Hz, Touch, Anti-Glare, 500 nits | Webcam: 8MP HDR + IR Camera, TNR, Camera Shutter, Microphone | Cổng kết nối: 2 Thunderbolt™ 4 (40 Gbps) with DisplayPort™ Alt Mode/USB Type-C/USB4/Power Delivery ports 1 USB 3.2 Gen 1 (5 Gbps) with PowerShare port 1 HDMI 2.1 port 1 headset (headphone and microphone combo) port | Pin: 3-cell, 60Wh, ExpressCharge™, ExpressCharge™ Boost | Trọng lượng: 1.171 kg | Hệ điều hành: Window 11 bản quyền', 32590000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2026/04/z7360365952854-d6ef66bcd4423d3c94f42ee6200778db-scaled.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Gigabyte G5 MF5 (Core i5-13500H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'like-new-gigabyte-g5-mf5-core-i5-13500h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-146', N'CPU: Intel® Core™ i5-13500H (2.60GHz up to 4.70GHz, 18MB Cache) | RAM: 16GB (2x8GB) DDR5-4800MHz | Ổ cứng: 512GB SSD Gen4 + 1 PCIe 3.0 Upgrade Slot | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 15.6 inch FHD (1920×1080) 144Hz, Anti-glare display | Cổng kết nôi: 1 x USB 2.0 Type-A 1 x USB 3.2 Gen 1 Type-A 2 x USB 3.2 Gen 2 Type-C 1 x Mini DP 1.4 1 x HDMI™ (with HDCP) 1 x RJ45 (LAN) 1 x Microphone jack 1 x Headphone/Microphone combo audio jack | Trọng lượng: 2.10 kg | Pin: 4 Cell 54WHrs | Hệ điều hành: Windows 11 Home bản quyền', 17890000, 9, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/06/47728_laptop_gigabyte_g5_mf5_52v.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c) (Ryzen 7 7735HS, 24GB, 512GB, 14 FHD+ OLED)', 'like-new-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ryzen-7-7735hs-24gb-512gb-14-fhd-oled-147', N'CPU: AMD Ryzen™ 7 7735HS (3.2 GHz up to 4.75 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 24GB DDR5 5600MHz | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 680M | Màn hình: 14 inches FHD+ (1920×1200) OLED, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 15890000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/08/IdeaPad-Slim-3-14IRH10R-CT2-01-w.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Acer Aspire A715-59G (Core i5-12450H, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'like-new-acer-aspire-a715-59g-core-i5-12450h-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-148', N'CPU: Intel Core i5-12450H (up to 4.4GHz, 12MB, 8 nhân, 12 luồng) | RAM: 16GB (16GBx1) DDR4 3200MHz (2 slot, up to 32GB ) | Ổ cứng: 512GB SSD, PCIe Gen4, 16 Gb/s, NVMe | GPU: RTX 3050 6GB (supporting 2560 NVIDIA CUDA Cores) | Màn hình: 15.6 inch FHD (1920 x 1080) IPS SlimBezel, 144Hz | Webcam: HD camera | Cổng kết nối: 2 x USB Type C 2 x USB Standard-A ports, supporting: 1 port for USB 2.0, 1 port for USB 3.2 Gen 1 1 x HDMI 2.1 1 x headphone jack 3.5mm DC-in jack cho AC adapter Mini Displayport 1.4 | Trọng lượng: 1.99 kg | Pin: 54.8Wh 3-cell | Hệ điều hành: Window 11 bản quyền', 17990000, 5, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Acer-Aspire-A715-59G-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad X1 Carbon Gen 9 (Core i7-1185G7, 32GB, 512GB, 14 FHD)', 'like-new-lenovo-thinkpad-x1-carbon-gen-9-core-i7-1185g7-32gb-512gb-14-fhd-149', N'CPU: Intel Core Core i7-1185G7 4C-8T, 3.0GHz upto 4.8GHz, 12MB Cache | RAM: 32GB LPDDR4x 4266MHz | Hard Drive: SSD 512 GB | GPU: Intel Iris Xe Graphics | Display: 14.0 inch FHD | Ports: 2xUSB 3.2 Gen 1, 2xUSB-C (Thunderbolt 4), 1xHDMI 2.0, 3.5mm combo jack | DVD Drive: No | Battery: 57 Wh | OS: Windows 10 Professional 64 Bit | Dimensions: 31.5 x 22.1 x 1.4 (cm) | Weight: 1.1 kg | Color: Black', 16990000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/12/1-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7670 (Core i9-12950HX, 32GB, 1TB, RTX A2000 8GB, 16 FHD IPS)', 'like-new-dell-precision-7670-core-i9-12950hx-32gb-1tb-rtx-a2000-8gb-16-fhd-ips-150', N'CPU: 12th Thế hệ Intel Core i9-12950HX, vPro (16 nhân 24 luồng, 30M Cache, up to 5.0 GHz Turbo, 55W, vPro) | RAM: 32GB DDR5 | Ổ cứng: 1TB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A2000 8GB GDDR6 | Màn hình: 16-inch, FHD 1920 x 1080, 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x Thunderbolt 4 (USB Type-C) 1x USB 3.2 Gen 2 Type-C với chế độ alt DisplayPort 1x USB 3.2 Gen 1 với PowerShare 1x USB 3.2 Gen 1 | Pin: 6cell 83Wh | Trọng lượng: 2.6 kg | Hệ điều hành: Window bản quyền', 34590000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7670-thinkpro-001.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo IdeaPad 5 Pro 16 2025 (Xiaoxin Pro 16 IMH9) (Ultra 7 155H, 16GB, 2TB, RTX 3050 6GB, 16.0 2K+ OLED 120Hz)', 'like-new-lenovo-ideapad-5-pro-16-2025-xiaoxin-pro-16-imh9-ultra-7-155h-16gb-2tb-rtx-3050-6gb-160-2k-oled-120hz-151', N'CPU: Intel Core Ultra 7 155H (1.40GHz up to 4.80GHz, 24MB Cache) | RAM: 16GB LPDDR5x 7500Mhz | Ổ cứng: 2TB (1TBx2) SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 16.0inch 2K (2048×1280) OLED, 500nits, Glossy, 100% DCI-P3, 120Hz, Eyesafe®, DisplayHDR™ True Black 500 | Webcam: 1080p IR | Cổng kết nối: 2x USB type A 3.2 Gen1 1x Headphone / mic combo 3.5 1x HDMI 2.0 1x USB type C 1x đầu đọc thẻ SD | Pin: 4cell 84 Wh | Trọng lượng: ~1,91kg | Hệ điều hành: Window 11 bản quyền', 20590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/01/Lenovo-XiaoXin-Pro-16-2024-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Asus ZenBook Flip 13 UX362FA (Core i7-8565U, 16GB, 1TB, 13.3 FHD+ Touch)', 'like-new-asus-zenbook-flip-13-ux362fa-core-i7-8565u-16gb-1tb-133-fhd-touch-152', N'CPU: Intel Core i7-8565U (1.80 upto 4.60GHz, 4 nhân 8 luồng, 8MB) | RAM: 16GB Onboard LPDDR3 2133Mhz | Ổ cứng: 1TB M.2 NVMe™ PCIe® 4.0 SSD | GPU: Intel® Graphics | Màn hình: 13.3″ LED-backlit FHD (1920 x 1080) IPS – Cảm ứng | Webcam: HD camera | Cổng kết nối: 2 x USB 3.1 Gen 1 Type-C 1 x USB 2.0 Type-A 1 x Standard HDMI 1 x Audio combo jack 1 x DC in | Pin: 3 Cell, 50 Wh | Trọng lượng: 1.3 kg | Hệ điều hành: Window bản quyền', 10690000, 4, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/08/asus_zenbook_flip_13_ux362fa_el205t_90ac50f802494b26867c0cb99c222b6c_master.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Inspiron 14 Plus 7440F 2025 (Intel Core 7 – 240H, 16GB, 1TB, Intel Iris Xe Graphics, 14 2K+ 90Hz)', 'like-new-dell-inspiron-14-plus-7440f-2025-intel-core-7-240h-16gb-1tb-intel-iris-xe-graphics-14-2k-90hz-153', N'CPU: Intel Core 7 – 240H ( 10 Cores, 16 Threads, 24MB Cache, 2.5GHz up to 5.2 GHz ) | RAM: 16GB DDR5 6400MT/s | Ổ cứng: 1TB SSD PCIe 4.0 | GPU: Intel Iris Xe Graphics | Màn hình: 14” QHD (2560×1440), 90Hz | Webcam: 1080p | Cổng kết nối: 2x USB Type-C® 3.2 Gen 2 (10 Gbps) with Power Delivery and DisplayPort™ 1.4 ports 2x USB 3.2 Gen 1 Type-A ports 1x Universal audio port 1x HDMI 1.4 port | Pin: 4 Cell, 64 Wh, integrated | Trọng lượng: 1.6 kg | Hệ điều hành: Window 11 bản quyền', 14990000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/9740_9317_7440_dell.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Asus ExpertBook P3605CVA-PL0042W (Core i5 13420H, 16GB, 512GB, 16 WQXGA 144Hz)', 'like-new-asus-expertbook-p3605cva-pl0042w-core-i5-13420h-16gb-512gb-16-wqxga-144hz-154', N'CPU: Intel® Core™ i5-13420H 2,1 GHz (Bộ nhớ đệm 12MB, lên tới 4,6 GHz, 8 nhân, 12 luồng) | Ram: 16GB (1x16GB) DDR5 5600MHz SO-DIMM (2 slots, up max to 64GB) | Ổ cứng: 512GB M.2 2280 NVMe™ PCIe® 4.0 SSD (Còn trống 1 khe M.2 2230 PCIe 4.0×4) | GPU: Intel UHD Graphics | Màn hình: 16 inch 2K (2560 x 1600,WQXGA) 16:10, Góc nhìn rộng, Màn hình chống chói, Đèn nền LED, 400 nit , sRGB: 100% | Webcam: 1080p FHD Camera | Cổng kết nối: 2x USB 3.2 Gen 1 Type-A 2x USB 3.2 Gen 2 Type-C with display/power delivery support 1x RJ45 Gigabit Ethernet 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack 1x FingerPrint | Trọng lượng: 1.75 kg | Pin: 3-Cell 63WHrs | Hệ điều hành: Windows 11 bản quyền', 16790000, 4, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Asus-ExpertBook-P3605CVA-PL0042W-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo IdeaPad Slim 3 2025 (Xiaoxin 14c AHP10) (03CD) (Ryzen 7-8745HS, 16GB, 512GB, AMD 780M, 14 FHD+)', 'like-new-lenovo-ideapad-slim-3-2025-xiaoxin-14c-ahp10-03cd-ryzen-7-8745hs-16gb-512gb-amd-780m-14-fhd-155', N'CPU: AMD Ryzen™ 7 8745HS (3.8 GHz up to 5.1 GHz, 8 Cores, 16 Threads, 16MB Cache) | RAM: 16GB LPDDR5X 5600MHz  (onboard 8GB + 1 thanh 8GB ) | Ổ cứng: 512GB M.2 NVMe PCIe SSD | GPU: AMD Radeon Graphic 780M | Màn hình: 14 inches FHD+ (1920×1200) IPS, 60Hz, 16:10, 300 nits | Webcam: HD 720p with Privacy Shutter | Cổng kết nối: 1 x cổng USB-C 3.2 Gen 2 1 x HDMI 1 x Jack tai nghe 3.5mm 1 x khe đọc ghi thẻ MicroSD 2 x cổng USB-A 3.2 Gen 1 | Pin: 50 Wh | Trọng lượng: ~1,46 kg | Hệ điều hành: Window 11 bản quyền', 13990000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3598_lenovo_xiaoxin_14c_ahp10_1-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Latitude 7440 (Core i7-1355U, 32GB, 256GB, 14 icnh 2k)', 'like-new-dell-latitude-7440-core-i7-1355u-32gb-256gb-14-icnh-2k-156', N'CPU: Intel Core i7-1355U 10C-12T, E-core: 1.2GHz upto 3.7GHz, P-core: 1.7GHz upto 5.0GHz, 12MB Cache | RAM: 32GB DDR5 4800 MT/s | Ổ cứng: 256GB SSD PCIe 4.0 | GPU: Intel Iris Xe Graphics | Màn hình: 14.0 inch 2K 60Hz WVA, 250 nits, 45% NTSC, anti-glare | Webcam: 1080p at 30 fps, FHD Camera; HD RGB Ir camera Dual-array microphones | Cổng kết nối: 2 x USB Type-C® Thunderbolt™ 4.0 ports with Power Delivery & DisplayPort 1.4 2 x USB 3.2 Gen 1 Type-A port USB 3.2 Gen 1 Type-A port with PowerShare 1 x headset (headphone and microphone combo) port 1 x HDMI 2.0 port 1 x Fingerprint Reader | Pin: 2-cell, 38 Wh, lithium ion | Trọng lượng: 1.33 kg | Hệ điều hành: Window 11 bản quyền', 17890000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/12/Dell-latitude-7440.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Acer Predator Helios Neo 16 (Core i9-14900HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 240Hz)', 'like-new-acer-predator-helios-neo-16-core-i9-14900hx-16gb-1tb-rtx-4060-8gb-16-2k-240hz-157', N'CPU: Intel Core i9-14900HX (24 Cores/ 32 Threads, up to 5.80 GHz, 36MB | RAM: 16GB DDR5 4800MHz | Ổ cứng: 1TB PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB 140W | Màn hình: 16″ 2K+ IPS, LCD, LED, màn nhám, chống lóa, không cảm ứng, tần số quét màn 240Hz, tỷ lệ khung hình 16:10, độ phủ màu 100%sRGB | Webcam: HD Webcam | Cổng kết nối: 2x USB 3.2 Type-C Gen 2 1x USB 3.2 Type-A Gen 1 2x USB 3.2 Type-A Gen 2 1x microSD™ Card reader 1x HDMI 2.1 1x RJ45 1x Jack 3.5mm 1x Cổng nguồn | Pin: 4-cell, 90 Wh | Trọng lượng: 2.6kg | Hệ điều hành: Window 11 bản quyền', 30890000, 5, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Predator-Helios-Neo-2023-PHN16-71-54W3-400x400-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Like New';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo 15 2025 N166A (Core i5-13420H, 16GB, 512GB, 15.6 FHD)', 'new-100-lenovo-lecoo-15-2025-n166a-core-i5-13420h-16gb-512gb-156-fhd-158', N'CPU: Intel Core i5-13420H (8 nhân 12 luồng, xung nhịp tối đa 4.6GHz, 12MB Cache) | RAM: 16GB LPDDR4x | Ổ cứng: 512GB M.2 SSD | GPU: Intel UHD Graphics | Màn hình: 15.6″ FHD (1920×1080) IPS 300nits Anti-glare | Webcam: HD 720p | Cổng kết nôi: USB-A (USB 5Gbps / USB 3.2 Gen 1) USB-C® (USB 5Gbps / USB 3.2 Gen 1), with USB PD 3.0 and DisplayPort™ 1.2 HDMI® 1.4 Headphone / microphone combo jack (3.5mm) SD card reader | Trọng lượng: 1.65kg | Pin: 50wh | Hệ điều hành: Windows 11 bản quyền', 13790000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/10/2cMSJdn3CI0XmAN4gthvRV83W-6470.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo 14 2025 N155C (Core i5-13420H, 16GB, 1TB, 14 2K+)', 'new-100-lenovo-lecoo-14-2025-n155c-core-i5-13420h-16gb-1tb-14-2k-159', N'CPU: Intel Core i5-13420H (8 nhân 12 luồng, xung nhịp tối đa 4.6GHz, 12MB Cache) | RAM: 16GB LPDDR5 | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD | GPU: Intel UHD Graphics | Màn hình: 14″ 2.2K (2240×1400), tỷ lệ 16:10, IPS 300nits Anti-glare, 100% sRGB | Webcam: HD 720p | Cổng kết nôi: USB-A (USB 5Gbps / USB 3.2 Gen 1) USB-C® (USB 5Gbps / USB 3.2 Gen 1), with USB PD 3.0 and DisplayPort™ 1.2 HDMI® 1.4 Headphone / microphone combo jack (3.5mm) SD card reader | Trọng lượng: 1.15kg | Pin: 55wh | Hệ điều hành: Windows 11 bản quyền', 19190000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Lecoo-14-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 2025 (Ryzen 7 260, 16GB, 2TB, RTX 5060 8GB, 15.1 2K+ 180Hz)', 'new-100-lenovo-legion-r7000-2025-ryzen-7-260-16gb-2tb-rtx-5060-8gb-151-2k-180hz-160', N'CPU: AMD Ryzen 7 260 (8 nhân 16 luồng, xung nhịp cơ bản 3.8GHz có thể đạt tới 5.1GHz đơn nhân với turbo boost, 8MB L2 Cache, 16MB L3 Cache, default TDP 45W) | RAM: 16GB DDR5 5600MHz (có thể nâng cấp) | Ổ cứng: 2*1TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ 2K+ IPS, 400nits, màn nhám, 180Hz, 3ms, 100%sRGB, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer… | Webcam: HD Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 33590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/u098068VZkw70BlFmlrXtmubH-0873.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 2025 (Ryzen 7 260, 24GB, 512GB, RTX 5060 8GB, 15.3 FHD+ 165Hz)', 'new-100-lenovo-legion-r7000-2025-ryzen-7-260-24gb-512gb-rtx-5060-8gb-153-fhd-165hz-161', N'CPU: AMD Ryzen 7 260 (8 nhân 16 luồng, xung nhịp cơ bản 3.8GHz có thể đạt tới 5.1GHz đơn nhân với turbo boost, 8MB L2 Cache, 16MB L3 Cache, default TDP 45W) | RAM: 24GB DDR5 5600MHz | Ổ cứng: 512GB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ FHD+ IPS, 400nits, màn nhám, 165Hz, 3ms, 100%sRGB, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer… | Webcam: HD Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 31290000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/u098068VZkw70BlFmlrXtmubH-0873.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 2025 (Ryzen 7 260, 16GB, 512GB, RTX 5060 8GB, 15.3 FHD+ 165Hz)', 'new-100-lenovo-legion-r7000-2025-ryzen-7-260-16gb-512gb-rtx-5060-8gb-153-fhd-165hz-162', N'CPU: AMD Ryzen 7 260 (8 nhân 16 luồng, xung nhịp cơ bản 3.8GHz có thể đạt tới 5.1GHz đơn nhân với turbo boost, 8MB L2 Cache, 16MB L3 Cache, default TDP 45W) | RAM: 16GB DDR5 5600MHz (có thể nâng cấp) | Ổ cứng: 512GB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ FHD+ IPS, 400nits, màn nhám, 165Hz, 3ms, 100%sRGB, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer… | Webcam: HD Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 29990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/u098068VZkw70BlFmlrXtmubH-0873.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 2025 (Ryzen 7 H 255, 24GB, 512GB, RTX 5060 8GB, 15.3 FHD+ 165Hz)', 'new-100-lenovo-legion-r7000-2025-ryzen-7-h-255-24gb-512gb-rtx-5060-8gb-153-fhd-165hz-163', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản 3.8GHz có thể đạt tới 4.9GHz đơn nhân với turbo boost, 8MB L2 Cache, 16MB L3 Cache, default TDP 45W) | RAM: 24GB DDR5 5600MHz (có thể nâng cấp) | Ổ cứng: 512GB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ FHD+ IPS, 400nits, màn nhám, 165Hz, 3ms, 100%sRGB, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer… | Webcam: HD Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 31190000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/u098068VZkw70BlFmlrXtmubH-0873.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-72-7G42 (Core i7-14650HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ IPS 240Hz)', 'new-100-acer-shadow-knight-sh16-72-7g42-core-i7-14650hx-16gb-1tb-rtx-4060-8gb-16-2k-ips-240hz-164', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 16 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA®GeForce® RTX™ 4060 8GB DDR6 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 240Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 27690000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-74-7G21 (Core i7-13650HX, 16GB, 1TB, RTX 5050 8GB, 16 2K+ IPS 165Hz)', 'new-100-acer-shadow-knight-sh16-74-7g21-core-i7-13650hx-16gb-1tb-rtx-5050-8gb-16-2k-ips-165hz-165', N'CPU: Intel Core i7-13650HX (2.6GHz up to 4.9GHz,14Cores, 20 Threads, 14MB Cache) | RAM: 16 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA GeForce RTX 5050 8GB GDDR7 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 165Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 27690000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-71-5G61 (Core i5-14450HX, 16GB, 1TB, RTX 4070 8GB, 16 2K+ IPS 165Hz)', 'new-100-acer-shadow-knight-sh16-71-5g61-core-i5-14450hx-16gb-1tb-rtx-4070-8gb-16-2k-ips-165hz-166', N'CPU: Intel Core i5-14450HX (10 nhân 16 luồng, xung nhịp có thể đạt tối đa 4.8GHz với Turbo boost, 20MB Intel® Smart Cache) | RAM: 16 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA®GeForce® RTX™ 4070 8GB DDR6 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 165Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 29290000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro ProPanel ANV15-52-72BM NH.QZ9SV.004 (Core i7-13620H, 16GB, 512GB, RTX 5050 8GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-propanel-anv15-52-72bm-nhqz9sv004-core-i7-13620h-16gb-512gb-rtx-5050-8gb-156-fhd-ips-180hz-167', N'CPU: Intel® Core™ i7-13620H (2.40GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB DDR4 3200Mhz (2 khe rời – nâng cấp tối đa 64GB) | Ổ cứng: 512GB PCIe NVMe SSD (nâng cấp tối đa 2TB) | GPU: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, Acer ComfyView | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port, supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • DisplayPort over USB-C via iGPU • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 WUSB Standard A 3 x USB Standard-A ports, supporting: • 1x port for USB 3.2 Gen 1 featuring power off USB charging • 2x ports for USB 3.2 Gen 11 x HDMI® 2.1 port with HDCP support1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone1 x Ethernet (RJ-45) port1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 76WHrs | Hệ điều hành: Windows 11 Home bản quyền', 32590000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23119_29629_laptop_acer_gaming_nitro_v_15_propanel_anv15_52_72bm_nh_qz9sv_004.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Precision 7680 (Core i7-13850HX, 32GB, 512GB, RTX 2000 8GB, 16 FHD+)', 'new-100-dell-precision-7680-core-i7-13850hx-32gb-512gb-rtx-2000-8gb-16-fhd-168', N'CPU: Intel® Core™ i7-13850HX (30MB Cache, 28 Threads, 20 Cores (8P+12E) up to 5.3GHz, 55w, vPro) | RAM: 32GB, 5600MT/s CAMM, non-ECC | Ổ cứng: 512GB M.2 PCIe NVMe Gen 4 2280 SSD | GPU: NVIDIA® RTX™ A2000, 8GB GDDR6 | Màn hình: 16″ FHD+ 1920×1200 WLED, WVA, 60Hz, anti-glare, non-touch, 100% DCI-P3, 500 nits, IR Camera with Mic | Webcam: HD Camera | Cổng kết nối: 2x ThunderBolt™ 4 3x USB 3.2 1x HDMI 2.1 1x RJ45 1x Headset 1x SD-card slot | Pin: 83 Wh, 6 Cell, Lithium Ion Polymer | Trọng lượng: 2.6 kg | Hệ điều hành: Window 11 bản quyền', 42200000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3201.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like new] Dell Precision 7780 (Core i7-13850HX, 32GB, 512GB, RTX 3500 12GB, 17 FHD+)', 'like-new-dell-precision-7780-core-i7-13850hx-32gb-512gb-rtx-3500-12gb-17-fhd-169', N'CPU: Intel Core i7 13850HX (20 Cores 28Theards, Turbo Boots 5.3 Ghz, Cache 30MB ) | RAM: 32GB DDR5 bus 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe Gen 4 2280 SSD | GPU: Nvidia RTX A3500 Ada 12GB GDDR6 | Màn hình: 17.3″ FHD (1920*1080), 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Webcam: 1080p at 30 fps FHD, RGB camera with Omni-directional digital Microphone | Cổng kết nối: 2 x ThunderBolt™ 4 ports with (USB Type-C™) 1 x USB 3.2 Gen 2 Type-C port with DisplayPort alt mode 1 x USB 3.2 Gen 1 port with PowerShare 1 x USB 3.2 Gen 1 port 1 x HDMI 2.0a port (UMA)/1 HDMI 2.1 port (DGPU) 1 x RJ45 Ethernet port 1 x headset (headphone and microphone combo) port 1 x Nano MicroSD-card slot | Pin: 93 Wh Lithium-Ion | Trọng lượng: 3.05 kg | Hệ điều hành: Window 11 bản quyền', 46790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/08/dell-precision-7780-mobile-workstation-chuyen-nghiep_1927.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Gaming G15 5530 (Core i5-13450HX, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 165Hz)', 'new-100-dell-gaming-g15-5530-core-i5-13450hx-16gb-512gb-rtx-4050-6gb-156-fhd-165hz-170', N'CPU: 13th Gen Intel® Core™ i5-13450HX (20 MB cache, 10 cores, 16 threads, up to 4.60 GHz Turbo) | RAM: 16GB DDR5 4800Mhz | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 15″ FHD (16:9), 165Hz, 300 nits, 68% sRGB | Webcam: HD Webcam | Cổng kết nối: 3x SuperSpeed USB 3.2 Gen 1 Type-A 1x USB-C 3.2 Gen 2 with Display Port Alt-Mode 1x HDMI 2.1 1x Headphone/Mic 1x RJ45 | Trọng lượng: 2.65 kg | Pin: 3 Cells, 86Wh | Hệ điều hành: Windows bản quyền', 22690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/06/56144_laptop_dell_gaming_g15_5530_71045030_8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Alienware 16X Aurora 2025 (Core Ultra 9 275HX, 32GB, 1TB, RTX 5070 8GB, 16 2K+ 240Hz)', 'new-100-alienware-16x-aurora-2025-core-ultra-9-275hx-32gb-1tb-rtx-5070-8gb-16-2k-240hz-171', N'CPU: Intel® Core™ Ultra 9 Processor 275HX (36MB cache, 24 cores, 2.1 to 5.4 GHz P-Core) | RAM: 32GB, 2x16GB, DDR5, 5600 MT/s | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA® GeForce RTX™ 5070, 8 GB GDDR7 | Màn hình: 16″ 2K+ 240Hz, 100% DCI-P3, ComfortView Plus, G-SYNC | Webcam: 1080p at 30 fps, FHD RGB-IR HDR camera, Dual-array microphones | Cổng kết nối: 2 USB 3.2 Gen 1 (5 Gbps) ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with Power Delivery 1 Thunderbolt™ 4 (40 Gbps) port with DisplayPort™ 2.1 1 HDMI 2.1 port with Discrete Graphics Controller Direct Output 1 universal audio jack (RCA, 3.5 mm) 1 RJ45 ethernet port (1 Gbps) 1 power-adapter port | Trọng lượng: 2.5 kg | Pin: 94 Wh Lithium-Ion | Hệ điều hành: Windows 11 bản quyền', 65390000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/Alienware-16X-Aurora-2025-H1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Thinkbook 16P G5 (Core i7-14650HX, 16GB, 1TB, RTX 4060 8GB, 16 3K+ 165Hz)', 'new-100-lenovo-thinkbook-16p-g5-core-i7-14650hx-16gb-1tb-rtx-4060-8gb-16-3k-165hz-172', N'CPU: Intel Core i7 14650HX (16 nhân 24 luồng, xung nhịp có thể đạt tối đa 5.2GHz với Turbo boost, 30MB Intel® Smart Cache) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD | Card VGA: NVIDIA® GeForce RTX™ 4060 8GB GDDR6 | Màn hình: 16″ 3.2K (3200×2000), Non Touch, IPS, 430nits, Antiglare, 16:10, 100% DCIP3, 165Hz | Camera: 1080P FHD RGB/IR Hybrid with Dual Microphone | Kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1x USB-A (USB 10Gbps / USB 3.2 Gen 2), Always On 2x USB-C® (Thunderbolt™ 4 / USB4® 40Gbps), with USB PD 3.0 and DisplayPort™ 1.4 1x HDMI® 2.1, up to 8K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x SD card reader 1x Power connector | Trọng lượng: 2.2 kg | Pin: 4Cell 81WHr | Hệ điều hành: Windows 11 bản quyền', 29490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3390_thinkbook_16p_00.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ 2024 15IAX9 83GS001SVN (Core i5-12450HX, 16GB, 512GB, RTX 2050 , 15.6 FHD 144Hz)', 'new-100-lenovo-loq-2024-15iax9-83gs001svn-core-i5-12450hx-16gb-512gb-rtx-2050-156-fhd-144hz-173', N'CPU: Intel® Core™ i5-12450HX (2.00GHz up to 4.40GHz, 12MB Cache) | RAM: 12GB DDR5 4800MHz (up to 32GB) | Ổ cứng: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA® GeForce RTX™ 2050 4GB GDDR6 | Màn hình: 15.6inch FHD (1920×1080) IPS 300nits Anti-glare, 100%sRGB, 144Hz | Cổng kết nôi: 1 x USB 3.2 Gen 1 2 x USB 3.2 Gen 2 1 x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1 x HDMI®, up to 8K/60Hz 1 x Ethernet (RJ-45) 1 x Headphone / microphone combo jack (3.5mm) 1 x Power connector | Trọng lượng: ~2.4 kg | Pin: 4-Cell, 60Wh | Hệ điều hành: Windows 11 bản quyền', 17390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/loq-2024-_1734921958-copy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Gaming G15 5530 (Core i7-13650HX, 16GB, 1TB, RTX 4060 8GB, 15.6 FHD 165Hz)', 'new-100-dell-gaming-g15-5530-core-i7-13650hx-16gb-1tb-rtx-4060-8gb-156-fhd-165hz-174', N'CPU: 14th Generation Intel® Core i7-14700HX, 20C (8P + 8E) / 28T, P-core up to 5.5GHz, E-core up to 3.9GHz, 33MB Cache | RAM: 16GB DDR5 4800Mhz | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 | Màn hình: 15″ FHD (16:9), 165Hz, 300 nits, 68% sRGB | Webcam: HD Webcam | Cổng kết nối: 3x SuperSpeed USB 3.2 Gen 1 Type-A 1x USB-C 3.2 Gen 2 with Display Port Alt-Mode 1x HDMI 2.1 1x Headphone/Mic 1x RJ45 | Trọng lượng: 2.65 kg | Pin: 3 Cells, 86Wh | Hệ điều hành: Windows bản quyền', 26690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/06/56144_laptop_dell_gaming_g15_5530_71045030_8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000P 2024 (Core i7-14650HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 165Hz)', 'new-100-lenovo-legion-y7000p-2024-core-i7-14650hx-16gb-1tb-rtx-4060-8gb-16-2k-165hz-175', N'CPU: 14th Generation Intel® Core™ i7-14650HX, 16C (8P + 8E) / 24T, P-core up to 5.2GHz, E-core up to 3.7GHz, 30MB Cache | RAM: 16 GB DDR5 | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 28390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3174_3147_khuuf49zxptmtaygwzuivedgz_7317.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ 2024 15IAX9 (Core i5-12450HX, 12GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-2024-15iax9-core-i5-12450hx-12gb-512gb-rtx-3050-6gb-156-fhd-144hz-176', N'CPU: Intel® Core™ i5-12450HX (2.00GHz up to 4.40GHz, 12MB Cache) | RAM: 12GB DDR5 4800MHz (up to 32GB) | Ổ cứng: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Màn hình: 15.6inch FHD (1920×1080) IPS 300nits Anti-glare, 100%sRGB, 144Hz | Cổng kết nôi: 1 x USB 3.2 Gen 1 2 x USB 3.2 Gen 2 1 x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1 x HDMI®, up to 8K/60Hz 1 x Ethernet (RJ-45) 1 x Headphone / microphone combo jack (3.5mm) 1 x Power connector | Trọng lượng: ~2.4 kg | Pin: 4-Cell, 60Wh | Hệ điều hành: Windows 11 bản quyền', 18090000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/loq-2024-_1734921958-copy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 2024 15AHP9 (Ryzen 7-8745H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-legion-r7000-2024-15ahp9-ryzen-7-8745h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-177', N'CPU: Ryzen 7-8745H (8 nhân 16 luồng, tần số cơ bản 3.8GHz, có thể đạt tới 4.9GHz với turbo boost, bộ nhớ đệm 8MB L2 / 16MB L3, 4nm, TDP 35-54W) | RAM: 16 GB DDR5 5600MHz | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4050 6GB GDDR6 | Màn hình: 15.6″ (1920×1080) IPS, 300nits, 100% sRGB, 144Hz | Webcam: HD Webcam | Cổng kết nối: 1 x E-camera shutter 1 x SD card 2 x USB-A 3.2 Gen 2 1 x RJ45 (mạng LAN) 1 x HDMI 2.1 1 x power input 2 x USB-C 3.2 gen 2 | Trọng lượng: 2.4 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 29090000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/3416_3355_3126_3004_c3zzbg9e5memiezohvjlvty9e_3819.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000 2024 (Core i7-13650HX, 24GB, 512GB, RTX 4060 8GB, 15.6 FHD 144Hz)', 'new-100-lenovo-legion-y7000-2024-core-i7-13650hx-24gb-512gb-rtx-4060-8gb-156-fhd-144hz-178', N'CPU: 13th Generation Intel® Core i7-13650HX, 20C (6P + 8E) xung nhịp turbo đơn nhân tối đa 4,9GHz | RAM: 24 GB DDR5 (2x 12GB) | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 15.6″ FHD (1920×1080) IPS, non-touch, 300nits, 144Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 1x E-camera shutter 1x SD card 2x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.3 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 27990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/07/3302_3126_3004_c3zzbg9e5memiezohvjlvty9e_3819.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 3561 (Core i7-11800H, 16GB, 512GB, RTX T1200 4GB, 15.6 FHD+)', 'like-new-dell-precision-3561-core-i7-11800h-16gb-512gb-rtx-t1200-4gb-156-fhd-179', N'CPU: Intel Core i7-11800H 14C-20T, E-core: 1.7GHz upto 3.5GHz, P-core: 2.3GHz upto 4.7GHz, 24MB Cache | RAM: 16GB DDR5 4800MHz | Hard Drive: SSD 512 GB | GPU: Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA Quadro T600 4GB GDDR6 Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA RTX T1200 4GB GDDR6 | Display: 15.6 inch FHD 1920×1080 60Hz WVA, 250 nits, 45% NTSC, anti-glare | Ports: 2xUSB-A 3.2 Gen 1, 2xUSB-C 4 (Thunderbolt 4, Power Delivery, DisplayPort), 1xHDMI 2.0, MicroSD Card Reader, RJ-45 Flipdown, 3.5mm combo jack | DVD Drive: No | Battery: 64 Wh | OS: Windows 11 Pro 64 Bit | Dimensions: 35.7 x 23.3 x 2.4 (cm) | Weight: 1.79 kg', 14290000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Dell-pre-3571-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 3561 (Core i7-11800H, 16GB, 256GB, RTX T1200 4GB, 15.6 FHD+)', 'like-new-dell-precision-3561-core-i7-11800h-16gb-256gb-rtx-t1200-4gb-156-fhd-180', N'CPU: Intel Core i7-11800H 14C-20T, E-core: 1.7GHz upto 3.5GHz, P-core: 2.3GHz upto 4.7GHz, 24MB Cache | RAM: 16GB DDR5 4800MHz | Hard Drive: SSD 256GB | GPU: Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA Quadro T600 4GB GDDR6 Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA RTX T1200 4GB GDDR6 | Display: 15.6 inch FHD 1920×1080 60Hz WVA, 250 nits, 45% NTSC, anti-glare | Ports: 2xUSB-A 3.2 Gen 1, 2xUSB-C 4 (Thunderbolt 4, Power Delivery, DisplayPort), 1xHDMI 2.0, MicroSD Card Reader, RJ-45 Flipdown, 3.5mm combo jack | DVD Drive: No | Battery: 64 Wh | OS: Windows 11 Pro 64 Bit | Dimensions: 35.7 x 23.3 x 2.4 (cm) | Weight: 1.79 kg', 13290000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Dell-pre-3571-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 3561 (Core i5-11500H, 16GB, 256GB, RTX T600 4GB, 15.6 FHD+)', 'like-new-dell-precision-3561-core-i5-11500h-16gb-256gb-rtx-t600-4gb-156-fhd-181', N'CPU: Intel Core i5-11500H 14C-20T, E-core: 1.7GHz upto 3.5GHz, P-core: 2.3GHz upto 4.7GHz, 24MB Cache | RAM: 16GB DDR5 4800MHz | Hard Drive: SSD 256GB | GPU: Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA Quadro T600 4GB GDDR6 Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA RTX A1000 4GB GDDR6 | Display: 15.6 inch FHD 1920×1080 60Hz WVA, 250 nits, 45% NTSC, anti-glare | Ports: 2xUSB-A 3.2 Gen 1, 2xUSB-C 4 (Thunderbolt 4, Power Delivery, DisplayPort), 1xHDMI 2.0, MicroSD Card Reader, RJ-45 Flipdown, 3.5mm combo jack | DVD Drive: No | Battery: 64 Wh | OS: Windows 11 Pro 64 Bit | Dimensions: 35.7 x 23.3 x 2.4 (cm) | Weight: 1.79 kg', 11290000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Dell-pre-3571-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7760 (Core i7-11850H, 16GB, 512GB, Nvidia T1200 4GB, 17.3 FHD IPS)', 'like-new-dell-precision-7760-core-i7-11850h-16gb-512gb-nvidia-t1200-4gb-173-fhd-ips-182', N'CPU: Intel® Core™ Processor i7-11850H (8 Core, 24M Cache, 2.5GHz up to 4.8 GHz Turbo, 45W, vPro) | RAM: 16GB DDR4 3200 MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX T1200 4GB GDDR6 | Màn hình: 17.3 inch FHD 1920*1080 tấm nền IPS 100% SRGB | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x USB 3.2 Gen 1 with Powershare 2x USB 3.2 Gen 2 Thunderbolt™ 3.0 Type C | Pin: 97 Wh | Trọng lượng: 3.0 kg | Hệ điều hành: Window bản quyền', 17790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7760-thong-so-ryb.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 3571 (Core i5-12500H, 16GB, 256GB, RTX T600 4GB, 15.6 FHD+)', 'like-new-dell-precision-3571-core-i5-12500h-16gb-256gb-rtx-t600-4gb-156-fhd-183', N'CPU: Intel Core i7-12700H 14C-20T, E-core: 1.7GHz upto 3.5GHz, P-core: 2.3GHz upto 4.7GHz, 24MB Cache | RAM: 16GB DDR5 4800MHz | Hard Drive: SSD 256GB | GPU: Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA Quadro T600 4GB GDDR6 Intel UHD Graphics Gen 12 (single-channel RAM) / Intel Iris Xe Graphics (dual-channel RAM) + NVIDIA RTX A1000 4GB GDDR6 | Display: 15.6 inch FHD 1920×1080 60Hz WVA, 250 nits, 45% NTSC, anti-glare | Ports: 2xUSB-A 3.2 Gen 1, 2xUSB-C 4 (Thunderbolt 4, Power Delivery, DisplayPort), 1xHDMI 2.0, MicroSD Card Reader, RJ-45 Flipdown, 3.5mm combo jack | DVD Drive: No | Battery: 64 Wh | OS: Windows 11 Pro 64 Bit | Dimensions: 35.7 x 23.3 x 2.4 (cm) | Weight: 1.79 kg', 13790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Dell-pre-3571-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad P15 Gen 2 (Core i7-11850H, 16GB, 512GB, T1200, 15.6 4K)', 'like-new-lenovo-thinkpad-p15-gen-2-core-i7-11850h-16gb-512gb-t1200-156-4k-184', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.30GHz to 4.60GHz, 45W, vPro) | RAM: 16GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro T1200 4GB GDDR6 | Màn hình: 15.6″ 4K, 3940×2160 , 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 20690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/06/thinkpad-p15v-gen-2-2tmobile.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5550 (Xeon W-10855M, 16GB, 512GB, Nvidia Quadro T1000, 15.6 FHD)', 'like-new-dell-precision-5550-xeon-w-10855m-16gb-512gb-nvidia-quadro-t1000-156-fhd-185', N'CPU: Xeon W-10855M (6 Core, 12MB Cache, 2.80 GHz to 5.10 GHz, 45W) | RAM: 16 GB, DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB PCIe NVMe Class 35 Solid State Drive512GB PCIe NVMe Class 35 Solid State Drive | Card VGA: NVIDIA Quadro T1000 4GB GDDR6 (50W) | Màn hình: 15.6″ FHD ,AG,NT, w/Prem Panel Guar, 100% sRGB | Cổng kết nối: 3x USB Type C 3.2 Gen 2 1x jack tai nghe 3.5mm 1x khe thẻ nhớ SD | Trọng lượng: 1.8 kg | Pin: 97 Wh | Hệ điều hành: Windows 10', 16390000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/dell-precision-5550-core-i7-10th-t1000-156-inch-model-2020-P7472-1706236729528.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad X1 Carbon Gen 11 (Core i7-1370P, 32GB, 512GB, 14 FHD+ Touch)', 'like-new-lenovo-thinkpad-x1-carbon-gen-11-core-i7-1370p-32gb-512gb-14-fhd-touch-186', N'CPU: 13th Generation Intel® Core™ i7-1360P™ (E-Core Max 2.10 GHz, P-Core Max 4.70 GHz with Turbo Boost, 12 Cores, 16 Threads, 18 MB Cache) | RAM: 32 GB LPDDR5 5200MHz (Soldered) | Ổ cứng: 512GB PCIe SSD Gen 4 Performance | GPU: Integrated Intel® Iris® Xe Graphics | Màn hình: 14.0″ WUXGA (1920 x 1200) IPS, anti-glare, low power, 400 nits | Webcam: 1080p FHD | Cổng kết nối: 2 x USB Type C 2 x USB Type A 1 x HDMI 1 x Jack tai nghe 3.5mm | Pin: 57WHr Li-Polymer | Trọng lượng: 1.12kg | Hệ điều hành: Window 11 bản quyền', 27690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/11/01-X1-Carbon-G11-Hero-Front-Facing-x1qh-.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 4 (Core i7-11850H, 16GB, 512GB, VGA A2000, 16 2.5K)', 'like-new-lenovo-thinkpad-p1-gen-4-core-i7-11850h-16gb-512gb-vga-a2000-16-25k-187', N'CPU: 11th Generation Intel® Core™ i7-11850H Processor (2.40 GHz, up to 4.70 GHz with Turbo Boost, 8 Cores, 16 Threads, 24 MB Cache) | RAM: 16GB DDR4 3200MHz | Ổ cứng: 512GB M2-PCIe Gen 3 | GPU: NVIDIA® Quadro A2000 4GB | Màn hình: 16.0″ WQUXGA (2560 x 1600 ) IPS, anti-glare with Dolby Vision™, HDR 400, 600 nits | Webcam: 1080p IR | Cổng kết nối: 2 x USB-A 3.2 Gen 1 (1 powered) 2 x USB-C Thunderbolt™ 4 (Power Delivery, Display Port, Data Transfer) 1 x SD 4-in-1 card reader 1 x Headphone / mic combo 1 x HDMI 2.1 | Pin: 4 Cell 90Wh | Trọng lượng: 1.7 kg | Hệ điều hành: Window 11 bản quyền', 21890000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Workstation-thinkpad-p1-gen3-01-1600063054.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7750 (Core i9 10850H, 16GB, 512GB, RTX 4000 8GB, 17.3 FHD IPS)', 'like-new-dell-precision-7750-core-i9-10850h-16gb-512gb-rtx-4000-8gb-173-fhd-ips-188', N'CPU: Intel® Core™ Processor i7-10885H (8 Core, 16M Cache, 2.4GHz up to 5.3GHz Turbo, 45W, vPro) | RAM: 16 GB DDR4 2933 MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX 4000 w/ 8GB GDDR6 | Màn hình: 17.3 inch FHD 1920*1080 tấm nền IPS 100% SRGB | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x USB 3.2 Gen 1 with Powershare 2x USB 3.2 Gen 2 Thunderbolt™ 3.0 Type C | Pin: 97 Wh | Trọng lượng: 3.01 kg | Hệ điều hành: Window bản quyền', 21690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precison-7750-8.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 5 (Core i9 12900H, 16GB, 512GB, RTX A2000, 16 4K Touch)', 'like-new-lenovo-thinkpad-p1-gen-5-core-i9-12900h-16gb-512gb-rtx-a2000-16-4k-touch-189', N'CPU Tùy chọn: Intel 12th Gen Core i9-12900H (14 Core, 20 Thread, 8-E-core 3.GHz, 6-P-core 4.8GHz, 24MB Cache) | Dung lượng tùy chọn: 16 GB | Loại: DDR5, 4800 MHz, DuoChannel | Loại ổ cứng:: SSD PCIe NVME | Dung lượng tùy chọn: 512TB | Kích thước/ độ phân giải tùy chọn: 16.0″ 4K (3840 x 2400) IPS, anti-glare, 500 nits | Chipset đồ họa: NVIDIA RTX A2000 8GB | Kết nối mạng: Intel Wi-Fi® 6E AX211, 802.11ax 2×2 Wi-Fi + | Bluetooth: Bluetooth®5.1 | Cổng Kết Nối: 2 x USB 3.2 Gen 1 (one Always On) 2 x Thunderbolt 4 / USB4® 40Gbps (support data transfer, Power Delivery 3.0 and DisplayPortTM 1.4) 1 x HDMI, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Power connector 1 x SD Express 7.0 card reader | Thời lượng: 90 Wh Lithium-Ion | Kích thước: Width: 359.5 mm Depth: 253.8 mm Height: 17.7 mm | Trọng lượng: 1.81 kg | Win: 11 bản quyền | Xuất xứ: US', 30590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/11/P1-gen-4-5.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i9-11950H, 16GB, 512GB, RTX A2000, 15.6 FHD)', 'like-new-dell-precision-7560-core-i9-11950h-16gb-512gb-rtx-a2000-156-fhd-190', N'CPU: Intel Core Processor i9-11950H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® RTX A2000 4 GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 21090000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5540 (Core i9 9880H, 16GB, 512GB, 15.6 4K TOUCH, NVIDIA Quadro T2000)', 'like-new-dell-precision-5540-core-i9-9880h-16gb-512gb-156-4k-touch-nvidia-quadro-t2000-191', N'CPU: Intel® Core™ i9-9880H (2.3GHz, Turbo up to 4.8GHz, Cache 16 MB, 8 core 16 luồng) | RAM: 16GB DDR4 | Ổ cứng: SSD 512 GB | Card VGA: NVIDIA Quadro T2000 4GB | Màn hình: 15.6 inch 4K (3840x 2160) Touch | Cổng kết nối: 2x USB 3.0 1x SD Card reader 1x USB 3.1 Gen 2 Type-C Ie) 1x HDMI 2.0 1x Jack 3.5mm | Trọng lượng: 1.8 Kg | Pin: 4 Cell, 97Wh | Hệ điều hành: Windows 10', 15790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/hg-Dell-Precision-5540.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell XPS 15 9520 (Core i9-12900HK, 16GB, 1TB, RTX 3050Ti 4GB, 15.6 FHD+)', 'like-new-dell-xps-15-9520-core-i9-12900hk-16gb-1tb-rtx-3050ti-4gb-156-fhd-192', N'CPU: Intel Core i9-12900HK Processor vPro Up To 4.7GHz(14 Cores, 20 Threads, 24MB Cache) | RAM: 16GB DDR5 4800MHz | Ổ cứng: 1TB PCIe M.2 SSD | GPU: NVIDIA® GeForce RTX™ 3050 Ti 4GB GDDR6 | Màn hình: 15.6″ FHD+ (1920*1200) 60Hz, Non-Touch, Anti-Glare, 500 nit, InfinityEdge | Webcam: 720P | Cổng kết nối: 2 x Thunderbolt 4 1 x USB-C 3.2 1 x microSD card 1x jack audio | Pin: 86WHr Li-Polymer | Trọng lượng: 1.92 kg | Hệ điều hành: Window 11 bản quyền', 25690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2026/03/1-10-1-510x453-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7550 (Core i9-10885H, 16GB, 512GB, RTX3000, 15.6 FHD)', 'like-new-dell-precision-7550-core-i9-10885h-16gb-512gb-rtx3000-156-fhd-193', N'CPU: 10th Generation Intel® Core™ i9-10885H, 16 MB Cache, 8 Cores, 2.40 GHz to 5.30 GHz, 45 W, vPro | RAM: 16GB DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | Card VGA: NVIDIA Quadro RTX3000  8GB | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 100% DCIP3, 500 Nits | Trọng lượng: 2.59 Kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 18790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/dell-precision-7550-156-win-10-pro-1598590151-1601869917.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Xeon W-11855M, 16GB, 512GB, RTX A2000, 15.6 FHD)', 'like-new-dell-precision-7560-xeon-w-11855m-16gb-512gb-rtx-a2000-156-fhd-194', N'CPU: Intel Xeon W-11855M (8 nhân 16 luồng, 24MB Cache, 2.60GHz to 5.00GHz, 45W) | RAM: 16GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro RTX A3000 6GB GDDR6 | Màn hình: 15.6″ 4K+, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 18790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 5 (Core i7 12800H, 16GB, 512GB, VGA A2000, 16 2.5K)', 'like-new-lenovo-thinkpad-p1-gen-5-core-i7-12800h-16gb-512gb-vga-a2000-16-25k-195', N'CPU Tùy chọn: Intel 12th Gen Core i7-128600H (14 Core, 20 Thread, 8-E-core 3.GHz, 6-P-core 4.8GHz, 24MB Cache) | Dung lượng tùy chọn: 16GB | Loại: DDR5, 4800 MHz, DuoChannel | Loại ổ cứng:: SSD PCIe NVME | Dung lượng tùy chọn: 512TB | Kích thước/ độ phân giải tùy chọn: 16.0″ WQXGA (2560 x 1600) IPS, anti-glare, 400 nits | Chipset đồ họa: NVIDIA RTX A2000 4GB GDDR6 | Kết nối mạng: Intel Wi-Fi® 6E AX211, 802.11ax 2×2 Wi-Fi + | Bluetooth: Bluetooth®5.1 | Cổng Kết Nối: 2 x USB 3.2 Gen 1 (one Always On) 2 x Thunderbolt 4 / USB4® 40Gbps (support data transfer, Power Delivery 3.0 and DisplayPortTM 1.4) 1 x HDMI, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Power connector 1 x SD Express 7.0 card reader | Thời lượng: 90 Wh Lithium-Ion | Kích thước: Width: 359.5 mm Depth: 253.8 mm Height: 17.7 mm | Trọng lượng: 1.81 kg | Win: 11 bản quyền | Xuất xứ: US', 28590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/11/P1-gen-4-5.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7670 (Core i9-12950HX, 32GB, 512GB, RTX A4500 12GB, 16 FHD IPS)', 'like-new-dell-precision-7670-core-i9-12950hx-32gb-512gb-rtx-a4500-12gb-16-fhd-ips-196', N'CPU: 12th Thế hệ Intel Core i9-12950HX, vPro (16 nhân 24 luồng, 30M Cache, up to 5.0 GHz Turbo, 55W, vPro) | RAM: 32GB DDR5 | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A4500 16GB GDDR6 | Màn hình: 16-inch, FHD 1920 x 1080, 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x Thunderbolt 4 (USB Type-C) 1x USB 3.2 Gen 2 Type-C với chế độ alt DisplayPort 1x USB 3.2 Gen 1 với PowerShare 1x USB 3.2 Gen 1 | Pin: 6cell 83Wh | Trọng lượng: 2.6 kg | Hệ điều hành: Window bản quyền', 39590000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7670-thinkpro-001.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7670 (Core i7-12850HX, 32GB, 1TB, RTX A3000 12GB, 16 FHD IPS)', 'like-new-dell-precision-7670-core-i7-12850hx-32gb-1tb-rtx-a3000-12gb-16-fhd-ips-197', N'CPU: 12th Thế hệ Intel Core i7-12850HX, vPro (16 nhân 24 luồng, 25M Cache, 3.4GHz up to 4.8 GHz Turbo, 55W, vPro) | RAM: 32GB DDR5 | Ổ cứng: 1TB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A3000 12GB GDDR6 | Màn hình: 16-inch, FHD 1920 x 1080, 60 Hz, Anti-Glare, Non-Touch, 99% DCIP3, 500 Nits | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x Thunderbolt 4 (USB Type-C) 1x USB 3.2 Gen 2 Type-C với chế độ alt DisplayPort 1x USB 3.2 Gen 1 với PowerShare 1x USB 3.2 Gen 1 | Pin: 6cell 83Wh | Trọng lượng: 2.6 kg | Hệ điều hành: Window bản quyền', 32590000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7670-thinkpro-001.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7540 (Core i9-9850H, 16GB, 512GB, T2000, 15.6 FHD)', 'like-new-dell-precision-7540-core-i9-9850h-16gb-512gb-t2000-156-fhd-198', N'CPU: Intel®  Core i9 9850H | RAM: 16GB DDR4 Bus 2666MHz | Ổ cứng: SSD 512GB | Card VGA: Intel HD Quadro T2000 | Màn hình: 15.6 Inch FHD IPS | Cổng kết nối: VGA, USB 3.0 và 2.0, LAN, Display Port | Trọng lượng: 2.79 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 13990000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Dell_precision_15_7540_1-300x300-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7540 (Xeon E2276M, 16GB, 512GB, T2000, 15.6 FHD)', 'like-new-dell-precision-7540-xeon-e2276m-16gb-512gb-t2000-156-fhd-199', N'CPU: Intel®  Xeon 2276M | RAM: 16GB DDR4 Bus 2666MHz | Ổ cứng: SSD 512GB | Card VGA: Intel HD Quadro T2000 | Màn hình: 15.6 Inch FHD IPS | Cổng kết nối: VGA, USB 3.0 và 2.0, LAN, Display Port | Trọng lượng: 2.79 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 12790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Dell_precision_15_7540_1-300x300-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i7-11850H, 16GB, 512GB, RTX 3080 16GB, 15.6 FHD)', 'like-new-dell-precision-7560-core-i7-11850h-16gb-512gb-rtx-3080-16gb-156-fhd-200', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® RTX 3080 16 GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 26290000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Xeon W-11855M, 16GB, 512GB, T1200, 15.6 FHD)', 'like-new-dell-precision-7560-xeon-w-11855m-16gb-512gb-t1200-156-fhd-201', N'CPU: Intel Xeon W-11855M (12 Core, 24MB Cache, 2.60GHz to 4.90GHz, 45W, ) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro T1200 4GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 16790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i9-11950H, 16GB, 512GB, RTX 3080 16GB, 15.6 FHD)', 'like-new-dell-precision-7560-core-i9-11950h-16gb-512gb-rtx-3080-16gb-156-fhd-202', N'CPU: Intel Core Processor i9-11950H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® RTX 3080 16 GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 27790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i7-11850H, 16GB, 512GB, RTX A5000, 15.6 FHD)', 'like-new-dell-precision-7560-core-i7-11850h-16gb-512gb-rtx-a5000-156-fhd-203', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro RTX 5000 16 GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 27690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i7-11850H, 16GB, 512GB, RTX A4000, 15.6 FHD)', 'like-new-dell-precision-7560-core-i7-11850h-16gb-512gb-rtx-a4000-156-fhd-204', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro RTX A4000 8GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 23390000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i7-11850H, 16GB, 512GB, RTX A3000, 15.6 FHD)', 'like-new-dell-precision-7560-core-i7-11850h-16gb-512gb-rtx-a3000-156-fhd-205', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro RTX A3000 6GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 21090000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i7-11850H, 16GB, 512GB, RTX A2000, 15.6 FHD)', 'like-new-dell-precision-7560-core-i7-11850h-16gb-512gb-rtx-a2000-156-fhd-206', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.40GHz to 4.70GHz, 45W, vPro) | RAM: 16 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro RTX A200 4GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 18700000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P15 Gen 1 (Core i7-10750H, 16GB, 256GB, T1000, 15.6 4K)', 'like-new-lenovo-thinkpad-p15-gen-1-core-i7-10750h-16gb-256gb-t1000-156-4k-207', N'CPU: Intel Core Processor i7-10750H (6 Core, 12MB Cache, 2.70 GHz to 5.10 GHz, 45W, vPro) | RAM: 16GB DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | Card VGA: NVIDIA Quadro T1000 w/4GB GDDR6 | Màn hình: 15.6″ 4K, 3840x 2160, 60Hz, Anti-Glare, Non-Touch, 100% DCIP3, 500 Nits | Trọng lượng: 2.59 Kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 14590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/06/thinkpad-p15v-gen-2-2tmobile.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo ThinkPad X9-14 Gen 1 21QA006KVN (Ultra 7 258V, 32GB, 1TB, Intel Arc Graphics 140V, 14 FHD+ OLED)', 'new-100-lenovo-thinkpad-x9-14-gen-1-21qa006kvn-ultra-7-258v-32gb-1tb-intel-arc-graphics-140v-14-fhd-oled-208', N'CPU: Intel® Core™ Ultra 7 258V (2.20GHz up to 4.80GHz, 12MB Cache) | RAM: 32GB Soldered LPDDR5x-8533MHz | Ổ cứng: 1TB SSD M.2 2242 PCIe® 4.0×4 NVMe® Opal 2.0 | GPU: Intel® Arc™ Graphics 140V | Màn hình: 14.0inch WUXGA (1920×1200) OLED 400nits Anti-glare, 100% DCI-P3, 60Hz, DisplayHDR™ True Black 500, Dolby Vision® | Cổng kết nôi: 2 x USB-C® (Thunderbolt™ 4 / USB4® 40Gbps), with USB PD 3.0 and DisplayPort™ 2.1 1 x HDMI® 2.1, up to 4K/60Hz 1 x Headphone / microphone combo jack (3.5mm) | Trọng lượng: 1.21 kg | Pin: 3Cell 55Wh | Hệ điều hành: Windows 11 bản quyền', 49690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/02/Lenovo-ThinkPad-X9-14-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5570 (Core i9-12900H, 16GB, 512GB, RTX A2000 8GB, 15.6 4K UHD Touch)', 'like-new-dell-precision-5570-core-i9-12900h-16gb-512gb-rtx-a2000-8gb-156-4k-uhd-touch-209', N'CPU (Bộ vi xử lý): Intel Core i9 12900H, 14 nhân (6 P-core, 8 E-core) 20 luồng, có thể đạt xung nhịp tối đa tới 5.0GHz với turbo boost, bộ nhớ đệm 24 MB Intel® Smart Cache | Ram (Bộ nhớ trong): Từ 32GB DDR5 4800MHz, có thể nâng cấp tối đa 64GB | Storage (Ổ cứng): từ 512GB PCIe® NVMe™ M.2 SSD, có 2 khe lắp ổ cứng M.2 | Màn hình: 15.6″ Ultrasharp WLED UHD+ (3840*2400) HDR400, màn gương chống lóa, có cảm ứng, độ sáng 500nits, tần số quét 60Hz, độ phủ màu 100% AdobeRGB, 94% DCI-P3; mật độ điểm ảnh 290PPI, tỷ lệ tương phản 1600:1, tốc độ phản hồi 60ms,.. | Card đồ họa: Intel® Iris® Xe + NVIDIA Quadro RTX A2000 8GB GDDR6 | Hệ điều hành: Win 10/ Win 11 | Bàn phím: Rút gọn, có led phím | Fingerprint reader: Có hỗ trợ | Pin: 6-cell, 86whr | Camera: HD RGB IR Camera and cùng 2 mic thu tầm xa | Âm thanh: hệ loa kép (2 loa trầm+2 loa bổng), âm lượng cực to và êm | Cổng kết nối vật lý: Xem trong bài viết | Kết nối không dây: Wi-Fi + Bluetooth 5.2 | Kích thước máy: 34.4cm x 23cm x 0.77-1.16cm | Trọng lượng: 2.1kg | Màu sắc: Titan Gray | Chất liệu: Kim loại | Tình trạng sản phẩm: Like New | Năm sản xuất: 2022 | Hãng sản xuất: Dell | Loại hàng: Nhập khẩu | Tấm nền màn hình: IPS | Xuất xứ: USA', 25690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/12/7824_5570__01_.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5560 (Core i9 11950H, 16 GB, 512 GB , VGA A2000, 15.6 4K Touch)', 'like-new-dell-precision-5560-core-i9-11950h-16-gb-512-gb-vga-a2000-156-4k-touch-210', N'CPU: Intel Core Processor i9-11950H (8 Core, 24MB Cache, 2.60 GHz to 5.0 GHz, 45W) | RAM: 16 GB, 2×16 GB, DDR4, 3200 MHz | Ổ cứng: M.2 2280, 512 GB, Gen 3 PCIe x4 NVMe, SSD | Card VGA: NVIDIA RTX A2000w/4GB GDDR6 | Màn hình: 15.6-inch, UHD+ 3840 x 2400 InfinityEdge, 60 Hz, anti-glare, low blue light, non-touch, 500 nits, sRGB 100% min, wide-viewing angle | Cổng kết nối: Type-C 1 Jack 3.5 mm 1 Thunderbolt 1 khe cắm thẻ nhớ SD | Trọng lượng: 1.84 kg | Pin: 86 Whr | Hệ điều hành: Windows 11 bản quyền', 21490000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/xw2ydt30-1858-dell-precision-5560-core-i7-11800h-ram-32gb-ssd-1tb-rtx-t1200-fhd.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5550 (Core i9 10885H, 16GB, 512GB, 15.6 4K Touch, Nvidia Quadro T2000)', 'like-new-dell-precision-5550-core-i9-10885h-16gb-512gb-156-4k-touch-nvidia-quadro-t2000-211', N'CPU: Intel Core Processor i9-10885H (8 Core, 16MB Cache, 2.40 GHz to 5.30 GHz, 45W) | RAM: 16 GB, DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB PCIe NVMe Class 35 Solid State Drive512GB PCIe NVMe Class 35 Solid State Drive | Card VGA: NVIDIA Quadro T2000 4GB GDDR6 (50W) | Màn hình: 15.6″ UltraSharp 4K UHD+, 3840×2400,AG,NT, w/Prem Panel Guar, 100% sRGB | Cổng kết nối: 3x USB Type C 3.2 Gen 2 1x jack tai nghe 3.5mm 1x khe thẻ nhớ SD | Trọng lượng: 1.8 kg | Pin: 97 Wh | Hệ điều hành: Windows 10', 17390000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/dell-precision-5550-core-i7-10th-t1000-156-inch-model-2020-P7472-1706236729528.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7760 (Core i9-11950H, 32GB, 512GB, RTX A5000 16GB, 17.3 4K IPS)', 'like-new-dell-precision-7760-core-i9-11950h-32gb-512gb-rtx-a5000-16gb-173-4k-ips-212', N'CPU: Intel® Core™ Processor i9-11950H (8 Core, 24M Cache, 2.6GHz up to 5.0 GHz Turbo, 45W, vPro) | RAM: 32GB DDR4 3200 MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A5000 16GB GDDR6 | Màn hình: 17.3 inch 4K tấm nền IPS 100% SRGB | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x USB 3.2 Gen 1 with Powershare 2x USB 3.2 Gen 2 Thunderbolt™ 3.0 Type C | Pin: 97 Wh | Trọng lượng: 3.0 kg | Hệ điều hành: Window bản quyền', 33990000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7760-may-tram-boy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad T14 Gen 5 (Core Ultra 7 155U, 16GB, 512GB, 14 FHD+)', 'like-new-lenovo-thinkpad-t14-gen-5-core-ultra-7-155u-16gb-512gb-14-fhd-213', N'CPU: Intel Core Ultra 7 155U vPro Up To 4.8GHz (12 Cores, 14 Threads, 12MB Cache) | RAM: 16GB DDR5 5600MHz (Upto Max 64GB) | Ổ cứng: 512GB PCIe Gen4 M.2 SSD | GPU: Intel® Integrated Graphics (Onboard) | Màn hình: 14″ WUXGA (1920×1200) IPS, Anti-Glare, 45% NTSC, 400nits | Webcam: 5MP RGB & infrared (IR) with webcam privacy shutter | Cổng kết nối: 2 x USB-C® (Thunderbolt™ 4, USB 40Gbps) 2 x USB-A (USB 5Gbps, 1 always on) Ethernet (RJ45) HDMI® 2.1 (supports resolution up to 4K@60Hz) Headphone / mic combo Optional Nano SIM Optional Smart card reader | Trọng lượng: 1.36 kg | Pin: 39.3 Wh Lithium-Ion | Hệ điều hành: Window 11 bản quyền', 24290000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/03/t14g5__3__ef5t-u8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7760 (Xeon W-11955M, 16GB, 512GB, RTX A4000 8GB, 17.3 FHD IPS)', 'like-new-dell-precision-7760-xeon-w-11955m-16gb-512gb-rtx-a4000-8gb-173-fhd-ips-214', N'CPU: Intel® Core™ Xeon W-11955M vPro (2.60GHz to 5.00GHz, 8-Cores, 16 Threads, 24MB Cache) | RAM: 16GB DDR4 3200 MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A4000 8GB GDDR6 | Màn hình: 17.3 inch FHD 1920*1080 tấm nền IPS 100% SRGB | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x USB 3.2 Gen 1 with Powershare 2x USB 3.2 Gen 2 Thunderbolt™ 3.0 Type C | Pin: 97 Wh | Trọng lượng: 3.0 kg | Hệ điều hành: Window bản quyền', 25190000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7760-may-tram-boy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7550 (Core i9-10885H, 16GB, 512GB, RTX5000, 15.6 FHD)', 'like-new-dell-precision-7550-core-i9-10885h-16gb-512gb-rtx5000-156-fhd-215', N'CPU: 10th Generation Intel® Core™ i9-10885H, 16 MB Cache, 8 Cores, 2.40 GHz to 5.30 GHz, 45 W, vPro | RAM: 16GB DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | Card VGA: NVIDIA Quadro RTX5000  16GB | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 100% DCIP3, 500 Nits | Trọng lượng: 2.59 Kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 21990000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/dell-precision-7550-man-hinh-nam-anh-laptop.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5560 (Core i7-11850H, 16GB, 512GB , VGA T1200, 4K Touch)', 'like-new-dell-precision-5560-core-i7-11850h-16gb-512gb-vga-t1200-4k-touch-216', N'CPU: Intel Core Processor i7-11850H (8 Core, 24MB Cache, 2.50 GHz to 4.70 GHz, 45W) | RAM: 16 GB, 2×16 GB, DDR4, 3200 MHz | Ổ cứng: M.2 2280, 512 GB, Gen 3 PCIe x4 NVMe, SSD | Card VGA: NVIDIA T1200 w/4GB GDDR6 | Màn hình: 15.6-inch, 4K Touch InfinityEdge, 60 Hz, , low blue light, h, 500 nits, sRGB 100% min, wide-viewing angle | Cổng kết nối: Type-C 1 Jack 3.5 mm 1 Thunderbolt 1 khe cắm thẻ nhớ SD | Trọng lượng: 1.84 kg | Pin: 86 Whr | Hệ điều hành: Windows 11 bản quyền', 18790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/xw2ydt30-1858-dell-precision-5560-core-i7-11800h-ram-32gb-ssd-1tb-rtx-t1200-fhd.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7760 (Core i9-11950H, 32GB, 512GB, RTX A4000 8GB, 17.3 FHD IPS)', 'like-new-dell-precision-7760-core-i9-11950h-32gb-512gb-rtx-a4000-8gb-173-fhd-ips-217', N'CPU: Intel® Core™ Processor i9-11950H (8 Core, 24M Cache, 2.5GHz up to 4.8 GHz Turbo, 45W, vPro) | RAM: 32GB DDR4 3200 MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A4000 8GB GDDR6 | Màn hình: 17.3 inch FHD 1920*1080 tấm nền IPS 100% SRGB | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x USB 3.2 Gen 1 with Powershare 2x USB 3.2 Gen 2 Thunderbolt™ 3.0 Type C | Pin: 97 Wh | Trọng lượng: 3.0 kg | Hệ điều hành: Window bản quyền', 27999000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7760-thong-so-ryb.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell XPS 15 9510 (Core i7-11800H, 16GB, 512GB, RTX 3050Ti, 15.6 4K Touch)', 'like-new-dell-xps-15-9510-core-i7-11800h-16gb-512gb-rtx-3050ti-156-4k-touch-218', N'CPU: Option: 11th Generation Intel® Core™ i7-11800H (8-Core, 24MB Cache, up to 4.6GHz Max Turbo Frequency) Option: 11th Generation Intel® Core™ i9-11900H (8-Core, 24MB Cache, up to 4.9GHz Max Turbo Frequency) | RAM: Option: 16GB DDR4 3200MHz Option: 32GB DDR4 3200MHz | HARD DISK: Option: 512GB PCIe M.2 SSD Option: 1TB PCIe M.2 SSD | VGA: Option: NVIDIA® GeForce RTX™ 3050 4GB GDDR6 Option: NVIDIA® GeForce RTX™ 3050 Ti 4GB GDDR6 | LCD: Option: 15.6″ FHD+ 1920*1200 500 Nits 100% sRGB Option: 15.6″ UHD+ 3840*2400 500 Nits 100% sRGB Touch Option: 15.6″ OLED 3.5K 3456*2160 400 Nits InfinityEdge Touch Anti-Reflective | OS: Windows 10 English | WIFI: Killer™ Wi-Fi 6 AX1650 (2×2) and Bluetooth 5.1 | PORTS: 1 x USB 3.2 Gen 2 Type-C™ with (DisplayPort/PowerDelivery) 1 x 3.5mm headphone/microphone combo jack 2 x Thunderbolt™ 4 (USB Type-C™) with DisplayPort and Power Delivery 1 x Full size SD card reader v6.0 1 x Fingerprint Reader | AUDIO: Stereo woofer 2.5 W x 2 and stereo tweeter 1.5 W x 2 = 8 W total peak FeaturingWaves Nx® 3D audio for speakers tuned by multi-Grammy Award® winning producer, Jack Joseph Puig | BATTERY: 86 Wh Lithium-Ion | CAMERA: 720p at 30 fps HD camera Dual-array microphones | DIMENSION: Height: 0.71″ (18 mm) Width: 13.57″ (344.72 mm) Depth: 9.06″ (230.14 mm) | WEIGHT: For non-touch with 86Whr battery; 4.42 lbs (2.01 kg) For 4K+ touch with 86WHr battery; 4.31 lbs (1.96 kg) | CONDITION: New 100% Fullbox', 22790000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/12/2288_1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo ThinkPad E16 Gen 3 21SR002MVA (Core Ultra 7 255H, 16GB, 1TB, Intel Arc Graphics 140T, 16 FHD+)', 'new-100-lenovo-thinkpad-e16-gen-3-21sr002mva-core-ultra-7-255h-16gb-1tb-intel-arc-graphics-140t-16-fhd-219', N'CPU: Intel® Core™ Ultra 7 255H (2.00GHz up to 5.10GHz, 24MB Cache) | RAM: 16GB (1x16GB) SO-DIMM DDR5 5600MHz (2 slots, up to 64GB) | Ổ cứng: 1TB SSD M.2 2242 PCIe® 4.0×4 NVMe® Opal 2.0 | GPU: Intel® Arc™ Graphics 140T | Màn hình: 16.0inch WUXGA (1920×1200) IPS, 60Hz, 300nits, Anti-glare, 45% NTSC | Cổng kết nôi: 1 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-A (USB 10Gbps / USB 3.2 Gen 2), Always On 1 x USB-C® (USB 20Gbps / USB 3.2 Gen 2×2), with USB PD 3.1 and DisplayPort™ 1.4 1 x USB-C® (Thunderbolt™ 4 / USB4® 40Gbps), with USB PD 3.1 and DisplayPort™ 2.1 1 x HDMI® 2.1, up to 4K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) | Trọng lượng: 1.63 kg | Pin: 3Cell 48Wh | Hệ điều hành: Windows theo máy', 26790000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/lenovo_thinkpad_e16_gen_3_black_01_adbe7e15b4.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P16 Gen 1 (Core i7-12800HX, 32GB, 512GB, RTX A3000 12GB, 16 FHD IPS)', 'like-new-lenovo-thinkpad-p16-gen-1-core-i7-12800hx-32gb-512gb-rtx-a3000-12gb-16-fhd-ips-220', N'CPU: Intel 12th Gen Core i7-12800HX (16 Core, 24 Thread, 8-E-core 3.4GHz, 8-P-core 4.8GHz, 25MB Cache) | RAM: 32GB DDR5 4800MHz | Ổ Cứng: 512GB PCIe NMVe SSD | Màn hình: 16.0″ WUXGA (1920 x 1200) IPS, anti-glare, 300 nits | Card đồ hoạ: NVIDIA® RTX™ RTX A3000 12GB | Pin: 94 Wh Lithium-Ion | Bàn phím: Có LED | Kết nối: 2x Thunderbolt 4 2x USB-A 3.2 Gen 1 USB-C 3.2 Gen 2 HDMI SD Card Jack 3.5mm | Webcam: FHD | Trọng lượng (kg): 2.9 kg | Hệ điều hành: Windows bản quyền | Xuất xứ: Xách tay US | Bảo hành: 06 tháng', 36890000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/02/thegioiso-p16-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P16 Gen 1 (Core i7-12800HX, 32GB, 512GB, RTX A2000 8GB, 16 FHD IPS)', 'like-new-lenovo-thinkpad-p16-gen-1-core-i7-12800hx-32gb-512gb-rtx-a2000-8gb-16-fhd-ips-221', N'CPU: Intel 12th Gen Core i7-12800HX (16 Core, 24 Thread, 8-E-core 3.4GHz, 8-P-core 4.8GHz, 25MB Cache) | RAM: 32GB DDR5 4800MHz | Ổ Cứng: 512GB PCIe NMVe SSD | Màn hình: 16.0″ WUXGA (1920 x 1200) IPS, anti-glare, 300 nits | Card đồ hoạ: NVIDIA® RTX™ RTX A2000 8GB | Pin: 94 Wh Lithium-Ion | Bàn phím: Có LED | Kết nối: 2x Thunderbolt 4 2x USB-A 3.2 Gen 1 USB-C 3.2 Gen 2 HDMI SD Card Jack 3.5mm | Webcam: FHD | Trọng lượng (kg): 2.9 kg | Hệ điều hành: Windows bản quyền | Xuất xứ: Xách tay US | Bảo hành: 06 tháng', 29690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/02/thegioiso-p16-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad P15 Gen 2 (Core i7-11850H, 16GB, 512GB, A2000, 15.6 FHD)', 'like-new-lenovo-thinkpad-p15-gen-2-core-i7-11850h-16gb-512gb-a2000-156-fhd-222', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.30GHz to 4.60GHz, 45W, vPro) | RAM: 16GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro A2000 4GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 21690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/06/thinkpad-p15v-gen-2-2tmobile.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7560 (Core i9-11950H, 32GB, 512GB, RTX A5000 16GB, 15.6 FHD)', 'like-new-dell-precision-7560-core-i9-11950h-32gb-512gb-rtx-a5000-16gb-156-fhd-223', N'CPU: Intel Core Processor i9-11950H (16 Core, 24MB Cache, 2.60GHz to 5.0GHz, 45W, vPro) | RAM: 32 GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro RTX A5000 16GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 31590000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2022/04/DELL-Precision-7560-1.jpeg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V 15 ProPanel ANV15-41-R0Y4 (Ryzen 7-7735HS, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-v-15-propanel-anv15-41-r0y4-ryzen-7-7735hs-16gb-512gb-rtx-4050-6gb-156-fhd-ips-180hz-224', N'CPU: AMD Ryzen™ 7-7735HS (3.20GHz up to 4.75GHz, 16MB Cache) | RAM: 16GB (1x16GB) DDR5 4800MHz (2 slots, up to 64GB) | Ổ cứng: 512GB PCIe NVMe SSD (Up to 4TB PCIe Gen4 NVMe SSD​) | GPU: NVIDIA® GeForce® RTX 4050 6GB GDDR6 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, 300nits, Acer ComfyView™, LED-backlit TFT LCD, Wide viewing angle | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port, supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • DisplayPort over USB-C via iGPU • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 WUSB Standard A 3 x USB Standard-A ports, supporting: • 1x port for USB 3.2 Gen 1 featuring power off USB charging • 2x ports for USB 3.2 Gen 11 x HDMI® 2.1 port with HDCP support1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone1 x Ethernet (RJ-45) port1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 57WHrs | Hệ điều hành: Windows 11 Home bản quyền', 25090000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23366_29622_laptop_acer_gaming_nitro_v_15_propanel_anv15_41_r7cr_nh_qpesv_003.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V 15 ProPanel ANV15-41-R7CR (Ryzen 5-7535HS, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-v-15-propanel-anv15-41-r7cr-ryzen-5-7535hs-16gb-512gb-rtx-4050-6gb-156-fhd-ips-180hz-225', N'CPU: AMD Ryzen™ 5-7535HS (3.30GHz up to 4.55GHz, 16MB Cache) | RAM: 16GB (1x16GB) DDR5 4800MHz (2 slots, up to 64GB) | Ổ cứng: 512GB PCIe NVMe SSD (Up to 4TB PCIe Gen4 NVMe SSD​) | GPU: NVIDIA® GeForce® RTX 4050 6GB GDDR6 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, 300nits, Acer ComfyView™, LED-backlit TFT LCD, Wide viewing angle | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port, supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • DisplayPort over USB-C via iGPU • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 WUSB Standard A 3 x USB Standard-A ports, supporting: • 1x port for USB 3.2 Gen 1 featuring power off USB charging • 2x ports for USB 3.2 Gen 11 x HDMI® 2.1 port with HDCP support1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone1 x Ethernet (RJ-45) port1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 57WHrs | Hệ điều hành: Windows 11 Home bản quyền', 23090000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23366_29622_laptop_acer_gaming_nitro_v_15_propanel_anv15_41_r7cr_nh_qpesv_003.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V 15 ProPanel ANV15-41-R9M1 (Ryzen 5-7535HS, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-v-15-propanel-anv15-41-r9m1-ryzen-5-7535hs-16gb-512gb-rtx-3050-6gb-156-fhd-ips-180hz-226', N'CPU: AMD Ryzen™ 5-7535HS (3.30GHz up to 4.55GHz, 16MB Cache) | RAM: 16GB (1x16GB) DDR5 4800MHz (2 slots, up to 64GB) | Ổ cứng: 512GB PCIe NVMe SSD (Up to 4TB PCIe Gen4 NVMe SSD​) | GPU: NVIDIA® GeForce® RTX 3050 6GB GDDR6 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, 300nits, Acer ComfyView™, LED-backlit TFT LCD, Wide viewing angle | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port, supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • DisplayPort over USB-C via iGPU • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 WUSB Standard A 3 x USB Standard-A ports, supporting: • 1x port for USB 3.2 Gen 1 featuring power off USB charging • 2x ports for USB 3.2 Gen 11 x HDMI® 2.1 port with HDCP support1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone1 x Ethernet (RJ-45) port1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 57WHrs | Hệ điều hành: Windows 11 Home bản quyền', 20290000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23366_29622_laptop_acer_gaming_nitro_v_15_propanel_anv15_41_r7cr_nh_qpesv_003.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V 15 ProPanel ANV15-41-R0FE (Ryzen 7-7735HS, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-v-15-propanel-anv15-41-r0fe-ryzen-7-7735hs-16gb-512gb-rtx-3050-6gb-156-fhd-ips-180hz-227', N'CPU: AMD Ryzen™ 7-7735HS (3.20GHz up to 4.75GHz, 16MB Cache) | RAM: 16GB (1x16GB) DDR5 4800MHz (2 slots, up to 64GB) | Ổ cứng: 512GB PCIe NVMe SSD (Up to 4TB PCIe Gen4 NVMe SSD​) | GPU: NVIDIA® GeForce® RTX 3050 6GB GDDR6 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, 300nits, Acer ComfyView™, LED-backlit TFT LCD, Wide viewing angle | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port, supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • DisplayPort over USB-C via iGPU • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 WUSB Standard A 3 x USB Standard-A ports, supporting: • 1x port for USB 3.2 Gen 1 featuring power off USB charging • 2x ports for USB 3.2 Gen 11 x HDMI® 2.1 port with HDCP support1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone1 x Ethernet (RJ-45) port1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 57WHrs | Hệ điều hành: Windows 11 Home bản quyền', 22690000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23366_29622_laptop_acer_gaming_nitro_v_15_propanel_anv15_41_r7cr_nh_qpesv_003.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V ANV15-51-55CA NH.QN8SV.004 (Core i5-13420H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD IPS 144Hz)', 'new-100-acer-nitro-v-anv15-51-55ca-nhqn8sv004-core-i5-13420h-16gb-512gb-rtx-4050-6gb-156-fhd-ips-144hz-228', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 512GB PCIe NVMe SSD (nâng cấp tối đa 4TB SSD) | GPU: NVIDIA® GeForce RTX™ 4050 6GB GDDR6 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS 144Hz SlimBezel | Cổng kết nôi: 1 x USB Type-C™ port supporting: USB 3.2 Gen 2 (up to 10 Gbps) DisplayPort over USB-C Thunderbolt™ 4 USB charging 5 V; 3 A DC-in port 20 V; 65 W 3 x USB Standard-A ports, supporting: One port for USB 3.2 Gen 1 featuring power off USB charging Two ports for USB 3.2 Gen 1 1 x HDMI® 2.1 port with HDCP support 1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone 1 x Ethernet (RJ-45) port 1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 57Wh | Hệ điều hành: Windows 11 Home bản quyền', 20890000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3396_3340_8809_78997_laptop_acer_nitro_v_anv15_51_58an__nh_qnasv__1_-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 5570 (Core i7-12800H, 16GB, 512GB, RTX A2000 8GB, 15.6 4K)', 'like-new-dell-precision-5570-core-i7-12800h-16gb-512gb-rtx-a2000-8gb-156-4k-229', N'CPU (Bộ vi xử lý): Intel Core i7 12800H, 14 nhân (6 P-core, 8 E-core) 20 luồng, có thể đạt xung nhịp tối đa tới 4.8GHz với turbo boost, bộ nhớ đệm 24 MB Intel® Smart Cache | Ram (Bộ nhớ trong): Từ 16GB DDR5 4800MHz, có thể nâng cấp tối đa 64GB | Storage (Ổ cứng): từ 512GB PCIe® NVMe™ M.2 SSD, có 2 khe lắp ổ cứng M.2 | Màn hình: 15.6″ Ultrasharp 4K HDR400, màn gương chống lóa, có cảm ứng, độ sáng 500nits, tần số quét 60Hz, độ phủ màu 100% AdobeRGB, 94% DCI-P3; mật độ điểm ảnh 290PPI, tỷ lệ tương phản 1600:1, tốc độ phản hồi 60ms,.. | Card đồ họa: Intel® Iris® Xe + NVIDIA Quadro RTX A2000 8GB GDDR6 | Hệ điều hành: Win 10/ Win 11 | Bàn phím: Rút gọn, có led phím | Fingerprint reader: Có hỗ trợ | Pin: 6-cell, 86whr | Camera: HD RGB IR Camera and cùng 2 mic thu tầm xa | Âm thanh: hệ loa kép (2 loa trầm+2 loa bổng), âm lượng cực to và êm | Cổng kết nối vật lý: Một cổng USB 3.2 Gen 2 (Type-C) với Chế độ Alt DisplayPort Hai cổng Thunderbolt 4 (USB4) Type-C với Power Delivery | Kết nối không dây: Wi-Fi + Bluetooth 5.2 | Kích thước máy: 34.4cm x 23cm x 0.77-1.16cm | Trọng lượng: 2.1kg | Màu sắc: Titan Gray | Chất liệu: Kim loại | Tình trạng sản phẩm: Like New | Năm sản xuất: 2022 | Hãng sản xuất: Dell | Loại hàng: Nhập khẩu | Tấm nền màn hình: IPS | Xuất xứ: USA', 24690000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/7824_5570__01_.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Dell Precision 7760 (Xeon W-11855M, 16GB, 512GB, RTX A4000 8GB, 17.3 FHD IPS)', 'like-new-dell-precision-7760-xeon-w-11855m-16gb-512gb-rtx-a4000-8gb-173-fhd-ips-230', N'CPU: Intel® Core™ Processor Xeon W-11855M (8 Core, 24M Cache, 2.5GHz up to 4.8 GHz Turbo, 45W, vPro) | RAM: 16GB DDR4 3200 MHz | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive (M.2 SSD) | GPU: NVIDIA Quadro RTX A4000 8GB GDDR6 | Màn hình: 17.3 inch FHD 1920*1080 tấm nền IPS 100% SRGB | Cổng kết nối: 1x Bluetooth 5.0 1x HDMI 1x SD Card Reader 2x USB 3.2 Gen 1 with Powershare 2x USB 3.2 Gen 2 Thunderbolt™ 3.0 Type C | Pin: 97 Wh | Trọng lượng: 3.0 kg | Hệ điều hành: Window bản quyền', 25490000, 2, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/07/dell-precision-7760-may-tram-boy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V 15 ProPanel ANV15-51-500A (Core i5-13420H, 16GB, 512GB, RTX 2050 4GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-v-15-propanel-anv15-51-500a-core-i5-13420h-16gb-512gb-rtx-2050-4gb-156-fhd-ips-180hz-231', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 16GB DDR5 5200Mhz (2 khe rời – nâng cấp tối đa 96GB) | Ổ cứng: 512GB PCIe NVMe SSD (nâng cấp tối đa 4TB PCIe Gen4 NVMe SSD) | GPU: NVIDIA® GeForce RTX™ 2050 4GB GDDR6 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, Acer ComfyView | Cổng kết nôi: 1 x USB Type-C™ port supporting: USB 3.2 Gen 2 (up to 10 Gbps) – DisplayPort over USB-C – Thunderbolt™ 4 – USB charging 5V;3A – DC-in port 20V;65W 3 x USB Standard A ports, supporting: – 2 x USB 3.2 Gen 1 – 1 x USB 3.2 Gen 2 featuring power off USB charging 1 x HDMI® 2.1 port with HDCP support 1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone | Trọng lượng: ~2.1 kg | Pin: 4 Cell 57Wh | Hệ điều hành: Windows 11 Home bản quyền', 17490000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3543_20069_acer_nitro_v_15_propanel_anv15_51__logo_copy_copy.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro Lite 16 16 NL16-71G-71UJ (Core i7-13620H, 16GB, 512GB, RTX 3050 6GB, 16 FHD+ IPS 165Hz)', 'new-100-acer-nitro-lite-16-16-nl16-71g-71uj-core-i7-13620h-16gb-512gb-rtx-3050-6gb-16-fhd-ips-165hz-232', N'CPU: Intel® Core™ i7-13620H (2.40GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB(8GB Onboard + 8GB rời) DDR5 4800MHz (Nâng cấp lên tối đa 56GB (8GB Onboard + 48GB 1 thanh RAM rời) | Ổ cứng: 512GB PCIe NVMe SSD (Nâng cấp tối đa 2TB) | GPU: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Màn hình: 16″ FHD+ (1920×1200) IPS, 165Hz, 45% NTSC, 300nits, Acer ComfyView™ LED-backlit TFT LCD | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 W USB Standard A 2 x USB Standard-A ports, supporting: • One port for USB 3.2 Gen 1 • One port for USB 3.2 Gen 1 featuring power off USB charging 1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone 1 x HDMI®  2.1 port with HDCP support 1 x Ethernet (RJ-45) port | Trọng lượng: 1.95 kg | Pin: 3Cell 53WHrs | Hệ điều hành: Windows 11 bản quyền', 22990000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3734_acer_gaming_nitro_lite_16_nl16_71g_anh_san_pham_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro Lite 16 NL16-71G-56WQ (Core i5-13420H, 16GB, 512GB, RTX 3050 6GB, 16 FHD+ IPS 165Hz)', 'new-100-acer-nitro-lite-16-nl16-71g-56wq-core-i5-13420h-16gb-512gb-rtx-3050-6gb-16-fhd-ips-165hz-233', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 16GB(8GB Onboard + 8GB rời) DDR5 4800MHz (Nâng cấp lên tối đa 56GB (8GB Onboard + 48GB 1 thanh RAM rời) | Ổ cứng: 512GB PCIe NVMe SSD (Nâng cấp tối đa 2TB) | GPU: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Màn hình: 16″ FHD+ (1920×1200) IPS, 165Hz, 45% NTSC, 300nits, Acer ComfyView™ LED-backlit TFT LCD | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 W USB Standard A 2 x USB Standard-A ports, supporting: • One port for USB 3.2 Gen 1 • One port for USB 3.2 Gen 1 featuring power off USB charging 1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone 1 x HDMI®  2.1 port with HDCP support 1 x Ethernet (RJ-45) port | Trọng lượng: 1.95 kg | Pin: 3Cell 53WHrs | Hệ điều hành: Windows 11 bản quyền', 20990000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3734_acer_gaming_nitro_lite_16_nl16_71g_anh_san_pham_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R9000X (Ryzen 7-7840H, 16GB, 1TB, RTX 4060 8GB, 16 3K+ 165Hz)', 'new-100-lenovo-legion-r9000x-ryzen-7-7840h-16gb-1tb-rtx-4060-8gb-16-3k-165hz-234', N'CPU: AMD Ryzen™ 7 7840H (3.80 GHz, up to 5.10 GHz Max Boost, 8 Cores, 16 Threads, 16 MB Cache) | RAM: 16GB DDR5 5600MHZ(có thể nâng cấp) | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 | Màn hình: 16 inch (3200×2000), 3.2K IPS, 165Hz 3ms, 100% P3, 430 nits, Hỗ trợ G-Sync và FreeSync | Webcam: 1080P Webcam | Cổng kết nối: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1x USB-C (USB 10Gbps / USB 3.2 Gen 2), with PD 140W, with DisplayPort™ 1.4 1x HDMI 2.1 1x SD card 1x Headphone / microphone combo jack (3.5mm) 1x Power connector 1x USB-c (USB 3.2 Gen 2) 1x Thunderbolt 4(USB 3.2 Gen 2), with PD 140W and DisplayPort 1.4 | Trọng lượng: 2.1 kg | Pin: 4cell, 99.9 Wh | Hệ điều hành: Windows 11 bản quyền', 29590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/1-2.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 15AHP9 (Ryzen 7-8745H, 16GB, 512GB, RTX 4060 8GB, 15.6 FHD 144Hz)', 'new-100-lenovo-legion-r7000-15ahp9-ryzen-7-8745h-16gb-512gb-rtx-4060-8gb-156-fhd-144hz-235', N'CPU: Ryzen 7-8745H (8 nhân 16 luồng, tần số cơ bản 3.8GHz, có thể đạt tới 4.9GHz với turbo boost, bộ nhớ đệm 8MB L2 / 16MB L3, 4nm, TDP 35-54W) | RAM: 16 GB DDR5 5600MHz | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 15.6″ (1920×1080) IPS, 300nits, 100% sRGB, 144Hz | Webcam: HD Webcam | Cổng kết nối: 1 x E-camera shutter 1 x SD card 2 x USB-A 3.2 Gen 2 1 x RJ45 (mạng LAN) 1 x HDMI 2.1 1 x power input 2 x USB-C 3.2 gen 2 | Trọng lượng: 2.4 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 28290000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/3416_3355_3126_3004_c3zzbg9e5memiezohvjlvty9e_3819.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000P 2024 (Core i7-14650HX, 16GB, 1TB, RTX 4050 6GB, 16 2K+ 165Hz)', 'new-100-lenovo-legion-y7000p-2024-core-i7-14650hx-16gb-1tb-rtx-4050-6gb-16-2k-165hz-236', N'CPU: 14th Generation Intel® Core™ i7-14650HX, 16C (8P + 8E) / 24T, P-core up to 5.2GHz, E-core up to 3.7GHz, 30MB Cache | RAM: 16 GB DDR5 | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | Card VGA: NVIDIA Geforce RTX 4050 6GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 29290000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3174_3147_khuuf49zxptmtaygwzuivedgz_7317.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 4 (Xeon W 11855M, 16GB, 512GB, VGA A2000, 16 2.5K)', 'like-new-lenovo-thinkpad-p1-gen-4-xeon-w-11855m-16gb-512gb-vga-a2000-16-25k-237', N'CPU: Intel Xeon W 11855M  (2.60 GHz, up to 4.90 GHz with Turbo Boost, 8 Cores, 16 Threads, 24 MB Cache) | RAM: 16GB DDR4 3200MHz | Ổ cứng: 512 GB M2-PCIe Gen 3 | GPU: NVIDIA® Quadro A2000 4GB GDDR6 | Màn hình: 16.0″ WQXGA (2560 x 1600) IPS, anti-glare with Dolby Vision™, HDR 400, 600 nits | Webcam: 1080p IR | Cổng kết nối: 2 x USB-A 3.2 Gen 1 (1 powered) 2 x USB-C Thunderbolt™ 4 (Power Delivery, Display Port, Data Transfer) 1 x SD 4-in-1 card reader 1 x Headphone / mic combo 1 x HDMI 2.1 | Pin: 4 Cell 90Wh | Trọng lượng: 1.7 kg | Hệ điều hành: Window 11 bản quyền', 21190000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/01/p_638728195291529257.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 4 (Core i7-11850H, 16GB, 512GB, VGA T1200 , 16 4K Touch)', 'like-new-lenovo-thinkpad-p1-gen-4-core-i7-11850h-16gb-512gb-vga-t1200-16-4k-touch-238', N'CPU: 11th Generation Intel® Core™ i7-11850H Processor (2.40 GHz, up to 4.70 GHz with Turbo Boost, 8 Cores, 16 Threads, 24 MB Cache) | RAM: 32GB DDR4 3200MHz | Ổ cứng: 512 GB M2-PCIe Gen 3 | GPU: NVIDIA® Quadro T1200 4GB GDDR6 | Màn hình: 16.0″ WQUXGA (3840 x 2400) IPS, anti-glare with Dolby Vision™, HDR 400, 600 nits | Webcam: 1080p IR | Cổng kết nối: 2 x USB-A 3.2 Gen 1 (1 powered) 2 x USB-C Thunderbolt™ 4 (Power Delivery, Display Port, Data Transfer) 1 x SD 4-in-1 card reader 1 x Headphone / mic combo 1 x HDMI 2.1 | Pin: 4 Cell 90Wh | Trọng lượng: 1.7 kg | Hệ điều hành: Window 11 bản quyền', 19700000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/01/p_638728195291529257.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 4 (Core i7-11850H, 16GB, 512GB, VGA T1200 , 16 2.5K)', 'like-new-lenovo-thinkpad-p1-gen-4-core-i7-11850h-16gb-512gb-vga-t1200-16-25k-239', N'CPU: 11th Generation Intel® Core™ i7-11850H Processor (2.40 GHz, up to 4.70 GHz with Turbo Boost, 8 Cores, 16 Threads, 24 MB Cache) | RAM: 16GB DDR4 3200MHz | Ổ cứng: 512 GB M2-PCIe Gen 3 | GPU: NVIDIA® Quadro T1200 4GB GDDR6 | Màn hình: 16.0″ WQUXGA (3840 x 2400) IPS, anti-glare with Dolby Vision™, HDR 400, 600 nits | Webcam: 1080p IR | Cổng kết nối: 2 x USB-A 3.2 Gen 1 (1 powered) 2 x USB-C Thunderbolt™ 4 (Power Delivery, Display Port, Data Transfer) 1 x SD 4-in-1 card reader 1 x Headphone / mic combo 1 x HDMI 2.1 | Pin: 4 Cell 90Wh | Trọng lượng: 1.7 kg | Hệ điều hành: Window 11 bản quyền', 19590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/01/p_638728195291529257.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad X1 Extreme Gen 4 (Core i7-11850H, 16GB, 512GB, RTX 3050Ti 4GB, 16.0 4K)', 'like-new-lenovo-thinkpad-x1-extreme-gen-4-core-i7-11850h-16gb-512gb-rtx-3050ti-4gb-160-4k-240', N'CPU: Intel Core i7-11850H 8C-16T, 2.5GHz upto 4.8GHz, 24MB Cache | RAM: 16GB DDR4 3200MHz | Ổ cứng: 512GB SSD NVMe PCIe | GPU: NVIDIA® GeForce RTX™ 3050Ti 4GB | Màn hình: 16.0 inch UHD+ 3840×2400 IPS, 600 nits, 100% aRGB, anti-glare, Low blue light, Dolby Vision, DisplayHDR 400 | Webcam: HD Camera | Cổng kết nối: 2xUSB-A 3.2 Gen 1 2xUSB-C 4 (Thunderbolt 4, Power Delivery 3.0, DisplayPort 1.4) 1xHDMI 2.1 SD Card Reader 3.5mm combo jack | Pin: 4cell 90Wh | Trọng lượng: 1.81 kg | Hệ điều hành: Window 11 bản quyền', 19790000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/06/lenovo-thinkpad-x1-extreme-gen-4-intel.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad P15 Gen 2 (Core i7-11850H, 16GB, 512GB, T1200, 15.6 FHD)', 'like-new-lenovo-thinkpad-p15-gen-2-core-i7-11850h-16gb-512gb-t1200-156-fhd-241', N'CPU: Intel Core Processor i7-11850H (16 Core, 24MB Cache, 2.30GHz to 4.60GHz, 45W, vPro) | RAM: 16GB DDR4 Bus 3200MHz | Ổ cứng: 512GB PCIe x4 NVMe, Solid State Drive | Card VGA: NVIDIA® Quadro T1200 4GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 300 Nits, IR Cam/Mic, WLAN | Trọng lượng: 2.45 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 19790000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/06/thinkpad-p15v-gen-2-2tmobile.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 5 (Core i7 12800H, 32GB, 512GB, VGA RTX A4500, 16 2.5K)', 'like-new-lenovo-thinkpad-p1-gen-5-core-i7-12800h-32gb-512gb-vga-rtx-a4500-16-25k-242', N'CPU Tùy chọn: Intel 12th Gen Core i7-12800H (14 Core, 20 Thread, 8-E-core 3.5GHz, 6-P-core 4.7GHz, 24MB Cache) | Dung lượng tùy chọn: 32GB | Loại: DDR5, 4800 MHz, DuoChannel | Loại ổ cứng:: SSD PCIe NVME | Dung lượng tùy chọn: 512TB | Kích thước/ độ phân giải tùy chọn: 16.0″ WQXGA (2560 x 1600) IPS, anti-glare, 400 nits | Chipset đồ họa: NVIDIA RTX A4500 16GB GDDR6 | Kết nối mạng: Intel Wi-Fi® 6E AX211, 802.11ax 2×2 Wi-Fi + | Bluetooth: Bluetooth®5.1 | Cổng Kết Nối: 2 x USB 3.2 Gen 1 (one Always On) 2 x Thunderbolt 4 / USB4® 40Gbps (support data transfer, Power Delivery 3.0 and DisplayPortTM 1.4) 1 x HDMI, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Power connector 1 x SD Express 7.0 card reader | Thời lượng: 90 Wh Lithium-Ion | Kích thước: Width: 359.5 mm Depth: 253.8 mm Height: 17.7 mm | Trọng lượng: 1.81 kg | Win: 11 bản quyền | Xuất xứ: US', 34590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2024/01/P1-gen-4-5.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad T15 Gen 2 (Core i7-1185G7, 16GB, 256GB, 15.6 FHD)', 'like-new-lenovo-thinkpad-t15-gen-2-core-i7-1185g7-16gb-256gb-156-fhd-243', N'CPU: Intel Core i7-1165G7 4C-8T, 2.8GHz upto 4.7GHz, 12MB Cache | RAM: 16GB DDR4 3200MHz | Ổ cứng: 256GB NVMe M.2 SSD | GPU: Intel Iris Xe Graphics | Màn hình: 15.6 inch FHD 1920×1080 IPS, 300 nits, 45% NTSC, anti-glare | Webcam: HD camera | Cổng kết nôi: 2xUSB-A 3.2 Gen 1 2xUSB-C 4 (Thunderbolt 4, Power Delivery 3.0, DisplayPort 1.4a) 1xHDMI 2.0 MicroSD Card Reader RJ-45 (optional) 3.5mm combo jack | Trọng lượng: 1.8 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 10990000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/10/lenovo-thinkpad-t15-gen2-i5-1135g7-ram-8gb-ssd-256gb-iris-xe-graphics-15-inch-fhd-P7848-1682588917719.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P15 Gen 1 (Core i7-10750H, 16GB, 512GB, RTX 3000 6GB, 15.6 FHD)', 'like-new-lenovo-thinkpad-p15-gen-1-core-i7-10750h-16gb-512gb-rtx-3000-6gb-156-fhd-244', N'CPU: Intel Core Processor i7-10750H (6 Core, 12MB Cache, 2.70 GHz to 5.10 GHz, 45W, vPro) | RAM: 16GB DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | Card VGA: NVIDIA Quadro RTX 3000 w/6GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 100% DCIP3, 500 Nits | Trọng lượng: 2.59 Kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 17990000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2021/04/Lenovo-Thinkpad-P15v-Laptop3mien.vn-4.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P15 Gen 1 (Core i7-10750H, 16GB, 256GB, T2000, 15.6 FHD)', 'like-new-lenovo-thinkpad-p15-gen-1-core-i7-10750h-16gb-256gb-t2000-156-fhd-245', N'CPU: Intel Core Processor i7-10750H (6 Core, 12MB Cache, 2.70 GHz to 5.10 GHz, 45W, vPro) | RAM: 16GB DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB M.2 PCIe NVMe Solid State Drive | Card VGA: NVIDIA Quadro T2000 w/4GB GDDR6 | Màn hình: 15.6″ FHD, 1920×1080, 60Hz, Anti-Glare, Non-Touch, 100% DCIP3, 500 Nits | Trọng lượng: 2.59 Kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 15590000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2021/04/Lenovo-Thinkpad-P15v-Laptop3mien.vn-4.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 3 (Core i7-10875H, 16GB, 512GB, T1000 4GB, 15.6 4K Touch)', 'like-new-lenovo-thinkpad-p1-gen-3-core-i7-10875h-16gb-512gb-t1000-4gb-156-4k-touch-246', N'CPU: Intel Core Processor i7-10850H (6 Core, 12MB Cache, 2.70 GHz to 5.10 GHz, 45W) | RAM: 16GB, DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB PCIe NVMe Class 35 Solid State Drive512GB PCIe NVMe Class 35 Solid State Drive | Card VGA: NVIDIA Quadro T1000 4GB GDDR6 (50W) | Màn hình: 15.6″ UltraSharp UHD+, 3840* 2400 Touch ,AG,NT, w/Prem Panel Guar, 100% sRGB | Cổng kết nối: 2x USB Type C 3.2 Gen 2 2 x USB 3.0 1x jack tai nghe 3.5mm 1x khe thẻ nhớ SD | Trọng lượng: 1.7 kg | Pin: 97 Wh | Hệ điều hành: Windows 10', 16290000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Workstation-thinkpad-p1-gen3-01-1600063054.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad P51 (Core i7-7820HQ, 16 GB, 512GB, Quadro M2200M,15.6 FHD)', 'like-new-lenovo-thinkpad-p51-core-i7-7820hq-16-gb-512gb-quadro-m2200m156-fhd-247', N'CPU: Intel® Core i7-7820HQ | RAM: 16GB DDR4 Bus 2400MHz | Ổ cứng: SSD 512GB | Card VGA: NVIDIA Quadro M2200M 4GB | Màn hình: 15.6 Inch FHD | Trọng lượng: 2.6 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 bản quyền', 9750000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/6_df2c2a63cc9a49d28abeeeead1543df8_large-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad P50 (Xeon 1505, 16 GB, 512GB, Quadro M2000M, 15.6 FHD)', 'like-new-lenovo-thinkpad-p50-xeon-1505-16-gb-512gb-quadro-m2000m-156-fhd-248', N'CPU: Xeon E3 1505 | RAM: 16 GB DDR4 | Ổ cứng: SSD 512 GB M2 | Card VGA: NVIDIA Quadro M2000M 4GB | Màn hình: 15.6 inch Full HD + IPS | Kết Nối: Wifi N, HDMI, Card reader, USB 3.0, Bluetooth, Keyboard Backlit, Thunderbolt 3, USB-C, Finger | Webcam: HD camera | Trọng lượng: 2.67 kg | Pin: 6 Cells | Hệ điều hành: Windows 10 Home bản quyền', 8750000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Thinkpad-P50.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo Thinkpad P1 Gen 3 (Core i7-10875H, 16GB, 512GB, T1000 4GB, 15.6 FHD)', 'like-new-lenovo-thinkpad-p1-gen-3-core-i7-10875h-16gb-512gb-t1000-4gb-156-fhd-249', N'CPU: Intel Core Processor i7-10850H (6 Core, 12MB Cache, 2.70 GHz to 5.10 GHz, 45W) | RAM: 16GB, DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 512GB PCIe NVMe Class 35 Solid State Drive512GB PCIe NVMe Class 35 Solid State Drive | GPU: NVIDIA Quadro T1000 4GB GDDR6 (50W) | Màn hình: 15.6″ UltraSharp FHD+, 1920×1200,AG,NT, w/Prem Panel Guar, 100% sRGB | Cổng kết nối: 2x USB Type C 3.2 Gen 2 2 x USB 3.0 1x jack tai nghe 3.5mm 1x khe thẻ nhớ SD | Trọng lượng: 1.7 kg | Pin: 97 Wh | Hệ điều hành: Windows bản quyền', 15290000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Workstation-thinkpad-p1-gen3-01-1600063054.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 3 (Core i9-10885H, 32GB, 1TB, T2000 4GB, 15.6 4K Touch)', 'like-new-lenovo-thinkpad-p1-gen-3-core-i9-10885h-32gb-1tb-t2000-4gb-156-4k-touch-250', N'CPU: Intel Core Processor i9-10885H (8 Core, 16MB Cache, 2.40 GHz to 5.30 GHz, 45W) | RAM: 32 GB, DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 1TB PCIe NVMe Class 35 Solid State Drive512GB PCIe NVMe Class 35 Solid State Drive | Card VGA: NVIDIA Quadro T2000 4GB GDDR6 (50W) | Màn hình: 15.6″ UltraSharp UHD+, 3840*2400,AG,NT, w/Prem Panel Guar, 100% sRGB | Cổng kết nối: 2x USB Type C 3.2 Gen 2 2 x USB 3.0 1x jack tai nghe 3.5mm 1x khe thẻ nhớ SD | Trọng lượng: 1.7 kg | Pin: 97 Wh | Hệ điều hành: Windows bản quyền', 19690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Workstation-thinkpad-p1-gen3-01-1600063054.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Like New] Lenovo ThinkPad P1 Gen 3 (Core i9-10885H, 32GB, 1TB, T2000 4GB, 15.6 FHD)', 'like-new-lenovo-thinkpad-p1-gen-3-core-i9-10885h-32gb-1tb-t2000-4gb-156-fhd-251', N'CPU: Intel Core Processor i9-10885H (8 Core, 16MB Cache, 2.40 GHz to 5.30 GHz, 45W) | RAM: 32 GB, DDR4 2933Mhz Non-ECC Memory | Ổ cứng: 1TB PCIe NVMe Class 35 Solid State Drive512GB PCIe NVMe Class 35 Solid State Drive | GPU: NVIDIA Quadro T2000 4GB GDDR6 (50W) | Màn hình: 15.6″ UltraSharp FHD+, 1920×1200,AG,NT, w/Prem Panel Guar, 100% sRGB | Cổng kết nối: 2x USB Type C 3.2 Gen 2 2 x USB 3.0 1x jack tai nghe 3.5mm 1x khe thẻ nhớ SD | Trọng lượng: 1.7 kg | Pin: 97 Wh | Hệ điều hành: Windows 10', 18690000, 6, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2025/04/Workstation-thinkpad-p1-gen3-01-1600063054.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[Mới 99%] Laptop Workstation HP Zbook 15 G6 – Intel Core i7', 'moi-99-laptop-workstation-hp-zbook-15-g6-intel-core-i7-252', N'Bộ vi xử lý: Intel Core i7-9850H 2.60 GHz up to 4.60 GHz, 12MB | Bộ nhớ Ram: 16GB | Ổ đĩa cứng: SSD 512GB | Màn hình: 15.6″FHD | Đồ họa: Nvidia Quadro T1000M | Khe cắm mở rộng: 1 smart card reader; 1 SD media card reader | Cổng giao tiếp: 2 x USB Type C , 3 x USB 3.1 | Pin (Battery): 4 cell | Kích thước: 37.6 x 26.4 x 2.6 cm | Khối lượng: 2,6 Kg', 13790000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2023/03/HP-Zbook-15-G6-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'Laptop cũ HP Zbook 15 G2 Máy trạm chuyên đồ họa', 'laptop-cu-hp-zbook-15-g2-may-tram-chuyen-o-hoa-253', N'Chipset: Mobile Intel® QM87 Express | CPU: Intel Core i7-4810MQ 2.8 Ghz 6MB cache4 nhân 8 luồng(up to 3.8 Ghz) | GPU: Intel HD Graphic 4600 & nVIDIA Quadro K1100M 2GB DDR5 (opption K2100M thêm 1 triệu sẵn hàng) | Memory: 8 GB PC3 bus 1600 (có thể nâng cấp lên 32 GB) | HDD: 500 GB | Màn hình: 15.6 inch Anti Glare Full HD Anti-glare  (1920×1080) + Tùy chọn màn tấm nền IPS có góc nhìn đa chiều, sáng đẹp. Thêm 500k | Độ phân giải: 1920*1080 full HD | Wireless: Intel® Dual Band Wireless-AC 7260 802.11ac/a/b/g/n 2×2 Half Mini Card …. | LAN: 10/100/1000 Mbps | Battery: 8 Cells | OS: Windows® 7 Ultimate 64 bit | Ổ quang: Ổ DVD-RW đọc ghi đĩa | Cân nặng: 2.9 Kg | Màu sắc: Đen Xám | Các cổng kết nối: 2x USB 2.0 (1 cổng sạc ngay cả khi tắt nguồn) 2x USB 3.0 Displayport eSata Smartcard External Card Docking 3.5 External Microphone 3.5 External Speaker', 12200000, 3, @MainCategoryId, N'Like New', 'https://thegioiso365.vn/wp-content/uploads/2021/05/HP-Zbook-15-G2.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Đồ họa - Kĩ thuật';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000 2025 (Ryzen 7 H 255, 16GB, 512GB, RTX 5060 8GB, 15.3 2K+ 180Hz)', 'new-100-lenovo-legion-r7000-2025-ryzen-7-h-255-16gb-512gb-rtx-5060-8gb-153-2k-180hz-254', N'CPU: AMD Ryzen 7 H 255 (8 nhân 16 luồng, xung nhịp cơ bản 3.8GHz có thể đạt tới 4.9GHz đơn nhân với turbo boost, 8MB L2 Cache, 16MB L3 Cache, default TDP 45W) | RAM: 16GB DDR5 5600MHz (có thể nâng cấp) | Ổ cứng: 512GB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ WQXGA (2560×1600) IPS, 400nits, màn nhám, 180Hz, 3ms, 100%sRGB, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer… | Webcam: HD Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 34690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/u098068VZkw70BlFmlrXtmubH-0873.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000 2025 (Core i7-14650HX, 16GB, 512GB, RTX 5060 8GB, 15.3 2K+ 180Hz)', 'new-100-lenovo-legion-y7000-2025-core-i7-14650hx-16gb-512gb-rtx-5060-8gb-153-2k-180hz-255', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 16GB DDR5 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ 2K+ (2560×1600) IPS, non-touch, 400nits, 180Hz, | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 36090000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3715_brcvhww7eofpn561dte0uyi6n_0720.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y9000P 2025 (Ultra 9 275 HX, 32GB, 2TB, RTX 5060 8GB, 16 2K+ OLED 240Hz)', 'new-100-lenovo-legion-y9000p-2025-ultra-9-275-hx-32gb-2tb-rtx-5060-8gb-16-2k-oled-240hz-256', N'CPU: Intel Core Ultra 9 275HX (24 nhân 24 luồng, xung nhịp cơ bản từ 2.1GHz có thể đạt max với turbo boost lên tới 5.4GHz, 36MB Cache) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 2*1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0″ WQXGA (2560×1600) OLED 0.08ms, 500nits, 240Hz, 100% DCI-P3, độ sáng tối đa có thể đạt 1100nits, Dolby Vision, HDR 1000, Free-Sync, G-Sync, DC dimmer, TÜV Rheinland | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-Cell, 80Wh | Hệ điều hành: Windows 11 bản quyền', 45590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3737_vb7czzgqeq41pzmu0ss0jotda_5078.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Cyborg 15 AI A1VEK-245VN (Core Ultra 5 135H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-msi-cyborg-15-ai-a1vek-245vn-core-ultra-5-135h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-257', N'CPU: Intel Core Ultra 5 135H (14 nhân, 18 luồng, 18MB, Up to 4.6GHz) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 512GB NVMe PCIe Gen4x4 | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 (194 AI TOPS) | Màn hình: 15.6 inch FHD, IPS, 144Hz, 45% NTSC, Non-touch | Webcam: HD type (30fps@720p) | Cổng kết nôi: 1x Type-C (USB3.2 Gen2 / DisplayPort) 2x Type-A USB3.2 Gen1 1x HDMI 2.1 (4K @ 60Hz) 1x RJ45 | Trọng lượng: 1.98 kg | Pin: 3 Cell, 53.5Whr | Hệ điều hành: Windows 11 bản quyền', 25890000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/04/MSI-Cyborg-15-AI-A1VEK-245VN-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion 5 15IRX10 83LY00HQVN (Core i7 13650HX, 16GB, 512GB, RTX 5060 8GB, 15.3 FHD+ 165Hz)', 'new-100-lenovo-legion-5-15irx10-83ly00hqvn-core-i7-13650hx-16gb-512gb-rtx-5060-8gb-153-fhd-165hz-258', N'CPU: Intel® Core™ i7-13650HX (2.60GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB (1x 16GB) SO-DIMM DDR5-4800MHz ( 2slots, Up to 32GB) | Ổ cứng: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA® GeForce RTX™ 5060 8GB GDDR7 | Màn hình: 15.3″ FHD+ (1920×1200) IPS 300nits Anti-glare, 100% sRGB, 165Hz, Dolby Vision®, G-SYNC® | Webcam: FHD IR Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.1 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 40990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/11/28477_laptop_lenovo_legion_5_15ahp10_83m0002yvn_n.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion 5 15IRX10 83LY00HRVN (Core i7 13650HX, 16GB, 512GB, RTX 5050 8GB, 15.3 FHD+ 165Hz)', 'new-100-lenovo-legion-5-15irx10-83ly00hrvn-core-i7-13650hx-16gb-512gb-rtx-5050-8gb-153-fhd-165hz-259', N'CPU: Intel® Core™ i7-13650HX (2.60GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB (1x 16GB) SO-DIMM DDR5-4800MHz ( 2slots, Up to 32GB) | Ổ cứng: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | GPU: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Màn hình: 15.3″ FHD+ (1920×1200) IPS 300nits Anti-glare, 100% sRGB, 165Hz, Dolby Vision®, G-SYNC® | Webcam: FHD IR Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.1 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 37990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/11/28477_laptop_lenovo_legion_5_15ahp10_83m0002yvn_n.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Pro 5 16IAX10 (Ultra 9 275 HX, 32GB, 1TB, RTX 5070 8GB, 16 2K+ OLED 240Hz)', 'new-100-lenovo-legion-pro-5-16iax10-ultra-9-275-hx-32gb-1tb-rtx-5070-8gb-16-2k-oled-240hz-260', N'CPU: Intel Core Ultra 9 275HX (24 nhân 24 luồng, xung nhịp cơ bản từ 2.1GHz có thể đạt max với turbo boost lên tới 5.4GHz, 36MB Cache) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5070 8GB | Màn hình: 16.0″ WQXGA (2560×1600) OLED 0.08ms, 500nits, 240Hz, 100% DCI-P3, độ sáng tối đa có thể đạt 1100nits, Dolby Vision, HDR 1000, Free-Sync, G-Sync, DC dimmer, TÜV Rheinland | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-Cell, 80Wh | Hệ điều hành: Windows 11 bản quyền', 44390000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Legion-Pro-5-16IAX10-3.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Pro 5 16IAX10 (Ultra 9 275 HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ OLED 240Hz)', 'new-100-lenovo-legion-pro-5-16iax10-ultra-9-275-hx-32gb-1tb-rtx-5060-8gb-16-2k-oled-240hz-261', N'CPU: Intel Core Ultra 9 275HX (24 nhân 24 luồng, xung nhịp cơ bản từ 2.1GHz có thể đạt max với turbo boost lên tới 5.4GHz, 36MB Cache) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0″ WQXGA (2560×1600) OLED 0.08ms, 500nits, 240Hz, 100% DCI-P3, độ sáng tối đa có thể đạt 1100nits, Dolby Vision, HDR 1000, Free-Sync, G-Sync, DC dimmer, TÜV Rheinland | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-Cell, 80Wh | Hệ điều hành: Windows 11 bản quyền', 40990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Legion-Pro-5-16IAX10-3.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo Fighter 7000 2025 (Core i7-14650HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 180Hz)', 'new-100-lenovo-lecoo-fighter-7000-2025-core-i7-14650hx-16gb-1tb-rtx-5060-8gb-16-2k-180hz-262', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 180Hz, 100% sRGB, hỗ trợ HDR, Free-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 35090000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/b9jdGtx0WlSOJdiyItS9zYvdv-6090.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion 5 2025 15AHP10 (Ryzen 7 260, 16GB, 512GB, RTX 5060 8GB, 15.1 2K+ OLED 165Hz)', 'new-100-lenovo-legion-5-2025-15ahp10-ryzen-7-260-16gb-512gb-rtx-5060-8gb-151-2k-oled-165hz-263', N'CPU: AMD Ryzen 7 260 (8 nhân 16 luồng, xung nhịp cơ bản 3.8GHz có thể đạt tới 5.1GHz đơn nhân với turbo boost, 8MB L2 Cache, 16MB L3 Cache, default TDP 45W) | RAM: 16GB DDR5 5600MHz (có thể nâng cấp) | Ổ cứng: 512GB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.1″ 2K+ (2560×1600) OLED, 500nits, glossy, 100% DCI-P3, 165Hz, Dolby Vision®, DisplayHDR™ True Black 600 | Webcam: FHD IR Webcam | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 5Gbps 1x USB-A 3.2 5Gbps + Output 5V/2A 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.0 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 32990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/11/28477_laptop_lenovo_legion_5_15ahp10_83m0002yvn_n.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000P 2025 (Ryzen 9-8945HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-legion-r7000p-2025-ryzen-9-8945hx-16gb-1tb-rtx-5060-8gb-16-2k-240hz-264', N'CPU: AMD Ryzen 9 8945HX (16 nhân 32 luồng, xung nhịp cơ bản 2.5GHz có thể đạt tới 5.4GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W-120w) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 500nits, 240Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 Gen 1 5Gbps 1x USB-A 3.2 Gen 1 10Gbps 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.3 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 36990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3718_co3esrv9hvoan3sz5x6wldb50_1752.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo Fighter 7000 2025 (Core i7-13650HX, 16GB, 512GB, RTX 5060 8GB, 16 2K+ 180Hz)', 'new-100-lenovo-lecoo-fighter-7000-2025-core-i7-13650hx-16gb-512gb-rtx-5060-8gb-16-2k-180hz-265', N'CPU: 13th Generation Intel® Core i7-13650HX, 14C / 20T, P-core up to 4.9GHz, 24MB Cache | RAM: 16GB DDR5 | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 180Hz, 100% sRGB, hỗ trợ HDR, Free-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 28990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/b9jdGtx0WlSOJdiyItS9zYvdv-6090.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000P 2025 (Core i9-14900HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-legion-y7000p-2025-core-i9-14900hx-16gb-1tb-rtx-5060-8gb-16-2k-240hz-266', N'CPU: 14th Generation Intel® Core i9-14900HX, 24C / 32T, P-core up to 5.8GHz, 36MB Cache | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 500nits, 240Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 Gen 1 5Gbps 1x USB-A 3.2 Gen 1 10Gbps 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.3 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 39990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/Zw1xpnzwYM1p5TJfcL6iV50Qy-0869.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y9000P 2025 (Ultra 9 275 HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ OLED 240Hz)', 'new-100-lenovo-legion-y9000p-2025-ultra-9-275-hx-32gb-1tb-rtx-5060-8gb-16-2k-oled-240hz-267', N'CPU: Intel Core Ultra 9 275HX (24 nhân 24 luồng, xung nhịp cơ bản từ 2.1GHz có thể đạt max với turbo boost lên tới 5.4GHz, 36MB Cache) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0″ WQXGA (2560×1600) OLED 0.08ms, 500nits, 240Hz, 100% DCI-P3, độ sáng tối đa có thể đạt 1100nits, Dolby Vision, HDR 1000, Free-Sync, G-Sync, DC dimmer, TÜV Rheinland | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-Cell, 80Wh | Hệ điều hành: Windows 11 bản quyền', 51690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3737_vb7czzgqeq41pzmu0ss0jotda_5078.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R9000P 2025 (Ryzen 9 8945HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-legion-r9000p-2025-ryzen-9-8945hx-32gb-1tb-rtx-5060-8gb-16-2k-240hz-268', N'CPU: AMD Ryzen 9 8945HX (16 nhân 32 luồng, xung nhịp cơ bản 2.5GHz có thể đạt tới 5.4GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W-120w) | RAM: 32GB DDR5 5200MHz (có thể nâng cấp) | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 240Hz, 100% DCI-P3, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-cell, 80wh | Hệ điều hành: Windows 11 bản quyền', 42590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3713_jykp76jduymiwq0z6ukggdvew_1760.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y9000P 2025 (Ultra 9 275 HX, 32GB, 1TB, RTX 5070 8GB, 16 2K+ OLED 240Hz)', 'new-100-lenovo-legion-y9000p-2025-ultra-9-275-hx-32gb-1tb-rtx-5070-8gb-16-2k-oled-240hz-269', N'CPU: Intel Core Ultra 9 275HX (24 nhân 24 luồng, xung nhịp cơ bản từ 2.1GHz có thể đạt max với turbo boost lên tới 5.4GHz, 36MB Cache) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5070 8GB | Màn hình: 16.0″ WQXGA (2560×1600) OLED 0.08ms, 500nits, 240Hz, 100% DCI-P3, độ sáng tối đa có thể đạt 1100nits, Dolby Vision, HDR 1000, Free-Sync, G-Sync, DC dimmer, TÜV Rheinland | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-Cell, 80Wh | Hệ điều hành: Windows 11 bản quyền', 54990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3737_vb7czzgqeq41pzmu0ss0jotda_5078.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000 2025 (Core i7-14650HX, 24GB, 512GB, RTX 5060 8GB, 15.3 2K+ 180Hz)', 'new-100-lenovo-legion-y7000-2025-core-i7-14650hx-24gb-512gb-rtx-5060-8gb-153-2k-180hz-270', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 24GB DDR5 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ 2K+ (2560×1600) IPS, non-touch, 400nits, 180Hz, | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 33690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3715_brcvhww7eofpn561dte0uyi6n_0720.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000P ADR10 (Ryzen 9-8940HX, 16GB, 1TB, RTX 5050 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-legion-r7000p-adr10-ryzen-9-8940hx-16gb-1tb-rtx-5050-8gb-16-2k-240hz-271', N'CPU: AMD Ryzen 9 8940HX (16 nhân 32 luồng, xung nhịp cơ bản 2.4GHz có thể đạt tới 5.3GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W-120w) | RAM: 16GB DDR5 5200MHz | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 5050 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 500nits, 240Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 2x USB-C 10Gbps, support DP 2.1, PD 3.0 2x USB-A 3.2 Gen 1 5Gbps 1x USB-A 3.2 Gen 1 10Gbps 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.3 kg | Pin: 4cell, 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 31990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3718_co3esrv9hvoan3sz5x6wldb50_1752.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y9000P 2025 (Ultra 9 275 HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ OLED 240Hz) – Glacier White', 'new-100-lenovo-legion-y9000p-2025-ultra-9-275-hx-32gb-1tb-rtx-5060-8gb-16-2k-oled-240hz-glacier-white-272', N'CPU: Intel Core Ultra 9 275HX (24 nhân 24 luồng, xung nhịp cơ bản từ 2.1GHz có thể đạt max với turbo boost lên tới 5.4GHz, 36MB Cache) | RAM: 32GB DDR5 6400MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0″ WQXGA (2560×1600) OLED 0.08ms, 500nits, 240Hz, 100% DCI-P3, độ sáng tối đa có thể đạt 1100nits, Dolby Vision, HDR 1000, Free-Sync, G-Sync, DC dimmer, TÜV Rheinland | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-Cell, 80Wh | Hệ điều hành: Windows 11 bản quyền', 48290000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3741_5ilnoexbwda7hwmcvix9qcgix_8183-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R9000P 2025 (Ryzen 9 8945HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ 240Hz) – Glacier White', 'new-100-lenovo-legion-r9000p-2025-ryzen-9-8945hx-32gb-1tb-rtx-5060-8gb-16-2k-240hz-glacier-white-273', N'CPU: AMD Ryzen 9 8945HX (16 nhân 32 luồng, xung nhịp cơ bản 2.5GHz có thể đạt tới 5.4GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W-120w) | RAM: 32GB DDR5 5200MHz (có thể nâng cấp) | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 240Hz, 100% DCI-P3, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-cell, 80wh | Hệ điều hành: Windows 11 bản quyền', 44290000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3741_5ilnoexbwda7hwmcvix9qcgix_8183.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Strix G16 G615 2025 (Ultra 7 255HX, 16GB, 1TB, RTX 5060 8GB, 16 2.5K 165Hz)', 'new-100-asus-rog-strix-g16-g615-2025-ultra-7-255hx-16gb-1tb-rtx-5060-8gb-16-25k-165hz-274', N'CPU: Intel® Core™ Ultra 7 Processor 255HX (20 nhân 20 luồng, xung nhịp cơ bản từ 2.4GHz có thể đạt max với turbo boost tới 5.2GHz, L2 Cache 36MB, Default TDP 55W) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16″ 2.5K (2560 x 1600) IPS, màn nhám, tần số quét 165Hz, 16:10, 400nits, NanoEdge, độ phủ màu 100% sRGB, 3ms, DC dimming, NVIDIA G-Sync, giảm ánh sáng xanh | Webcam: 1080P FHD camera, 2 mic thu tầm xa, công nghệ AI Noise Cancelling 2 chiều | Cổng kết nôi: 2x USB 3.2 Gen 2 Type-A 10Gbps 1x Type-C USB4 support DP1.4, PD 100W 1x Type-C USB4 support DP1.4 1x RJ45 1× 3.5mm combo audio jack 1x HDMI 2.1 FRL | Trọng lượng: 2.5 kg | Pin: 4-cell, 90 Wh | Hệ điều hành: Windows 11 bản quyền', 40690000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/51PNIm1C94L._AC_SL1080_.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo Fighter 7000 2025 (Ryzen 9 8940HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 180Hz)', 'new-100-lenovo-lecoo-fighter-7000-2025-ryzen-9-8940hx-16gb-1tb-rtx-5060-8gb-16-2k-180hz-275', N'CPU: AMD Ryzen 9 8940HX (16 nhân 32 luồng, xung nhịp cơ bản 2.4GHz có thể đạt tới 5.3GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 180Hz, 100% sRGB, hỗ trợ HDR, Free-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 30290000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/b9jdGtx0WlSOJdiyItS9zYvdv-6090.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000 2025 (Core i7-13650HX, 24GB, 512GB RTX 5060 8GB, 15.3 FHD+ 165Hz)', 'new-100-lenovo-legion-y7000-2025-core-i7-13650hx-24gb-512gb-rtx-5060-8gb-153-fhd-165hz-276', N'CPU: 13th Generation Intel® Core i7-13650HX, 20C (6P + 8E) xung nhịp turbo đơn nhân tối đa 4,9GHz | RAM: 24GB DDR5 5600MHz | Ổ cứng: 512GB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 15.3″ FHD+ IPS, non-touch, 400nits, 165Hz | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 60whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 36590000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/3715_brcvhww7eofpn561dte0uyi6n_0720.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Lecoo Fighter 7000 2025 (Ryzen 9 8945HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 180Hz)', 'new-100-lenovo-lecoo-fighter-7000-2025-ryzen-9-8945hx-16gb-1tb-rtx-5060-8gb-16-2k-180hz-277', N'CPU: AMD Ryzen 9 8945HX (16 nhân 32 luồng, xung nhịp cơ bản 2.5GHz có thể đạt tới 5.4GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 5060 8GB GDDR7 | Màn hình: 16″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 180Hz, 100% sRGB, hỗ trợ HDR, Free-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nôi: 1x E-camera shutter 1x SD card 3x USB-A 3.2 Gen 2 1x RJ45 (mạng LAN) 1x HDMI 2.1 1x power input 2x USB-C 3.2 gen 2 USB-C | Trọng lượng: 2.0 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows 11 bản quyền', 29890000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/08/b9jdGtx0WlSOJdiyItS9zYvdv-6090.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R9000P 2025 (Ryzen 9 8945HX, 32GB, 1TB, RTX 5070 8GB, 16 2K+ 240Hz) – Glacier White', 'new-100-lenovo-legion-r9000p-2025-ryzen-9-8945hx-32gb-1tb-rtx-5070-8gb-16-2k-240hz-glacier-white-278', N'CPU: AMD Ryzen 9 8945HX (16 nhân 32 luồng, xung nhịp cơ bản 2.5GHz có thể đạt tới 5.4GHz đơn nhân với turbo boost, 16MB L2 Cache, 64MB L3 Cache, default TDP 55W-120w) | RAM: 32GB DDR5 5200MHz (có thể nâng cấp) | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5070 8GB | Màn hình: 16.0″ WQXGA (2560×1600) IPS, 500nits, màn nhám, 240Hz, 100% DCI-P3, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer | Webcam: 720p HD với công tắc E-camera Shutter và 2 mic thu tầm xa | Cổng kết nôi: 1x USB-C (support 10Gbps data transfer, DP 2.1, PD 3.0) 1x Thunderbolt 4 (support 40Gbps data transfer, DP 2.1) 2x USB-A 3.2 5Gpbs 1x USB-A 3.2 10Gpbs 1x RJ45 1x HDMI 2.1 1x Combo Jack 3.5mm 1x Power input | Trọng lượng: 2.57 kg | Pin: 4-cell, 80wh | Hệ điều hành: Windows 11 bản quyền', 45790000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3741_5ilnoexbwda7hwmcvix9qcgix_8183.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Strix G16 G614 2025 (Ryzen 9 8940HX, 16GB, 1TB, RTX 5060 8GB, 16 2.5K 165Hz)', 'new-100-asus-rog-strix-g16-g614-2025-ryzen-9-8940hx-16gb-1tb-rtx-5060-8gb-16-25k-165hz-279', N'CPU: AMD Ryzen™ 9 8940HX  (16 nhân 32 luồng, xung nhịp cơ bản từ 2.4GHz có thể đạt max với turbo boost tới 5.4GHz, L2 Cache 16MB, L3 Cache 64MB, Default TDP 55W) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16″ 2.5K (2560 x 1600) IPS, màn nhám, tần số quét 165Hz, 16:10, 400nits, NanoEdge, độ phủ màu 100% sRGB, 3ms, DC dimming, NVIDIA G-Sync, giảm ánh sáng xanh | Webcam: 1080P FHD camera, 2 mic thu tầm xa, công nghệ AI Noise Cancelling 2 chiều | Cổng kết nôi: 2x USB 3.2 Gen 2 Type-A 10Gbps 1x Type-C USB4 support DP1.4, PD 100W 1x Type-C USB4 support DP1.4 1x RJ45 1× 3.5mm combo audio jack 1x HDMI 2.1 FRL | Trọng lượng: 2.5 kg | Pin: 4-cell, 90 Wh | Hệ điều hành: Windows 11 bản quyền', 35990000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/51PNIm1C94L._AC_SL1080_.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Alienware 16 Aurora 2025 (Core 7 240H, 32GB, 1TB, RTX 5060 8GB, 16 2K+ 120Hz)', 'new-100-alienware-16-aurora-2025-core-7-240h-32gb-1tb-rtx-5060-8gb-16-2k-120hz-280', N'CPU: Intel® Core™ 7 Processor 240H (24 MB cache, 10 cores, up to 5.2 GHz, 45 W) | RAM: 32GB Ram DDR5, 5600 MT/s | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA® GeForce RTX™ 5060 8GB GDDR7 | Màn hình: 16″ 2K+ (2560*1600) 120Hz, ComfortView Plus, 100% sRGB, 300 nits | Webcam: 720p at 30 fps HD camera, Dual-array microphones | Cổng kết nối: 2 USB 3.2 Gen 1 (5 Gbps) ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with DisplayPort™ 1.4a ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with Power Delivery 1 HDMI 2.1 port with Discrete Graphics Controller Direct Output 1 universal audio jack (RCA, 3.5 mm) 1 RJ45 Ethernet port, 1GbE 1 power-adapter port | Trọng lượng: 2.5 kg | Pin: 3-cell, 60 Wh, Lithium Ion, ExpressCharge™, ExpressCharge™ Boost | Hệ điều hành: Windows 11 bản quyền', 39590000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/laptop-alienware-ac16250-gallery-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Alienware 16 Aurora 2025 (Core 7 240H, 16GB, 512GB, RTX 5050 8GB, 16 2K+ 120Hz)', 'new-100-alienware-16-aurora-2025-core-7-240h-16gb-512gb-rtx-5050-8gb-16-2k-120hz-281', N'CPU: Intel® Core™ 7 Processor 240H (24 MB cache, 10 cores, up to 5.2 GHz, 45 W) | RAM: 16GB Ram DDR5, 5600 MT/s | Ổ cứng: 512GB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Màn hình: 16″ 2K+ (2560*1600) 120Hz, ComfortView Plus, 100% sRGB, 300 nits | Webcam: 720p at 30 fps HD camera, Dual-array microphones | Cổng kết nối: 2 USB 3.2 Gen 1 (5 Gbps) ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with DisplayPort™ 1.4a ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with Power Delivery 1 HDMI 2.1 port with Discrete Graphics Controller Direct Output 1 universal audio jack (RCA, 3.5 mm) 1 RJ45 Ethernet port, 1GbE 1 power-adapter port | Trọng lượng: 2.5 kg | Pin: 3-cell, 60 Wh, Lithium Ion, ExpressCharge™, ExpressCharge™ Boost | Hệ điều hành: Windows 11 bản quyền', 32390000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/laptop-alienware-ac16250-gallery-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Alienware 16 Aurora 2025 (Core 7 240H, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 120Hz)', 'new-100-alienware-16-aurora-2025-core-7-240h-16gb-1tb-rtx-5060-8gb-16-2k-120hz-282', N'CPU: Intel® Core™ 7 Processor 240H (24 MB cache, 10 cores, up to 5.2 GHz, 45 W) | RAM: 16GB Ram DDR5, 5600 MT/s | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA® GeForce RTX™ 5060 8GB GDDR7 | Màn hình: 16″ 2K+ (2560*1600) 120Hz, ComfortView Plus, 100% sRGB, 300 nits | Webcam: 720p at 30 fps HD camera, Dual-array microphones | Cổng kết nối: 2 USB 3.2 Gen 1 (5 Gbps) ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with DisplayPort™ 1.4a ports 1 USB 3.2 Gen 2 (10 Gbps) Type-C® port with Power Delivery 1 HDMI 2.1 port with Discrete Graphics Controller Direct Output 1 universal audio jack (RCA, 3.5 mm) 1 RJ45 Ethernet port, 1GbE 1 power-adapter port | Trọng lượng: 2.5 kg | Pin: 3-cell, 60 Wh, Lithium Ion, ExpressCharge™, ExpressCharge™ Boost | Hệ điều hành: Windows 11 bản quyền', 38190000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/laptop-alienware-ac16250-gallery-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Zephyrus G16 GU605MI (Ultra 9 185H, 16GB, 1TB, RTX 4070 8GB, 16 3K OLED 240Hz)', 'new-100-asus-rog-zephyrus-g16-gu605mi-ultra-9-185h-16gb-1tb-rtx-4070-8gb-16-3k-oled-240hz-283', N'CPU: Intel® Core™ Ultra 9 processor 185H 2.3GHz up to 5.1GHz 24MB | RAM: 16 Onboard LPDDR5X 7467MHz | Ổ cứng: 1TB PCIe® 4.0 NVMe™ M.2 SSD (2 slot, support M.2 2280 PCIe 4.0×4) | GPU: NVIDIA® GeForce RTX™ 4070 8GB GDDR6 With ROG Boost: 2105MHz* at 105W (2055MHz Boost Clock+50MHz OC, 85W+20W Dynamic Boost) | Màn hình: 16″ 2.5K (2560 x 1600) 16:10 240Hz/0.2ms, OLED, 100% DCI-P3 %, 500NITS, GSync, Support Dolby Vision HDR, Glossy display, Pantone Validated, ROG Nebula Display | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nối: 1x Thunderbolt™ 4 support DisplayPort™ / power delivery 1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery 2x USB 3.2 Gen 2 Type-A 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Pin: 4 Cell 90WHr | Trọng lượng: 1.85 kg | Hệ điều hành: Window 11 bản quyền', 42290000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/mjbshlw6-1348-asus-rog-zephyrus-g16-2024-gu605mi-qr116w-intel-core-ultra-9-185h-16gb-1tb-geforce-rtx-4070-8gb-16-2-5k-oled-240hz-new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Strix G16 G614 2025 (Ryzen 9 8940HX, 16GB, 1TB, RTX 5070Ti 12GB, 16 2.5K 165Hz)', 'new-100-asus-rog-strix-g16-g614-2025-ryzen-9-8940hx-16gb-1tb-rtx-5070ti-12gb-16-25k-165hz-284', N'CPU: AMD Ryzen™ 9 8940HX  (16 nhân 32 luồng, xung nhịp cơ bản từ 2.4GHz có thể đạt max với turbo boost tới 5.4GHz, L2 Cache 16MB, L3 Cache 64MB, Default TDP 55W) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5070Ti 12GB | Màn hình: 16″ 2.5K (2560 x 1600) IPS, màn nhám, tần số quét 165Hz, 16:10, 400nits, NanoEdge, độ phủ màu 100% sRGB, 3ms, DC dimming, NVIDIA G-Sync, giảm ánh sáng xanh | Webcam: 1080P FHD camera, 2 mic thu tầm xa, công nghệ AI Noise Cancelling 2 chiều | Cổng kết nôi: 2x USB 3.2 Gen 2 Type-A 10Gbps 1x Type-C USB4 support DP1.4, PD 100W 1x Type-C USB4 support DP1.4 1x RJ45 1× 3.5mm combo audio jack 1x HDMI 2.1 FRL | Trọng lượng: 2.5 kg | Pin: 4-cell, 90 Wh | Hệ điều hành: Windows 11 bản quyền', 51990000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/51PNIm1C94L._AC_SL1080_.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Pro 5 R9000P 2024 (Ryzen 9-7945HX, 16GB, 1TB, RTX 4060 8GB, 16 WQXGA 240Hz Glacier White)', 'new-100-lenovo-legion-pro-5-r9000p-2024-ryzen-9-7945hx-16gb-1tb-rtx-4060-8gb-16-wqxga-240hz-glacier-white-285', N'CPU: AMD Ryzen 9 7945HX (16 cores x 32 threads, 2.5 up to 5.4GHz, 64MB Cache) | RAM: 16GB RAM DDR5 5600MHz | Ổ cứng: 1 TB M.2 2280 PCIe 4.0 SSD | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 (140W) | MUX Swìtch: Có | Màn hình: 16 inch WQXGA (2560 x 1600), IPS, Anti-Glare, Non-Touch, 100%sRGB, 500 nits, 240Hz, LED Backlight, Narrow Bezel, Low Blue Light | Webcam: 720P | Cổng kết nối: 2x USB-C Thunderbolt 4 3x USB-A 3.2 Gen 1 1x USB-A 3.2 Gen 1 (One Always On) 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.53 Kg | Pin: 6-Cell, 80 Wh | Hệ điều hành: Windows bản quyền', 34490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/z6546315741884_ce41fe035315c165642fe1008106e7df.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y9000P 2024 (Core i9-14900HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-legion-y9000p-2024-core-i9-14900hx-16gb-1tb-rtx-4060-8gb-16-2k-240hz-286', N'CPU: 14th Generation Intel® Core i9-14900HX, 24C / 32T, P-core up to 5.8GHz, E-core up to 4.1GHz, 36MB Cache | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 (140W) | Màn hình: 16″ WQXGA (2560×1600) IPS 500nits Anti-glare, 100% sRGB, 240Hz, DisplayHDR™ 400, Dolby® Vision™, G-SYNC®, Low Blue Light | Webcam: 720P | Cổng kết nôi: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.53 kg | Pin: 4-Cell 80 Whr | Hệ điều hành: Windows 11 bản quyền', 34990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/02/3443_3146_ssu7lvoquoygghpfdwg5hlpmi_0077.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R9000P (Ryzen 9-7945HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 240Hz)', 'new-100-lenovo-legion-r9000p-ryzen-9-7945hx-16gb-1tb-rtx-4060-8gb-16-2k-240hz-287', N'CPU: AMD Ryzen 9 7945HX (16 cores x 32 threads, 2.5 up to 5.4GHz, 64MB Cache) | RAM: 16GB RAM DDR5 5600MHz | Ổ cứng: 1 TB M.2 2280 PCIe 4.0 SSD | Card VGA: NVIDIA GeForce RTX 4060 8GB GDDR6 (140W) | MUX Swìtch: Có | Màn hình: 16 inch 2K+ (2560 x 1600), IPS, Anti-Glare, Non-Touch, 100%sRGB, 500 nits, 240Hz, LED Backlight, Narrow Bezel, Low Blue Light | Webcam: 720P | Cổng kết nối: 2x USB-C Thunderbolt 4 3x USB-A 3.2 Gen 1 1x USB-A 3.2 Gen 1 (One Always On) 1x RJ45 1x HDMI 2.1 1x Jack 3.5mm 1x Power input | Trọng lượng: 2.53 Kg | Pin: 6-Cell, 80 Wh | Hệ điều hành: Windows bản quyền', 33890000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/06/y9000.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming Vivobook K3605VC-RP521W (Core i5-13420H, 8GB, 512GB, RTX 3050 4GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-vivobook-k3605vc-rp521w-core-i5-13420h-8gb-512gb-rtx-3050-4gb-16-fhd-144hz-288', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 8GB DDR4 onboard DDR4 | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA® GeForce® RTX™ 3050 4GB GDDR6 | Màn hình: 16″ FHD+ (1920×1200) 16:10, IPS, 144Hz, 45% NTSC, 300nits, Anti-glare display, TÜV Rheinland-certified | Cổng kết nôi: 1 x Type-C® USB 3.2 Gen 1 support power deliver 2 x USB 3.2 Gen 1 Type A 1 x HDMI 2.1 1 x 3.5mm combo audio jac 1 x DC-in | Trọng lượng: 1.8 kg | Pin: 3 Cell 50WHrs, 3S1P | Hệ điều hành: Windows 11 Home bản quyền', 18590000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/vivobook_16x_k3605z_k3605v_product_photo_2k_indie_black_05_non-fingerprint_non-backlit.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming Vivobook K3605ZU-RP296W (Core i5-12500H, 16GB, 512GB, RTX 4050 6GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-vivobook-k3605zu-rp296w-core-i5-12500h-16gb-512gb-rtx-4050-6gb-16-fhd-144hz-289', N'CPU: Intel® Core™ i5-12500H (2.50GHz up to 4.50GHz, 18MB Cache) | RAM: 16GB DDR4 3200MHz on board + 1 khe SO-DIMM | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA® GeForce® RTX™ 4050 6GB GDDR6 | Màn hình: 16″ FHD+ (1920×1200) 16:10, IPS, 144Hz, 45% NTSC, 300nits, Anti-glare display, TÜV Rheinland-certified | Cổng kết nôi: 1 x Type-C® USB 3.2 Gen 1 support power deliver 2 x USB 3.2 Gen 1 Type A 1 x HDMI 2.1 1 x 3.5mm combo audio jac 1 x DC-in | Trọng lượng: 1.8 kg | Pin: 3Cell 70WHrs, 3S1P | Hệ điều hành: Windows 11 Home bản quyền', 20190000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/vivobook_16x_k3605z_k3605v_product_photo_2k_indie_black_05_non-fingerprint_non-backlit.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming Vivobook K3605VC-RP431W (Core i5-13420H, 16GB, 512GB, RTX 3050 4GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-vivobook-k3605vc-rp431w-core-i5-13420h-16gb-512gb-rtx-3050-4gb-16-fhd-144hz-290', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 16GB (8GB DDR4 onboard + 8GB DDR4 SO-DIMM) DDR4 3200MHz | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA® GeForce® RTX™ 3050 4GB GDDR6 | Màn hình: 16″ FHD+ (1920×1200) 16:10, IPS, 144Hz, 45% NTSC, 300nits, Anti-glare display, TÜV Rheinland-certified | Cổng kết nôi: 1 x Type-C® USB 3.2 Gen 1 support power deliver 2 x USB 3.2 Gen 1 Type A 1 x HDMI 2.1 1 x 3.5mm combo audio jac 1 x DC-in | Trọng lượng: 1.8 kg | Pin: 3 Cell 50WHrs, 3S1P | Hệ điều hành: Windows 11 Home bản quyền', 17690000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/vivobook_16x_k3605z_k3605v_product_photo_2k_indie_black_05_non-fingerprint_non-backlit.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Omen 16-am0000TX (Core i7-14650HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ 240Hz)', 'new-100-hp-omen-16-am0000tx-core-i7-14650hx-16gb-1tb-rtx-5060-8gb-16-2k-240hz-291', N'CPU: Intel Core i7-14650HX (16 Cores , 30M Cache, 5.20 GHz) | RAM: 16GB DDR5-5600 MHz RAM (2 x 16 GB) | Ổ cứng: 1TB PCIe NVMe TLC M.2 SSD | GPU: NVIDIA GeForce RTX 5060 8GB | Màn hình: 16″ 2K+ (2560 x 1600), 60-240Hz, 500 nits, 3 ms response time, IPS | Webcam: HP True Vision 1080p FHD camera | Cổng kết nôi: 1 x USB Type-A 5Gbps signaling rate (HP Sleep and Charge) 1 x USB Type-C 5Gbps signaling rate (USB Power Delivery, DisplayPort 1.4, HP Sleep and Charge) 2 x USB Type-A 5Gbps signaling rate 1 x HDMI 2.1 1 x RJ-45 1 x AC smart pin 1 x headphone/microphone combo | Trọng lượng: 2.35 Kg | Pin: 6-cell 83 Wh Li-ion polymer | Hệ điều hành: Windows 11 bản quyền', 35090000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/hp-omen-16-am0000tx-2024-gaming-laptop-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro ProPanel ANV15-52-59AA NH.QZ9SV.002 (Core i5-13420H, 16GB, 512GB, RTX 5050 8GB, 15.6 FHD IPS 180Hz)', 'new-100-acer-nitro-propanel-anv15-52-59aa-nhqz9sv002-core-i5-13420h-16gb-512gb-rtx-5050-8gb-156-fhd-ips-180hz-292', N'CPU: Intel® Core™ i5-13420H (2.10GHz up to 4.60GHz, 12MB Cache) | RAM: 16GB DDR4 3200Mhz (2 khe rời – nâng cấp tối đa 64GB) | Ổ cứng: 512GB PCIe NVMe SSD (nâng cấp tối đa 2TB) | GPU: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Màn hình: 15.6 inch FHD(1920 x 1080) IPS, 180Hz, 100% sRGB, Acer ComfyView | Cổng kết nôi: USB Type-C 1 x USB Type-C™ port, supporting: • USB 3.2 Gen 2 (up to 10 Gbps) • DisplayPort over USB-C via iGPU • Thunderbolt™ 4 • USB charging 5 V; 3 A • DC-in port 20 V; 65 WUSB Standard A 3 x USB Standard-A ports, supporting: • 1x port for USB 3.2 Gen 1 featuring power off USB charging • 2x ports for USB 3.2 Gen 11 x HDMI® 2.1 port with HDCP support1 x 3.5 mm headphone/speaker jack, supporting headsets with built-in microphone1 x Ethernet (RJ-45) port1 x DC-in jack for AC adapter | Trọng lượng: ~2.1 kg | Pin: 4 Cell 76WHrs | Hệ điều hành: Windows 11 Home bản quyền', 34290000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23119_29629_laptop_acer_gaming_nitro_v_15_propanel_anv15_52_72bm_nh_qz9sv_004.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ Essential 15IAX9E 83LK0079VN (Core i5-12450HX, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-essential-15iax9e-83lk0079vn-core-i5-12450hx-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-293', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: Intel® Core™ i5-12450HX (2.00GHz up to 4.40GHz, 12MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz | Bộ nhớ trong – Ram: 16GB (1 x 16GB) SO-DIMM DDR5-4800MHz (1 slots, up to 32GB) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: 1 x Card reader | Webcam: HD 720p with Privacy Shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 2 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 5Gbps / USB 3.2 Gen 1), data transfer only 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 57WHrs | Trọng lượng: 1.77 kg | Xuất xứ: Trung Quốc', 22490000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/lenovo-loq-2024-i5-jpg_1726303572.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fa2705TX (Core i5-13420H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fa2705tx-core-i5-13420h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-294', N'CPU: Intel Core i5-13420H (8 Cores/ 12 Threads, 12MB Cache, Turbo boost 4.60GHz) | RAM: 16GB DDR5 | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 21390000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-74-7G42 (Core i7-13650HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ IPS 165Hz)', 'new-100-acer-shadow-knight-sh16-74-7g42-core-i7-13650hx-16gb-1tb-rtx-5060-8gb-16-2k-ips-165hz-295', N'CPU: Intel Core i7-13650HX (2.6GHz up to 4.9GHz,14Cores, 20 Threads, 14MB Cache) | RAM: 16 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA GeForce RTX 5060 8GB GDDR7 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 165Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 27890000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Predator Helios Neo 16S AI PHN16S-71-917K (Ultra 9-275HX, 16GB, 1TB, RTX 5070 8GB, 16 2K+ OLED 240Hz)', 'new-100-acer-predator-helios-neo-16s-ai-phn16s-71-917k-ultra-9-275hx-16gb-1tb-rtx-5070-8gb-16-2k-oled-240hz-296', N'CPU: Intel® Core™ Ultra 9 Processor 275HX 2.7 GHz (36MB Cache, up to 5.4 GHz, 24 cores, 24 Threads); Intel® AI Boost NPU up to 13TOPS | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB PCIe NVMe SED SSDPCIe Gen4 (Còn trống 1 khe SSD M.2 PCIE Gen 4, Up to 4TB) | GPU: NVIDIA® GeForce RTX™ 5070 8GB GDDR7 | Màn hình: 16 inch 2.5K OLED (2560 x 1600, WQXGA) 16:10 aspect ratio Anti-glare display – DCI-P3: 100% 240Hz | Webcam: 1080p HD video at 60 fps with Temporal Noise Reduction | Cổng kết nối: 2x USB Type-C 3x USB-A 1x HDMI 2.1 hỗ trợ HDCP 1x Ethernet (RJ-45) 1x đầu đọc thẻ Micro SD 1x giắc cắm DC-in cho bộ đổi nguồn AC 1x giắc cắm tai nghe/loa 3.5 mm, hỗ trợ tai nghe có tích hợp micrô | Pin: 76Wh 4-cell Li-ion | Trọng lượng: 2.3 kg | Hệ điều hành: Window 11 bản quyền', 42190000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/Acer-Predator-Helios-Neo-16S-AI-2025.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ 15IRX10 (Core i5-13450HX, 16GB, 512GB, RTX 5050 8GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-15irx10-core-i5-13450hx-16gb-512gb-rtx-5050-8gb-156-fhd-144hz-297', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: Intel® Core™ i5-13450HX (3.40GHz up to 4.60GHz, 20MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz, G-SYNC® | Bộ nhớ trong – Ram: 16GB SO-DIMM DDR5-4800MHz (2 slots, Up to 32GB) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: — | Webcam: HD 720p with E-shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 3 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with Lenovo® PD 140W and DisplayPort™ 1.4 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 4Cell 60WHrs | Trọng lượng: 2.4 kg | Xuất xứ: Trung Quốc', 23890000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Lenovo-LOQ-15IRX10-thegioiso365.vn-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ Essential 2026 15IRX11 83SC003RVN (Core i5-13450HX, 16GB, 512GB, RTX 5050 8GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-essential-2026-15irx11-83sc003rvn-core-i5-13450hx-16gb-512gb-rtx-5050-8gb-156-fhd-144hz-298', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: Intel® Core i5-13450HX, 10C (6P + 4E) / 16T, P-core 2.4 / 4.6GHz, E-core 1.8 / 3.4GHz, 20MB | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6″ FHD (1920×1080) IPS 300nits Anti-glare, 100% sRGB, 144Hz | Bộ nhớ trong – Ram: 16GB (1x16GB) SO-DIMM DDR5-4800 (2x DDR5 SO-DIMM slots) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® (2 slot M.2 2242 PCIe® 4.0 x4, up to 1TB) | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 5050 8GB GDDR7, Boost Clock 1500MHz, TGP 65W AI TOPs: 440 TOPs | Card Âm thanh – Audio: Stereo speakers, 2W x2, optimized with Nahimic Audio | Đọc thẻ – Card reader: — | Webcam: HD 720p with E-shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 2x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1x USB-C® (USB 5Gbps / USB 3.2 Gen 1), with USB PD 65-100W 1x HDMI® 2.1, up to 8K/60Hz 1x Headphone / microphone combo jack (3.5mm) 1x Ethernet (RJ-45) 1x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 4 Cell 60 Wh | Trọng lượng: 2.3 kg | Xuất xứ: —', 26990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/12/Lenovo-LOQ-Essential-15IRX11.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ 15ARP9 83JC00LVVN (Ryzen 5-7235HS, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-15arp9-83jc00lvvn-ryzen-5-7235hs-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-299', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: AMD Ryzen™ 5-7235HS (3.20GHz up to 4.20GHz, 8MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz, G-SYNC® | Bộ nhớ trong – Ram: 16GB SO-DIMM DDR5-4800MHz (2 slots, up to 32GB) | Ổ cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: — | Webcam: HD 720p with E-shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 3 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with Lenovo® PD 140W and DisplayPort™ 1.4 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 4Cell 60WHrs | Trọng lượng: 2.38 kg | Xuất xứ: Trung Quốc | Năm sản xuất: 2025 | Đơn vị nhập khẩu phân phối: Chi nhánh Công ty cổ phần thế giới số DGW | Đơn vị bán hàng trực tiếp: Công ty TNHH & Dịch vụ Thế giới số 365', 23190000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/text_ng_n_6__4_96.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000P IRX9 (Core i7-14700HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 165Hz)', 'new-100-lenovo-legion-y7000p-irx9-core-i7-14700hx-16gb-1tb-rtx-4060-8gb-16-2k-165hz-300', N'CPU: 14th Generation Intel® Core i7-14700HX, 20C (8P + 8E) / 28T, P-core up to 5.5GHz, E-core up to 3.9GHz, 33MB Cache | RAM: 16 GB DDR5 | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 32990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3174_3147_khuuf49zxptmtaygwzuivedgz_7317.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion Y7000P IRX9 (Core i7-14700HX, 16GB, 1TB, RTX 4070 8GB, 16 2K+ 165Hz)', 'new-100-lenovo-legion-y7000p-irx9-core-i7-14700hx-16gb-1tb-rtx-4070-8gb-16-2k-165hz-301', N'CPU: 14th Generation Intel® Core i7-14700HX, 20C (8P + 8E) / 28T, P-core up to 5.5GHz, E-core up to 3.9GHz, 33MB Cache | RAM: 16 GB DDR5 | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4070 8GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 34990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/04/3174_3147_khuuf49zxptmtaygwzuivedgz_7317.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo Legion R7000P AHP9 (Ryzen 7-8845H, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 165Hz)', 'new-100-lenovo-legion-r7000p-ahp9-ryzen-7-8845h-16gb-1tb-rtx-4060-8gb-16-2k-165hz-302', N'CPU: Ryzen 7-8845H, up to 5.1GHz | RAM: 16 GB DDR5 | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA Geforce RTX 4060 8GB GDDR6 | Màn hình: 16″ WQXGA (2560×1600) IPS, non-touch, 16:10, 350nits, 165Hz, 100% sRGB, Dolby Vision, AMD FreeSync Premium, NVidia G-Sync, DC dimmer | Webcam: HD Webcam | Cổng kết nối: 3x USB 3.2 Gen 1 1x USB 3.2 Gen 1 (Always On) 1x USB-C® 3.2 Gen 2 (support data transfer and DisplayPort™ 1.4) 1x USB-C® 3.2 Gen 2 (support data transfer, Power Delivery 140W and DisplayPort™ 1.4) 1x HDMI®, up to 8K/60Hz 1x Ethernet (RJ-45) 1x Headphone / microphone combo jack (3.5mm) 1x Power connector | Trọng lượng: 2.3 kg | Pin: 80whr, Super Rapid Charge | Hệ điều hành: Windows bản quyền', 31690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/03/Lenovo-Legion-Slim-5-6-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fa2731TX (Core i5-13420H, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fa2731tx-core-i5-13420h-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-303', N'CPU: Intel Core i5-13420H (8 Cores/ 12 Threads, 12MB Cache, Turbo boost 4.60GHz) | RAM: 16GB DDR5 | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 22790000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fa2013dx (Core i5-13420H, 8GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fa2013dx-core-i5-13420h-8gb-512gb-rtx-3050-6gb-156-fhd-144hz-304', N'CPU: Intel Core i5-13420H (8 Cores/ 12 Threads, 12MB Cache, Turbo boost 4.60GHz) | RAM: 8GB DDR4 3200MHz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 17890000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-74-7W41 (Core i7-14650HX, 32GB, 1TB, RTX 5060 8GB, 16 2K+ IPS 240Hz)', 'new-100-acer-shadow-knight-sh16-74-7w41-core-i7-14650hx-32gb-1tb-rtx-5060-8gb-16-2k-ips-240hz-305', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 32 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA®GeForce® RTX™ 5060 8GB DDR7 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 240Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 36690000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fb3093dx (Ryzen 7 7445HS, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fb3093dx-ryzen-7-7445hs-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-306', N'CPU: Ryzen™ 7 7445HS (8 Cores/ 12 Threads, 16MB Cache, Turbo boost up to 4.5GHz) | RAM: 16GB DDR5 4800Mhz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA Geforce RTX 4050 6GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 21890000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Nitro V 16 AI ANV16-42-R309 (Ryzen 5 – 240, 16GB, 512GB, RTX 5050 8GB, 16 FHD+ IPS 180Hz)', 'new-100-acer-nitro-v-16-ai-anv16-42-r309-ryzen-5-240-16gb-512gb-rtx-5050-8gb-16-fhd-ips-180hz-307', N'CPU: AMD Ryzen™ 5 240 (4.30GHz up to 5.00GHz, 16MB Cache) | RAM: 16GB DDR5 5600MHz (2 khe, nâng cấp tối đa 32GB) | Ổ cứng: 512GB PCIe NVMe SSD (Up to 4TB PCIe Gen4 NVMe SSD​) | GPU: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Màn hình: 16″ FHD+ (1920 x 1200) IPS, 180Hz, tỷ lệ 16:10, Acer ComfyView™ | Cổng kết nôi: 1x USB4 Type-C (hỗ trợ DisplayPort & Power Delivery), 2x USB 3.2 Gen 2 Type-A, 1x USB 3.2 Gen 1 Type-A, 1x HDMI 2.1, 1x RJ-45 (Ethernet), 1x MicroSD Card Reader, 1x jack tai nghe/mic 3.5mm | Trọng lượng: ~2.44 kg | Pin: 76 Wh Lithium-Ion | Hệ điều hành: Windows 11 Home bản quyền', 24090000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/02/Acer-Nitro-V-16-AI-ANV16-42-R309.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Zephyrus G14 GA403WM-QS051WS (Ryzen AI 9 HX370, 32GB, 1TB, RTX 5060 8GB, 14 3K OLED 120Hz)', 'new-100-asus-rog-zephyrus-g14-ga403wm-qs051ws-ryzen-ai-9-hx370-32gb-1tb-rtx-5060-8gb-14-3k-oled-120hz-308', N'CPU: AMD Ryzen™ AI 9 HX 370 Processor 2.0GHz (36MB Cache, up to 5.1GHz, 12 cores, 24 Threads) AMD Ryzen™ AI TOPs: 81 TOPs | RAM: 32GB LPDDR5X 8000 Onboard (Support dual channel memory) | Ổ cứng: 1TB PCIe® 4.0 NVMe™ M.2 SSD (max to 2TB SSD M2.2280 Gen4x4) | GPU: NVIDIA® GeForce RTX™ 5060 8GB GDDR7 | Màn hình: 14″ 3K (2880 x 1800) 16:10, OLED, 120Hz, 0.2ms, 100% DCI-P3, 500 nits, G-Sync, đạt chuẩn Pantone, ROG Nebula Display | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nối: 1x Type-C USB 4 with support for DisplayPort™ / power delivery (data speed up to 40Gbps) 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery / G-SYNC (data speed up to 10Gbps) 2x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x card reader (microSD) (UHS-II) 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Pin: 4 Cell 73WHr (Recharge from 0-50% in 30 minutes) | Trọng lượng: 1.57 Kg | Hệ điều hành: Window 11 bản quyền', 55890000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/zephyrus_g14_grey_05_rgb_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Zephyrus G14 GA403WW-QS145WS (Ryzen AI 9 HX370, 32GB, 2TB, RTX 5080 16GB, 14 3K OLED 120Hz)', 'new-100-asus-rog-zephyrus-g14-ga403ww-qs145ws-ryzen-ai-9-hx370-32gb-2tb-rtx-5080-16gb-14-3k-oled-120hz-309', N'CPU: AMD Ryzen™ AI 9 HX 370 Processor 2.0GHz (36MB Cache, up to 5.1GHz, 12 cores, 24 Threads) AMD Ryzen™ AI TOPs: 81 TOPs | RAM: 32GB LPDDR5X 8000 Onboard (Support dual channel memory) | Ổ cứng: 2TB PCIe® 4.0 NVMe™ M.2 SSD (max to 2TB SSD M2.2280 Gen4x4) | GPU: NVIDIA® GeForce RTX™ 5080 16GB GDDR7 | Màn hình: 14″ 3K (2880 x 1800) 16:10, OLED, 120Hz, 0.2ms, 100% DCI-P3, 500 nits, G-Sync, đạt chuẩn Pantone, ROG Nebula Display | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nối: 1x Type-C USB 4 with support for DisplayPort™ / power delivery (data speed up to 40Gbps) 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery / G-SYNC (data speed up to 10Gbps) 2x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x card reader (microSD) (UHS-II) 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Pin: 4 Cell 73WHr (Recharge from 0-50% in 30 minutes) | Trọng lượng: 1.57 Kg | Hệ điều hành: Window 11 bản quyền', 77690000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/zephyrus_g14_grey_05_rgb_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Omen 16-am0073dx (Core Ultra 7 255H, 16GB, 1TB, RTX 5060 8GB, 16 2K 144Hz)', 'new-100-hp-omen-16-am0073dx-core-ultra-7-255h-16gb-1tb-rtx-5060-8gb-16-2k-144hz-310', N'CPU: Intel Core Ultra 7 255H (24M Cache, 16 Cores, up to 5.10 GHz, Intel AI Boost) | RAM: 16GB DDR5-5600 MHz RAM (2 x 16 GB) | Ổ cứng: 1TB PCIe NVMe TLC M.2 SSD | GPU: NVIDIA GeForce RTX 5060 8GB | Màn hình: 16″ 2K (1920 x 1200), 60-144Hz, 500 nits, 3 ms response time, IPS | Webcam: HP True Vision 1080p FHD camera | Cổng kết nôi: 1 x USB Type-A 5Gbps signaling rate (HP Sleep and Charge) 1 x USB Type-C 5Gbps signaling rate (USB Power Delivery, DisplayPort 1.4, HP Sleep and Charge) 2 x USB Type-A 5Gbps signaling rate 1 x HDMI 2.1 1 x RJ-45 1 x AC smart pin 1 x headphone/microphone combo | Trọng lượng: 2.35 Kg | Pin: 4-cell, 70 Wh Li-ion polymer | Hệ điều hành: Windows 11 bản quyền', 34690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/hp-omen-16-am0000tx-2024-gaming-laptop-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Gigabyte Gaming A16 CMHI2VN894SH (Core i7-13620H, 16GB, 1TB, RTX 4050 6GB, 16 FHD+ 165Hz)', 'new-100-gigabyte-gaming-a16-cmhi2vn894sh-core-i7-13620h-16gb-1tb-rtx-4050-6gb-16-fhd-165hz-311', N'CPU: Intel® Core™ i7-13620H (2.40GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB (16GBx1) DDR5-5200MHz | Ổ cứng: 1TB PCIe Gen4x4 M.2 SSD | GPU: NVIDIA GeForce RTX 4050 Laptop GPU 6GB GDDR6 | Màn hình: 16 inch FHD+ (1920×1200) 165Hz, Anti-glare display | Cổng kết nôi: 1 x Type-A support USB3.2 Gen1 1 x Type-C USB3.2 Gen1 support DisplayPort™ 1.4 and Power Delivery 3.0 1x Type-A support USB3.2 Gen1 1x Type-A support USB2.0 | Trọng lượng: 2.20 kg | Pin: 76WHrs | Hệ điều hành: Windows 11 Home bản quyền', 29490000, 9, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/52193_laptop_gigabyte_gaming_a16_cmhh2vn893sh.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Gigabyte Gaming A16 CTHH3VN893SH (Core i5 13420H, 16GB, 512GB, RTX 5050 8GB, 16 FHD+ 165Hz)', 'new-100-gigabyte-gaming-a16-cthh3vn893sh-core-i5-13420h-16gb-512gb-rtx-5050-8gb-16-fhd-165hz-312', N'CPU: Intel Core i5-13420H (8 nhân 12 luồng, up to 4.60GHz, 12MB Cache) | RAM: 16GB (16GBx1) DDR5-5200MHz | Ổ cứng: 512GB PCIe Gen4x4 M.2 SSD | GPU: NVIDIA GeForce RTX 5050 Laptop GPU 8GB GDDR6 | Màn hình: 16 inch FHD+ (1920×1200) 165Hz, Anti-glare display | Cổng kết nôi: 1 x Type-A support USB3.2 Gen1 1 x Type-C USB3.2 Gen1 support DisplayPort™ 1.4 and Power Delivery 3.0 1x Type-A support USB3.2 Gen1 1x Type-A support USB2.0 | Trọng lượng: 2.20 kg | Pin: 76WHrs | Hệ điều hành: Windows 11 Home bản quyền', 28390000, 9, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/52193_laptop_gigabyte_gaming_a16_cmhh2vn893sh.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Gigabyte Gaming A16 CMHH2VN893SH (Core i5 13420H, 16GB, 512GB, RTX 4050 6GB, 16 FHD+ 165Hz)', 'new-100-gigabyte-gaming-a16-cmhh2vn893sh-core-i5-13420h-16gb-512gb-rtx-4050-6gb-16-fhd-165hz-313', N'CPU: Intel Core i5-13420H (8 nhân 12 luồng, up to 4.60GHz, 12MB Cache) | RAM: 16GB (16GBx1) DDR5-5200MHz | Ổ cứng: 512GB PCIe Gen4x4 M.2 SSD | GPU: NVIDIA GeForce RTX 4050 Laptop GPU 6GB GDDR6 | Màn hình: 16 inch FHD+ (1920×1200) 165Hz, Anti-glare display | Cổng kết nôi: 1 x Type-A support USB3.2 Gen1 1 x Type-C USB3.2 Gen1 support DisplayPort™ 1.4 and Power Delivery 3.0 1x Type-A support USB3.2 Gen1 1x Type-A support USB2.0 | Trọng lượng: 2.20 kg | Pin: 76WHrs | Hệ điều hành: Windows 11 Home bản quyền', 25990000, 9, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/52193_laptop_gigabyte_gaming_a16_cmhh2vn893sh.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ Essential 15ARP10E 83S0004FVN (Ryzen 7 7735HS, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-essential-15arp10e-83s0004fvn-ryzen-7-7735hs-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-314', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: AMD Ryzen™ 7 7735HS (8C / 16T, 3.2 / 4.75GHz, 4MB L2 / 16MB L3) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz | Bộ nhớ trong – Ram: 16GB (1 x 16GB) SO-DIMM DDR5-4800MHz (1 slots, up to 32GB) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 4050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: 1 x Card reader | Webcam: HD 720p with Privacy Shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 2 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 5Gbps / USB 3.2 Gen 1), data transfer only 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 57WHrs | Trọng lượng: 1.77 kg | Xuất xứ: Trung Quốc', 26500000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/lenovo-loq-2024-i5-jpg_1726303572.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ Essential 15ARP10E 83S0006QVN (Ryzen 7 7735HS, 16GB, 512GB, RTX 3050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-essential-15arp10e-83s0006qvn-ryzen-7-7735hs-16gb-512gb-rtx-3050-6gb-156-fhd-144hz-315', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: AMD Ryzen™ 7 7735HS (8C / 16T, 3.2 / 4.75GHz, 4MB L2 / 16MB L3) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz | Bộ nhớ trong – Ram: 16GB (1 x 16GB) SO-DIMM DDR5-4800MHz (1 slots, up to 32GB) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: 1 x Card reader | Webcam: HD 720p with Privacy Shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 2 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 5Gbps / USB 3.2 Gen 1), data transfer only 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 57WHrs | Trọng lượng: 1.77 kg | Xuất xứ: Trung Quốc', 22690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/lenovo-loq-2024-i5-jpg_1726303572.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus TUF Gaming F16 FX608JPR-RV044W (Core i7 14650HX, 16GB, 1TB, RTX 5070 8GB, 16 FHD+ 165Hz)', 'new-100-asus-tuf-gaming-f16-fx608jpr-rv044w-core-i7-14650hx-16gb-1tb-rtx-5070-8gb-16-fhd-165hz-316', N'CPU: Intel® Core™ i7-14650HX (2.20GHz up to 5.20GHz, 30MB Cache) | RAM: 16GB DDR5 SO-DIMM | Ổ cứng: 1TB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA® GeForce RTX™ 5070 8GB GDDR7 | Màn hình: 16-inch FHD+ 16:10 (1920 x 1200, WUXGA) 165Hz, IPS-level, Brightness 300, 1000:1 Contrast Ratio 72.00% NTSC, 100.00% SRGB, 75.35% Adobe Anti-glare display, G-Sync | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nôi: 1x 3.5mm Combo Audio Jack 1x RJ45 LAN port 1x Thunderbolt™ 4 with support for DisplayPort™ / G-SYNC (data speed up to 40Gbps) 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery (data speed up to 10Gbps) 3x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x HDMI 2.1 FRL | Trọng lượng: 2.2 kg | Pin: 90WHrs, 4S1P, 4-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 41590000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/asus_tuf_gaming_f16_02_l_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus TUF Gaming F16 FX608JMR-RV048W (Core i7 14650HX, 16GB, 1TB, RTX 5060 8GB, 16 FHD+ 165Hz)', 'new-100-asus-tuf-gaming-f16-fx608jmr-rv048w-core-i7-14650hx-16gb-1tb-rtx-5060-8gb-16-fhd-165hz-317', N'CPU: Intel® Core™ i7-14650HX (2.20GHz up to 5.20GHz, 30MB Cache) | RAM: 16GB DDR5 SO-DIMM | Ổ cứng: 1TB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA® GeForce RTX™ 5060 8GB GDDR7 | Màn hình: 16-inch FHD+ 16:10 (1920 x 1200, WUXGA) 165Hz, IPS-level, Brightness 300, 1000:1 Contrast Ratio 72.00% NTSC, 100.00% SRGB, 75.35% Adobe Anti-glare display, G-Sync | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nôi: 1x 3.5mm Combo Audio Jack 1x RJ45 LAN port 1x Thunderbolt™ 4 with support for DisplayPort™ / G-SYNC (data speed up to 40Gbps) 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery (data speed up to 10Gbps) 3x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x HDMI 2.1 FRL | Trọng lượng: 2.2 kg | Pin: 90WHrs, 4S1P, 4-cell Li-ion | Hệ điều hành: Windows 11 bản quyền', 35390000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2026/01/asus_tuf_gaming_f16_02_l_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-74-7G41 (Core i7-14650HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ IPS 240Hz)', 'new-100-acer-shadow-knight-sh16-74-7g41-core-i7-14650hx-16gb-1tb-rtx-5060-8gb-16-2k-ips-240hz-318', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 16 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA®GeForce® RTX™ 5060 8GB DDR7 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 240Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 30890000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-72-7G41 (Core i7-14650HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ IPS 165Hz)', 'new-100-acer-shadow-knight-sh16-72-7g41-core-i7-14650hx-16gb-1tb-rtx-4060-8gb-16-2k-ips-165hz-319', N'CPU: 14th Generation Intel® Core i7-14650HX, 16C / 24T, P-core up to 5.2GHz, 30MB Cache | RAM: 16 GB DDR5-5600MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA®GeForce® RTX™ 4060 8GB DDR6 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 165Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 30990000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Shadow Knight SH16-74-7G42 (Core i7-13650HX, 16GB, 1TB, RTX 5060 8GB, 16 2K+ IPS 240Hz)', 'new-100-acer-shadow-knight-sh16-74-7g42-core-i7-13650hx-16gb-1tb-rtx-5060-8gb-16-2k-ips-240hz-320', N'CPU: Intel Core i7-13650HX (2.6GHz up to 4.9GHz,14Cores, 20 Threads, 14MB Cache) | RAM: 16 GB DDR5-4800MHz (up to 64GB) | Ổ cứng: 1 TB PCIe® NVMe™ M.2 SSD gen 4 | GPU: NVIDIA GeForce RTX 5060 8GB GDDR7 | Màn hình: 16″ 2.5K(2560×1600) IPS, màn nhám không cảm ứng, tỷ lệ khung hình 16:10, độ sáng 450nits, tần số quét 240Hz, 100% sRGB, NVidia G-Sync, màn giảm ánh sáng xanh bảo vệ mắt | Cổng kết nôi: 2x USB-C 2 x USB-A (USB 5Gbps) 1x HDMI Headphone / mic combo Ethernet (RJ45) | Trọng lượng: 2,6kg | Pin: 4 Cell 55Wh | Hệ điều hành: Windows 11 Home bản quyền', 28790000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Acer-Shadow-Knight-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ 15ARP9 (Ryzen 5-7235HS, 12GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-15arp9-ryzen-5-7235hs-12gb-512gb-rtx-4050-6gb-156-fhd-144hz-321', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: AMD Ryzen™ 5-7235HS (3.20GHz up to 4.20GHz, 8MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz, G-SYNC® | Bộ nhớ trong – Ram: 12GB (1x 12GB) SO-DIMM DDR5-4800MHz (2 slots, up to 32GB) | Ổ cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 4050 6GB GDDR6 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: — | Webcam: HD 720p with E-shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 3 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with Lenovo® PD 140W and DisplayPort™ 1.4 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 4Cell 60WHrs | Trọng lượng: 2.38 kg', 21690000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Lenovo-LOQ-2024-15IAX9I-1-510x373-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 16 s0146AX – 9Q993PA (Ryzen 5 7640HS, 32GB, 512GB, RTX 3050 6GB, 16.1 FHD 144Hz)', 'new-100-hp-victus-16-s0146ax-9q993pa-ryzen-5-7640hs-32gb-512gb-rtx-3050-6gb-161-fhd-144hz-322', N'CPU: AMD Ryzen™ 5 7640HS (6 nhân, 12 luồng, lên đến 5.0 GHz) | RAM: 32GB DDR5 5600MHz (2 x 16GB) | Ổ cứng: 512GB NVMe PCIe Gen4 SSD | GPU: NVIDIA® GeForce RTX™ 3050 6GB GDDR6 | Màn hình: 16.1 inch, FHD (1920×1080), 144Hz, Tấm nền IPS, Chống lóa (Anti-Glare) | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 19790000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/10061_3993_amd_victus-510x429-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Strix G16 G615JMR-S5155W 2025 (Core i7-14650HX, 32GB, 1TB, RTX 5060 8GB, 16 2.5K 240Hz)', 'new-100-asus-rog-strix-g16-g615jmr-s5155w-2025-core-i7-14650hx-32gb-1tb-rtx-5060-8gb-16-25k-240hz-323', N'CPU: Intel® Core™ i7-14650HX (2.20GHz up to 5.20GHz, 30MB Cache) | RAM: 16GB DDR5 5600MHz | Ổ cứng: 1TB M.2 PCIe NVMe SSD | GPU: NVIDIA® GeForce® RTX 5060 8GB | Màn hình: 16.0inch 2.5K (2560 x 1600, WQXGA) 16:10, IPS, Anti-glare, 100% DCI-P3, 240Hz, 3ms, 500nits, G-Sync, Pantone Validated, ROG Nebula Display | Webcam: 1080P FHD camera, 2 mic thu tầm xa, công nghệ AI Noise Cancelling 2 chiều | Cổng kết nôi: 2x USB 3.2 Gen 2 Type-A 10Gbps 1x Type-C USB4 support DP1.4, PD 100W 1x Type-C USB4 support DP1.4 1x RJ45 1× 3.5mm combo audio jack 1x HDMI 2.1 FRL | Trọng lượng: 2.5 kg | Pin: 4-cell, 90 Wh | Hệ điều hành: Windows 11 bản quyền', 46790000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/03_g_new_16_l_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Lenovo LOQ 15IRX10 83JE006PVN (Core i7-13650HX, 24GB, 512GB, RTX 5050 8GB, 15.6 FHD 144Hz)', 'new-100-lenovo-loq-15irx10-83je006pvn-core-i7-13650hx-24gb-512gb-rtx-5050-8gb-156-fhd-144hz-324', N'Hệ điều hành – Operation System: Windows® 11 Home Single Language bản quyền | Bộ xử lý – CPU: Intel® Core™ i7-13650HX (2.60GHz up to 4.90GHz, 24MB Cache) | Bo mạch chủ – Mainboard: — | Màn hình – Monitor: 15.6inch FHD (1920×1080) IPS, 300nits, Anti-glare, 100% sRGB, 144Hz, G-SYNC® | Bộ nhớ trong – Ram: 24GB SO-DIMM DDR5-4800MHz (2 slots, Up to 32GB) | Ổ đĩa cứng – SSD: 512GB SSD M.2 2242 PCIe® 4.0×4 NVMe® | Card đồ hoạ – Video: NVIDIA® GeForce RTX™ 5050 8GB GDDR7 | Card Âm thanh – Audio: — | Đọc thẻ – Card reader: — | Webcam: HD 720p with E-shutter | Finger Print: — | Giao tiếp mạng – Communications: Wi-Fi® 6, 802.11ax 2×2 | Cổng giao tiếp – Port: 3 x USB-A (USB 5Gbps / USB 3.2 Gen 1) 1 x USB-C® (USB 10Gbps / USB 3.2 Gen 2), with Lenovo® PD 140W and DisplayPort™ 1.4 1 x HDMI® 2.1, up to 8K/60Hz 1 x Headphone / microphone combo jack (3.5mm) 1 x Ethernet (RJ-45) 1 x Power connector | Bluetooth: Bluetooth 5.2 | Pin: 4Cell 60WHrs | Trọng lượng: 2.4 kg | Xuất xứ: Trung Quốc', 30990000, 6, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/Lenovo-LOQ-15IRX10-thegioiso365.vn-1.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus TUF Gaming F16 FX607VJ-RL034W (Core 5 210H, 16GB, 512GB, RTX 3050 6GB, 16 FHD+ 144Hz)', 'new-100-asus-tuf-gaming-f16-fx607vj-rl034w-core-5-210h-16gb-512gb-rtx-3050-6gb-16-fhd-144hz-325', N'CPU: Intel® Core™ 5 210H (2.20GHz up to 4.80GHz, 12MB Cache) | RAM: 16GB DDR4 3200MHz (2 x SO-DIMM slots) | Ổ cứng: 512GB PCIe 4.0 NVMe M.2 SSD | GPU: NVIDIA GeForce RTX 3050 6GB GDDR6 | Màn hình: 16 inch FHD+ 16:10 (1920 x 1200, WUXGA); 144Hz, 7ms, IPS, 300 nits, 1000:1 contrast ratio, 45% NTSC | Webcam: 720P HD camera | Cổng kết nôi: 1x RJ45 LAN port 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery (data speed up to 10Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Trọng lượng: 2.0 kg | Pin: 4 Cell 54WHrs | Hệ điều hành: Windows 11 bản quyền', 23490000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/22237_asus_tuf_gaming_f16_fx607vu_rl045w_a.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Cyborg 15 A13UC 861VN (Core i5-13420H, 16GB, 512GB, RTX 3050 4GB, 15.6 FHD 144Hz)', 'new-100-msi-cyborg-15-a13uc-861vn-core-i5-13420h-16gb-512gb-rtx-3050-4gb-156-fhd-144hz-326', N'CPU: Intel Core i5-13420H (8 Cores/ 12 Threads, 12MB Cache, Turbo boost 4.60GHz) | RAM: 16GB DDR5 5200Mhz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 3050 4GB GDDR6 | Màn hình: 15.6 inch FHD (1920 x 1080), 144Hz, 45% NTSC, IPS | Webcam: HD type (30fps@720p) | Cổng kết nôi: 1x Type-C (USB3.2 Gen2 / DP) 2x Type-A USB3.2 Gen1 1x RJ45 1x HDMI™ 2.1 (4K @ 60Hz) | Trọng lượng: 1.98 kg | Pin: 3 Cell, 53.5Whr | Hệ điều hành: Windows 11 bản quyền', 17690000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/laptop-gaming-msi-cyborg-15-a13u.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 16-s0144AX 9Q991PA (Ryzen 5 7640HS, 32GB, 512GB, RTX 4050 6GB, 16.1 FHD 144Hz)', 'new-100-hp-victus-16-s0144ax-9q991pa-ryzen-5-7640hs-32gb-512gb-rtx-4050-6gb-161-fhd-144hz-327', N'CPU: AMD Ryzen™ 5 7640HS (6 nhân, 12 luồng, lên đến 5.0 GHz) | RAM: 32GB DDR5 5600MHz (2 x 16GB) | Ổ cứng: 512GB NVMe PCIe Gen4 SSD | GPU: NVIDIA® GeForce RTX™ 4050 6GB GDDR6 | Màn hình: 16.1 inch, FHD (1920×1080), 144Hz, Tấm nền IPS, Chống lóa (Anti-Glare) | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 22890000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/10061_3993_amd_victus.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 16-s0142AX 9Q989PA (Ryzen 5 7640HS, 32GB, 512GB, RTX 4060 8GB, 16.1 FHD 144Hz)', 'new-100-hp-victus-16-s0142ax-9q989pa-ryzen-5-7640hs-32gb-512gb-rtx-4060-8gb-161-fhd-144hz-328', N'CPU: AMD Ryzen™ 5 7640HS (6 nhân, 12 luồng, lên đến 5.0 GHz) | RAM: 32GB DDR5 5600MHz (2 x 16GB) | Ổ cứng: 512GB NVMe PCIe Gen4 SSD | GPU: NVIDIA® GeForce RTX™ 4060 8GB GDDR6 (TGP lên đến 120W) | Màn hình: 16.1 inch, FHD (1920×1080), 144Hz, Tấm nền IPS, Chống lóa (Anti-Glare) | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 24890000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/laptop-gaming-hp-victus-16-s0142ax-9q989pa-01.webp', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 16-r0360TX (Core i7-13620H, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 240Hz)', 'new-100-hp-victus-16-r0360tx-core-i7-13620h-16gb-1tb-rtx-4060-8gb-16-2k-240hz-329', N'CPU: Intel Core i7-13620H (10 Cores/ 16 Threads, 24MB Cache, Turbo boost 4.90GHz) | RAM: 16GB DDR5 | Ổ cứng: 1TB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB | Màn hình: 16-inch, 2.5K (2560×1600), 240Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 26990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fa2346TX (Core i7-13620H, 16GB, 1TB, RTX 5060 8GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fa2346tx-core-i7-13620h-16gb-1tb-rtx-5060-8gb-156-fhd-144hz-330', N'CPU: Intel Core i7-13620H (10 Cores/ 16 Threads, 24MB Cache, Turbo boost 4.90GHz) | RAM: 16GB DDR5 5600 MHz | Ổ cứng: 1TB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 5060 8GB | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 26990000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fa2016TX (Core 5-210H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fa2016tx-core-5-210h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-331', N'CPU: Intel Core 5-210H (8 Cores/ 12 Threads, 12MB Cache, Turbo boost 4.80GHz) | RAM: 16GB DDR5 | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 22690000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fb1023AX (Ryzen 5 – 7535HS, 8GB, 512GB, RTX 2050 4GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fb1023ax-ryzen-5-7535hs-8gb-512gb-rtx-2050-4gb-156-fhd-144hz-332', N'CPU: Ryzen™ 5-7535HS (6 Cores/ 12 Threads, 19MB Cache, Turbo boost up to 4.55GHz) | RAM: 8GB DDR5 4800Mhz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 2050 4GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 15290000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/3845_3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Zephyrus G14 2025 GA403 (Ryzen AI 9 HX370, 32GB, 1TB, RTX 5070Ti 12GB, 14 3K OLED 120Hz – Platinum White)', 'new-100-asus-rog-zephyrus-g14-2025-ga403-ryzen-ai-9-hx370-32gb-1tb-rtx-5070ti-12gb-14-3k-oled-120hz-platinum-white-333', N'CPU: AMD Ryzen™ AI 9 HX 370 Processor 2.0GHz (36MB Cache, up to 5.1GHz, 12 cores, 24 Threads) AMD Ryzen™ AI TOPs: 81 TOPs | RAM: 32GB LPDDR5X 8000 Onboard (Support dual channel memory) | Ổ cứng: 1TB PCIe® 4.0 NVMe™ M.2 SSD (max to 2TB SSD M2.2280 Gen4x4) | GPU: NVIDIA® GeForce RTX™ 5070Ti 12GB GDDR7 Turbo mode: 2217MHz at 110W(2167MHz Boost Clock+50MHz OC, 85W+25W Dynamic Boost) AI TOPs: 992 TOPs | Màn hình: 14″ 3K (2880 x 1800) 16:10, OLED, 120Hz, 0.2ms, 100% DCI-P3, 500 nits, G-Sync, đạt chuẩn Pantone, ROG Nebula Display | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nối: 1x Type-C USB 4 with support for DisplayPort™ / power delivery (data speed up to 40Gbps) 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery / G-SYNC (data speed up to 10Gbps) 2x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x card reader (microSD) (UHS-II) 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Pin: 4 Cell 73WHr (Recharge from 0-50% in 30 minutes) | Trọng lượng: 1.57 Kg | Hệ điều hành: Window 11 bản quyền', 75690000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/G14-2025-1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus ROG Zephyrus G14 2025 GA403 (Ryzen AI 9 HX370, 32GB, 1TB, RTX 5070Ti 12GB, 14 3K OLED 120Hz – Eclipse Gray)', 'new-100-asus-rog-zephyrus-g14-2025-ga403-ryzen-ai-9-hx370-32gb-1tb-rtx-5070ti-12gb-14-3k-oled-120hz-eclipse-gray-334', N'CPU: AMD Ryzen™ AI 9 HX 370 Processor 2.0GHz (36MB Cache, up to 5.1GHz, 12 cores, 24 Threads) AMD Ryzen™ AI TOPs: 81 TOPs | RAM: 32GB LPDDR5X 8000 Onboard (Support dual channel memory) | Ổ cứng: 1TB PCIe® 4.0 NVMe™ M.2 SSD (max to 2TB SSD M2.2280 Gen4x4) | GPU: NVIDIA® GeForce RTX™ 5070Ti 12GB GDDR7 Turbo mode: 2217MHz at 110W(2167MHz Boost Clock+50MHz OC, 85W+25W Dynamic Boost) AI TOPs: 992 TOPs | Màn hình: 14″ 3K (2880 x 1800) 16:10, OLED, 120Hz, 0.2ms, 100% DCI-P3, 500 nits, G-Sync, đạt chuẩn Pantone, ROG Nebula Display | Webcam: 1080P FHD IR Camera for Windows Hello | Cổng kết nối: 1x Type-C USB 4 with support for DisplayPort™ / power delivery (data speed up to 40Gbps) 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery / G-SYNC (data speed up to 10Gbps) 2x USB 3.2 Gen 2 Type-A (data speed up to 10Gbps) 1x card reader (microSD) (UHS-II) 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Pin: 4 Cell 73WHr (Recharge from 0-50% in 30 minutes) | Trọng lượng: 1.57 Kg | Hệ điều hành: Window 11 bản quyền', 75690000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/zephyrus_g14_grey_05_rgb_1.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fa0033dx (Core i5-12450H, 8GB, 512GB, RTX 3050 4GB, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fa0033dx-core-i5-12450h-8gb-512gb-rtx-3050-4gb-156-fhd-144hz-335', N'CPU: Intel Core i5-12450H (8 Cores/ 12 Threads, 12MB Cache, Turbo boost 4.40GHz) | RAM: 8GB DDR5 | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 3050 4GB GDDR6 | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 70Wh | Hệ điều hành: Windows 11 bản quyền', 16790000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/06/hp-victus-15-2023-1.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] HP Victus 15-fb2063dx (Ryzen 5 – 7535HS, 8GB, 512GB, RX 6550M, 15.6 FHD 144Hz)', 'new-100-hp-victus-15-fb2063dx-ryzen-5-7535hs-8gb-512gb-rx-6550m-156-fhd-144hz-336', N'CPU: Ryzen™ 5-7535HS (6 Cores/ 12 Threads, 19MB Cache, Turbo boost up to 4.55GHz) | RAM: 8GB DDR5 4800Mhz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: AMD Radeon RX 6550M 4G | Màn hình: 15.6-inch, FHD (1920 x 1080), 144 Hz, 9 ms response time, IPS | Webcam: 720p | Cổng kết nôi: 2x USB Type A 1x USB Type C 1x HDMI 2.1 1x Jack 3.5mm 1x RJ45 1x SD card 1x AC Smart pin | Trọng lượng: ~2.29 kg | Pin: 4 Cells 52Wh | Hệ điều hành: Windows 11 bản quyền', 14390000, 3, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2024/08/3345_hp_victus_15_fb2063dx_ryzen_5_7535hs_8gb_512gb_rx_6550m_15_6_fhd_144hz_new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Thin 15 B12UC 1416VN (Core i5-12450H, 8GB, 512GB, RTX 3050 4GB, 15.6 FHD 144Hz)', 'new-100-msi-thin-15-b12uc-1416vn-core-i5-12450h-8gb-512gb-rtx-3050-4gb-156-fhd-144hz-337', N'CPU: Intel® Core™ i5-12450H (3.00GHz up to 4.40GHz, 12MB cache) | RAM: 8GB DDR4 3200MHz (2 Slots, Max 64GB) | Ổ cứng: 512GB NVMe PCIe SSD Gen4x4 w/o DRAM (1 Slot gen 4 + 1 Slot Sata HDD) | GPU: NVIDIA® GeForce RTX™ 3050 4GB GDDR6 | Màn hình: 15.6 inch FHD (1920 x 1080) 144Hz, 45%NTSC, IPS-Level | Cổng kết nôi: 1 x Type-C (USB3.2 Gen2 / DP) with PD charging 3 x Type-A USB3.2 Gen1 1 x HDMI™ 2.1 (8K @ 60Hz / 4K @ 120Hz) 1 x RJ45 1 x Mic-in, 1 x Headphone-out | Trọng lượng: 1.86 kg | Pin: 3Cell 52.4Whrs | Hệ điều hành: Windows 11 Home bản quyền', 15990000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3750_56447_laptop_msi_gaming_thin_15_b13ucx_2080vn_6.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus TUF Gaming A15 FA506NCG-HN184W (Ryzen 7-7445HS, 16GB, 512GB, RTX 3050 4GB, 15.6 FHD IPS 144Hz)', 'new-100-asus-tuf-gaming-a15-fa506ncg-hn184w-ryzen-7-7445hs-16gb-512gb-rtx-3050-4gb-156-fhd-ips-144hz-338', N'CPU: AMD Ryzen™ 7-7445HS (3.55GHz up to 4.7GHz, 16MB Cache) | RAM: 16GB DDR5-5600MHz SO-DIMM (2x SO-DIMM slots, up to 32GB) | Ổ cứng: 512GB PCIe® 3.0 NVMe™ M.2 SSD (Còn trống 1 khe SSD M.2 PCle) | GPU: NVIDIA® GeForce RTX™ 3050 4GB GDDR6 | Màn hình: 15.6″ FullHD (1920 x 1080), 144Hz, G-sync, IPS Panel | Cổng kết nôi: 1x RJ45 LAN port 1x Thunderbolt™ 4 support DisplayPort™ 1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC 2x USB 3.2 Gen 1 Type-A 1x 3.5mm Combo Audio Jack | Trọng lượng: 2.2kg | Pin: 3 Cell 48WHr | Hệ điều hành: Windows 11 Home bản quyền', 20690000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/23672_screenshot_1756286049.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Katana 15 B13VFK 676VN (Core i7-13620H, 16GB, 1TB, RTX 4060 8GB, 15.6 FHD 144Hz)', 'new-100-msi-katana-15-b13vfk-676vn-core-i7-13620h-16gb-1tb-rtx-4060-8gb-156-fhd-144hz-339', N'CPU: Intel Core i7-13620H (2.40GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB DDR5 5200Mhz | Ổ cứng: 1TB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 | Màn hình: 15.6inch FHD (1920 x 1080), 144Hz, 45%NTSC, IPS-Level | Webcam: HD type (30fps@720p) | Cổng kết nôi: 1 x Type-C (USB3.2 Gen1 / DP) 2 x Type-A USB3.2 Gen1 1 x Type-A USB2.0 1 x (8K @ 60Hz / 4K @ 120Hz) HDMI™ 1 x RJ45 1 x Mic-in/Headphone-out Combo Jack | Trọng lượng: 2.25 kg | Pin: 3 cell, 53.5Whr | Hệ điều hành: Windows 11 bản quyền', 26690000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/20555_msi_katana_15_b13v__logo.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Katana 15 B13VEK 2256VN (Core i7-13620H, 16GB, 512GB, RTX 4050 6GB, 15.6 FHD 144Hz)', 'new-100-msi-katana-15-b13vek-2256vn-core-i7-13620h-16gb-512gb-rtx-4050-6gb-156-fhd-144hz-340', N'CPU: Intel Core i7-13620H (2.40GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB DDR5 5200Mhz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 15.6inch FHD (1920 x 1080), 144Hz, 45%NTSC, IPS-Level | Webcam: HD type (30fps@720p) | Cổng kết nôi: 1 x Type-C (USB3.2 Gen1 / DP) 2 x Type-A USB3.2 Gen1 1 x Type-A USB2.0 1 x (8K @ 60Hz / 4K @ 120Hz) HDMI™ 1 x RJ45 1 x Mic-in/Headphone-out Combo Jack | Trọng lượng: 2.25 kg | Pin: 3 cell, 53.5Whr | Hệ điều hành: Windows 11 bản quyền', 24390000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/20555_msi_katana_15_b13v__logo.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus TUF Gaming F16 FX607VU-RL045W (Core 5 210H, 16GB, 512GB, RTX 4050 6GB, 16 FHD+ 144Hz)', 'new-100-asus-tuf-gaming-f16-fx607vu-rl045w-core-5-210h-16gb-512gb-rtx-4050-6gb-16-fhd-144hz-341', N'CPU: Intel® Core™ 5 210H (2.20GHz up to 4.80GHz, 12MB Cache) | RAM: 16GB DDR5 5200MHz (2 x SO-DIMM slots) | Ổ cứng: 512GB PCIe 4.0 NVMe M.2 SSD | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 16 inch FHD+ 16:10 (1920 x 1200, WUXGA); 144Hz, 7ms, IPS, 300 nits, 1000:1 contrast ratio, 45% NTSC | Webcam: 720P HD camera | Cổng kết nôi: 1x RJ45 LAN port 1x USB 3.2 Gen 2 Type-C with support for DisplayPort™ / power delivery (data speed up to 10Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 2.1 FRL 1x 3.5mm Combo Audio Jack | Trọng lượng: 2.0 kg | Pin: 4 Cell 54WHrs | Hệ điều hành: Windows 11 bản quyền', 26090000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/09/22237_asus_tuf_gaming_f16_fx607vu_rl045w_a.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Cyborg 15 A13VFK 876VN (Core i7-13620H, 16GB, 512GB, RTX 4060 8GB, 15.6 FHD 144Hz)', 'new-100-msi-cyborg-15-a13vfk-876vn-core-i7-13620h-16gb-512gb-rtx-4060-8gb-156-fhd-144hz-342', N'CPU: Intel Core i7-13620H (2.40GHz up to 4.90GHz, 24MB Cache) | RAM: 16GB DDR5 5200Mhz | Ổ cứng: 512GB M.2 2280 PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 | Màn hình: 15.6 inch FHD (1920 x 1080), 144Hz, 45% NTSC, IPS | Webcam: HD type (30fps@720p) | Cổng kết nôi: 1x Type-C (USB3.2 Gen2 / DP) 2x Type-A USB3.2 Gen1 1x RJ45 1x HDMI™ 2.1 (4K @ 60Hz) | Trọng lượng: 1.98 kg | Pin: 3 Cell, 53.5Whr | Hệ điều hành: Windows 11 bản quyền', 24090000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/07/laptop-gaming-msi-cyborg-15-a13u.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming V16 V3607VH-RP025W (Core 7 240H, 16GB, 512GB, RTX 5050 8GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-v16-v3607vh-rp025w-core-7-240h-16gb-512gb-rtx-5050-8gb-16-fhd-144hz-343', N'CPU: Intel® Core™ 7 240H (2.50GHz up to 5.20GHz, 24MB Cache) | RAM: 16GBx1 DDR5 SO-DIMM (2 khe) | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA GeForce RTX 5050 8GB GDDR7 | Màn hình: 16.0-inch, WUXGA (1920 x 1200) 16:10 LED Backlit 144Hz Anti-glare display | Cổng kết nôi: 1x USB 3.2 Gen 1 Type-C with support for power delivery (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack 1x DC-in SD 4.0 card reader | Trọng lượng: 1.95 kg | Pin: 63WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 Home bản quyền', 31990000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/asus_v3607_product_photo_1k_matte_black_03_kb_light-on.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming V16 V3607VH-RP024W (Core 5 210H, 16GB, 512GB, RTX RTX 5050 8GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-v16-v3607vh-rp024w-core-5-210h-16gb-512gb-rtx-rtx-5050-8gb-16-fhd-144hz-344', N'CPU: Intel Core 5 210H 2.2 GHz (12MB Cache, up to 4.8 GHz, 8 cores, 12 Threads) | RAM: 16GBx1 DDR5 SO-DIMM (2 khe) | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA GeForce RTX 5050 8GB GDDR7 | Màn hình: 16.0-inch, WUXGA (1920 x 1200) 16:10 LED Backlit 144Hz Anti-glare display | Cổng kết nôi: 1x USB 3.2 Gen 1 Type-C with support for power delivery (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack 1x DC-in SD 4.0 card reader | Trọng lượng: 1.95 kg | Pin: 63WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 Home bản quyền', 26590000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/asus_v3607_product_photo_1k_matte_black_03_kb_light-on.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming V16 V3607VU-RP216W (Core 7 240H, 16GB, 512GB, RTX 4050 6GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-v16-v3607vu-rp216w-core-7-240h-16gb-512gb-rtx-4050-6gb-16-fhd-144hz-345', N'CPU: Intel® Core™ 7 240H (2.50GHz up to 5.20GHz, 24MB Cache) | RAM: 16GBx1 DDR5 SO-DIMM (2 khe) | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 16.0-inch, WUXGA (1920 x 1200) 16:10 LED Backlit 144Hz Anti-glare display | Cổng kết nôi: 1x USB 3.2 Gen 1 Type-C with support for power delivery (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack 1x DC-in SD 4.0 card reader | Trọng lượng: 1.95 kg | Pin: 63WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 Home bản quyền', 29990000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/asus_v3607_product_photo_1k_matte_black_03_kb_light-on.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Asus Gaming V16 V3607VU-RP343W (Core 5 210H, 16GB, 512GB, RTX 4050 6GB, 16 FHD+ 144Hz)', 'new-100-asus-gaming-v16-v3607vu-rp343w-core-5-210h-16gb-512gb-rtx-4050-6gb-16-fhd-144hz-346', N'CPU: Intel Core 5 210H 2.2 GHz (12MB Cache, up to 4.8 GHz, 8 cores, 12 Threads) | RAM: 16GBx1 DDR5 SO-DIMM (2 khe) | Ổ cứng: 512GB M.2 NVMe™ PCIe® 4.0 SSD | GPU: NVIDIA GeForce RTX 4050 6GB GDDR6 | Màn hình: 16.0-inch, WUXGA (1920 x 1200) 16:10 LED Backlit 144Hz Anti-glare display | Cổng kết nôi: 1x USB 3.2 Gen 1 Type-C with support for power delivery (data speed up to 5Gbps) 2x USB 3.2 Gen 1 Type-A (data speed up to 5Gbps) 1x HDMI 2.1 TMDS 1x 3.5mm Combo Audio Jack 1x DC-in SD 4.0 card reader | Trọng lượng: 1.95 kg | Pin: 63WHrs, 3S1P, 3-cell Li-ion | Hệ điều hành: Windows 11 Home bản quyền', 25290000, 4, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/asus_v3607_product_photo_1k_matte_black_03_kb_light-on.png', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] MSI Thin 15 B13UC 2044VN (Core i7-13620H, 16GB, 512GB, RTX 3050 4GB, 15.6 FHD 144Hz)', 'new-100-msi-thin-15-b13uc-2044vn-core-i7-13620h-16gb-512gb-rtx-3050-4gb-156-fhd-144hz-347', N'CPU: Intel® Core™ i7-13620H (2.40GHz up to 4.90GHz, 24MB cache) | RAM: 16GB DDR4 3200MHz (2 Slots, Max 64GB) | Ổ cứng: 512GB NVMe PCIe SSD Gen4x4 w/o DRAM (1 Slot gen 4 + 1 Slot Sata HDD) | GPU: NVIDIA® GeForce RTX™ 3050 4GB GDDR6 | Màn hình: 15.6 inch FHD (1920 x 1080) 144Hz, 45%NTSC, IPS-Level | Cổng kết nôi: 1 x Type-C (USB3.2 Gen2 / DP) with PD charging 3 x Type-A USB3.2 Gen1 1 x HDMI™ 2.1 (8K @ 60Hz / 4K @ 120Hz) 1 x RJ45 1 x Mic-in, 1 x Headphone-out | Trọng lượng: 1.86 kg | Pin: 3Cell 52.4Whrs | Hệ điều hành: Windows 11 Home bản quyền', 19290000, 7, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/06/3750_56447_laptop_msi_gaming_thin_15_b13ucx_2080vn_6.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Dell Gaming G15 5530 (Core i7-13650HX, 16GB, 1TB, RTX 4060 8GB, 15.6 QHD 240Hz)', 'new-100-dell-gaming-g15-5530-core-i7-13650hx-16gb-1tb-rtx-4060-8gb-156-qhd-240hz-348', N'CPU: 14th Generation Intel® Core i7-14700HX, 20C (8P + 8E) / 28T, P-core up to 5.5GHz, E-core up to 3.9GHz, 33MB Cache | RAM: 16GB DDR5 4800Mhz | Ổ cứng: 1TB PCIe NVMe M.2 SSD Gen 4 | GPU: NVIDIA GeForce RTX 4060 8GB GDDR6 | Màn hình: 15″ QHD (16:9), 240Hz, 300 nits, 68% sRGB | Webcam: HD Webcam | Cổng kết nối: 3x SuperSpeed USB 3.2 Gen 1 Type-A 1x USB-C 3.2 Gen 2 with Display Port Alt-Mode 1x HDMI 2.1 1x Headphone/Mic 1x RJ45 | Trọng lượng: 2.65 kg | Pin: 3 Cells, 86Wh | Hệ điều hành: Windows bản quyền', 27690000, 2, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2023/06/56144_laptop_dell_gaming_g15_5530_71045030_8.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Predator Triton Neo 16 PTN16-51 (Ultra 7 155H, 16GB, 1TB, RTX 4060 8GB, 16.0 2.5K 240Hz)', 'new-100-acer-predator-triton-neo-16-ptn16-51-ultra-7-155h-16gb-1tb-rtx-4060-8gb-160-25k-240hz-349', N'CPU: Intel Core Ultra 7-155H (16 nhân 22 luồng, xung nhịp tối đa với Turbo Boost tới 4.8GHz, 24 MB Intel® Smart Cache) và AI Engine NPU | RAM: 16GB LPDDR5X 6400MHz | Ổ cứng: 1TB PCIe® NVMe™ M.2 SSD Gen 4 | GPU: NVIDIA® GeForce® RTX 4060 8GB GDDR6 | Màn hình: 16″ 2.5K+ (2560×1600) IPS, ComfyView, màn nhám chống lóa, không cảm ứng, tần số quét 240Hz, tỷ lệ khung hình 16:10, Calman Verified, độ phủ màu 100%sRGB, 90-91% DCI-P3 | Webcam: 720p HD camera với 3 mic thu tầm xa tích hợp công nghệ PurifiedVoice 2.0, không hỗ trợ IR | Cổng kết nối: 2x Type C ( Thunderbolt 4 ) 2x USB-A, 1X khe đọc-ghi thẻ Micro SD 1x HDMI, 1X khe khóa vật lý Kengshinton Lock 1X Jack tai nghe, chân cắm sạc tròn | Trọng lượng: 2.05 kg | Pin: 76wh, sạc 230W | Hệ điều hành: Window 11 bản quyền', 32490000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/05/sbkmgt2f-1380-acer-predator-triton-neo-16-2024-ptn16-51-74vn-ultra7-155h-ram-16gb-ssd-1tb-rtx-4060-8gb-16-2-5k-240hz-new.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);

SELECT @MainCategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';

INSERT INTO Products (Name, Slug, Description, Price, BrandId, CategoryId, Condition, Image, Quantity, Sold)
VALUES (N'[New 100%] Acer Predator Helios Neo 2024 (Core i9-14900HX, 16GB, 1TB, RTX 4060 8GB, 16 2K+ 180Hz)', 'new-100-acer-predator-helios-neo-2024-core-i9-14900hx-16gb-1tb-rtx-4060-8gb-16-2k-180hz-350', N'CPU: Intel Core i9-14900HX (24 Cores/ 32 Threads, up to 5.80 GHz, 36MB | RAM: 16 GB DDR5 5600MHz | Ổ cứng: 1TB PCIe NVMe SSD | GPU: NVIDIA GeForce RTX 4060 8GB 140W | Màn hình: 16″ 2K+ (2560 x 1600) IPS, LCD, LED, màn nhám, chống lóa, không cảm ứng, tần số quét màn 180Hz, tỷ lệ khung hình 16:10, độ phủ màu 100%sRGB | Webcam: HD Webcam | Cổng kết nối: 2x USB 3.2 Gen2 1x USB 3.2 Gen1 1x HDMI 2.1 1x RJ45 1x Jack 3.5mm 1x Cổng nguồn . | Pin: 4-cell, 90 Wh | Trọng lượng: 2.5 kg | Hệ điều hành: Window 11 bản quyền', 31690000, 5, @MainCategoryId, N'Mới 100%', 'https://thegioiso365.vn/wp-content/uploads/2025/01/3582_3463_3229_acer_predator_helios_neo_16_2024_front_thumbnail.jpg', 10, 0);
SET @ProductId = SCOPE_IDENTITY();

SELECT @CategoryId = Id FROM Categories WHERE Name = N'Laptop Gaming';
IF @CategoryId IS NOT NULL
    INSERT INTO ProductCategories (ProductId, CategoryId) VALUES (@ProductId, @CategoryId);
