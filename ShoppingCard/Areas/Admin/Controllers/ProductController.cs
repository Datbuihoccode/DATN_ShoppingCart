using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class ProductController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public ProductController(DataContext context, IWebHostEnvironment webHostEnvironment)
        {
            _dataContext = context;
            _webHostEnvironment = webHostEnvironment;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            return View(await _dataContext.Products
                .OrderByDescending(p => p.Id)
                .Include(p => p.Category)
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .ToListAsync());
        }

        public async Task<IActionResult> Index(int pg = 1)
        {
            List<ProductModel> product = await _dataContext.Products
                .Include(p => p.Category)
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .ToListAsync();

            const int pageSize = 10;
            if (pg < 1) pg = 1;

            int recsCount = product.Count();
            var pager = new Paginate(recsCount, pg, pageSize);
            int recSkip = (pg - 1) * pageSize;
            var data = product.Skip(recSkip).Take(pager.PageSize).ToList();

            ViewBag.Pager = pager;
            return View(data);
        }

        [HttpGet]
        public IActionResult Create()
        {
            // Danh sách categories dạng multi-select
            ViewBag.Categories = _dataContext.Categories.ToList();
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name");
            return View();
        }

        // -- Create product --
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ProductModel product, List<int> SelectedCategoryIds)
        {
            ViewBag.Categories = _dataContext.Categories.ToList();
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name", product.BrandId);

            // Bỏ validate CategoryId (dùng SelectedCategoryIds thay thế)
            ModelState.Remove("CategoryId");

            if (SelectedCategoryIds == null || SelectedCategoryIds.Count == 0)
            {
                ModelState.AddModelError("SelectedCategoryIds", "Yêu cầu chọn ít nhất 1 danh mục.");
            }

            if (product.ImageUpload == null)
            {
                ModelState.AddModelError("ImageUpload", "Yêu cầu chọn hình ảnh.");
            }

            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(product.Slug))
                {
                    product.Slug = product.Name.Replace(" ", "-").ToLower();
                }

                var slug = await _dataContext.Products.FirstOrDefaultAsync(p => p.Slug == product.Slug);
                if (slug != null)
                {
                    ModelState.AddModelError("", "Sản phẩm với slug này đã tồn tại.");
                    return View(product);
                }

                // Upload ảnh
                string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/products");
                string imageName = Guid.NewGuid().ToString() + "_" + product.ImageUpload!.FileName;
                string filePath = Path.Combine(uploadDir, imageName);

                using (var fs = new FileStream(filePath, FileMode.Create))
                {
                    await product.ImageUpload.CopyToAsync(fs);
                }
                product.Image = imageName;

                // Gán CategoryId chính = danh mục đầu tiên được chọn
                product.CategoryId = SelectedCategoryIds.First();

                _dataContext.Products.Add(product);
                await _dataContext.SaveChangesAsync();

                // Lưu tất cả danh mục vào bảng ProductCategories
                foreach (var catId in SelectedCategoryIds)
                {
                    _dataContext.ProductCategories.Add(new ProductCategoryModel
                    {
                        ProductId = product.Id,
                        CategoryId = catId
                    });
                }
                await _dataContext.SaveChangesAsync();

                TempData["success"] = "Thêm sản phẩm thành công.";
                return RedirectToAction("Index");
            }

            TempData["error"] = "Model có 1 vài thứ đang bị lỗi.";
            return View(product);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(long Id)
        {
            ProductModel product = await _dataContext.Products
                .Include(p => p.ProductCategories)
                .FirstOrDefaultAsync(p => p.Id == Id);

            if (product == null)
            {
                TempData["error"] = "Không tìm thấy sản phẩm.";
                return RedirectToAction("Index");
            }

            // Danh sách Id danh mục đang được chọn
            product.SelectedCategoryIds = product.ProductCategories.Select(pc => pc.CategoryId).ToList();

            ViewBag.Categories = _dataContext.Categories.ToList();
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name", product.BrandId);
            return View(product);
        }

        // -- Edit product --
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ProductModel product, List<int> SelectedCategoryIds)
        {
            ViewBag.Categories = _dataContext.Categories.ToList();
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name", product.BrandId);

            ModelState.Remove("CategoryId");
            ModelState.Remove("Image");
            ModelState.Remove("ImageUpload");

            if (SelectedCategoryIds == null || SelectedCategoryIds.Count == 0)
            {
                ModelState.AddModelError("SelectedCategoryIds", "Yêu cầu chọn ít nhất 1 danh mục.");
            }

            if (ModelState.IsValid)
            {
                var existingProduct = await _dataContext.Products
                    .Include(p => p.ProductCategories)
                    .FirstOrDefaultAsync(p => p.Id == product.Id);

                if (existingProduct == null)
                {
                    TempData["error"] = "Không tìm thấy sản phẩm.";
                    return RedirectToAction("Index");
                }

                if (string.IsNullOrEmpty(product.Slug))
                {
                    product.Slug = product.Name.Replace(" ", "-").ToLower();
                }

                var slugExists = await _dataContext.Products
                    .FirstOrDefaultAsync(p => p.Slug == product.Slug && p.Id != product.Id);
                if (slugExists != null)
                {
                    ModelState.AddModelError("", "Sản phẩm với slug này đã tồn tại.");
                    return View(product);
                }

                // Xử lý upload ảnh mới nếu có
                if (product.ImageUpload != null)
                {
                    string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/products");
                    string imageName = Guid.NewGuid().ToString() + "_" + product.ImageUpload.FileName;
                    string filePath = Path.Combine(uploadDir, imageName);

                    if (!string.IsNullOrEmpty(existingProduct.Image) && existingProduct.Image != "noimage.jpg")
                    {
                        string oldfileImage = Path.Combine(uploadDir, existingProduct.Image);
                        if (System.IO.File.Exists(oldfileImage))
                            System.IO.File.Delete(oldfileImage);
                    }

                    using (var fs = new FileStream(filePath, FileMode.Create))
                    {
                        await product.ImageUpload.CopyToAsync(fs);
                    }
                    existingProduct.Image = imageName;
                }

                // Cập nhật thông tin cơ bản
                existingProduct.Name = product.Name;
                existingProduct.Slug = product.Slug;
                existingProduct.Description = product.Description;
                existingProduct.Price = product.Price;
                existingProduct.BrandId = product.BrandId;
                existingProduct.Condition = product.Condition;
                existingProduct.CategoryId = SelectedCategoryIds.First(); // CategoryId chính

                // Cập nhật danh mục: Xóa cũ → Thêm mới
                _dataContext.ProductCategories.RemoveRange(existingProduct.ProductCategories);
                foreach (var catId in SelectedCategoryIds)
                {
                    _dataContext.ProductCategories.Add(new ProductCategoryModel
                    {
                        ProductId = existingProduct.Id,
                        CategoryId = catId
                    });
                }

                _dataContext.Products.Update(existingProduct);
                await _dataContext.SaveChangesAsync();

                TempData["success"] = "Cập nhật sản phẩm thành công.";
                return RedirectToAction("Index");
            }

            TempData["error"] = "Có lỗi xảy ra, vui lòng kiểm tra lại.";
            return View(product);
        }

        //-- Delete product --
        public async Task<IActionResult> Delete(long Id)
        {
            ProductModel product = await _dataContext.Products
                .Include(p => p.ProductCategories)
                .FirstOrDefaultAsync(p => p.Id == Id);

            if (product == null)
            {
                TempData["error"] = "Không tìm thấy sản phẩm.";
                return RedirectToAction("Index");
            }

            if (!string.IsNullOrEmpty(product.Image) && product.Image != "noimage.jpg")
            {
                string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/products");
                string oldfileImage = Path.Combine(uploadDir, product.Image);
                if (System.IO.File.Exists(oldfileImage))
                    System.IO.File.Delete(oldfileImage);
            }

            // Xóa các liên kết danh mục trước
            _dataContext.ProductCategories.RemoveRange(product.ProductCategories);
            _dataContext.Products.Remove(product);
            await _dataContext.SaveChangesAsync();

            TempData["success"] = "Đã xóa sản phẩm.";
            return RedirectToAction("Index");
        }

        //-- Add Quantity --
        [Route("AddQuantity")]
        [HttpGet]
        public async Task<IActionResult> AddQuantity(long Id)
        {
            var productbyquantity = await _dataContext.ProductQuantities
                                        .Where(pq => pq.ProductId == Id)
                                        .ToListAsync();

            ViewBag.ProductByQuantity = productbyquantity;
            ViewBag.ProductId = Id;
            return View();
        }

        [Route("StoreProductQuantity")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> StoreProductQuantity(ProductQuantityModel productQuantity)
        {
            var product = await _dataContext.Products.FindAsync(productQuantity.ProductId);
            if (product == null)
            {
                TempData["error"] = "Không tìm thấy sản phẩm.";
                return RedirectToAction("Index");
            }

            productQuantity.CreatedDate = DateTime.Now;
            product.Quantity += productQuantity.Quantity;

            _dataContext.ProductQuantities.Add(productQuantity);
            await _dataContext.SaveChangesAsync();
            TempData["success"] = "Thêm số lượng sản phẩm thành công.";
            return RedirectToAction("Index", "Product");
        }
    }
}
