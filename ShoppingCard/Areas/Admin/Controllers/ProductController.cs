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
            return View(await _dataContext.Products.OrderByDescending(p => p.Id)
            .Include(p => p.Category)
            .Include(p => p.Brand)
            .ToListAsync()); 
        }

        public async Task<IActionResult> Index(int pg = 1)
        {
            List<ProductModel> product = _dataContext.Products
                                .Include(p => p.Category) // Kèm thêm Category
                                .Include(p => p.Brand)    // Kèm thêm Brand
                                .ToList();//

            const int pageSize = 10; //10 items/trang

            if (pg < 1) //page < 1;
            {
                pg = 1; //page ==1
            }
            int recsCount = product.Count(); //33 items;

            var pager = new Paginate(recsCount, pg, pageSize);

            int recSkip = (pg - 1) * pageSize; //(3 - 1) * 10; 

            //category.Skip(20).Take(10).ToList()

            var data = product.Skip(recSkip).Take(pager.PageSize).ToList();

            ViewBag.Pager = pager;

            return View(data);
        }

        [HttpGet]
        public IActionResult Create()
        {
            ViewBag.Categories = new SelectList(_dataContext.Categories, "Id", "Name");
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name");

            return View();
        }

        // -- Create product --
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ProductModel product)
        {
            ViewBag.Categories = new SelectList(_dataContext.Categories, "Id", "Name", product.CategoryId);
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name", product.BrandId);

            if (product.ImageUpload == null)
            {
                ModelState.AddModelError("ImageUpload", "Yêu cầu chọn hình ảnh.");
                return View(product);
            }

            if (ModelState.IsValid)
            {
                // Nếu slug trống thì tạo mặc định (nhưng View đã có script tạo slug sạch)
                if (string.IsNullOrEmpty(product.Slug)) {
                    product.Slug = product.Name.Replace(" ", "-").ToLower();
                }

                var slug = await _dataContext.Products.FirstOrDefaultAsync(p => p.Slug == product.Slug);
                if (slug != null)
                {
                    ModelState.AddModelError("","Sản phẩm với slug này đã tồn tại.");
                    return View(product);
                }
                
                if (product.ImageUpload != null)
                {
                    string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/products");
                    string imageName = Guid.NewGuid().ToString() + "_" + product.ImageUpload.FileName;
                    string filePath = Path.Combine(uploadDir, imageName);

                    FileStream fs = new FileStream(filePath, FileMode.Create);
                    await product.ImageUpload.CopyToAsync(fs);
                    fs.Close();
                    product.Image = imageName;

                }

                _dataContext.Products.Add(product);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Thêm sản phẩm thành công.";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["error"] = "Model có 1 vài thứ đang bị lỗi.";  
                return View(product);
            }
        }

        public async Task<IActionResult> Edit(long Id)
        {
            ProductModel product = await _dataContext.Products.FindAsync(Id);
            ViewBag.Categories = new SelectList(_dataContext.Categories, "Id", "Name", product.CategoryId);
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name", product.BrandId);
            return View(product);
        }

        // -- Edit product --

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ProductModel product)
        {
            var existingProduct = await _dataContext.Products.FindAsync(product.Id);
            ViewBag.Categories = new SelectList(_dataContext.Categories, "Id", "Name", product.CategoryId);
            ViewBag.Brands = new SelectList(_dataContext.Brands, "Id", "Name", product.BrandId);

            ModelState.Remove("Image");
            ModelState.Remove("ImageUpload");

            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(product.Slug)) {
                    product.Slug = product.Name.Replace(" ", "-").ToLower();
                }

                var slug = await _dataContext.Products.FirstOrDefaultAsync(p => p.Slug == product.Slug && p.Id != product.Id);
                if (slug != null)
                {
                    ModelState.AddModelError("", "Sản phẩm với slug này đã tồn tại.");
                    return View(product);
                }

                if (product.ImageUpload != null)
                {
                    string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/products");
                    string imageName = Guid.NewGuid().ToString() + "_" + product.ImageUpload.FileName;
                    string filePath = Path.Combine(uploadDir, imageName);

                    if (!string.IsNullOrEmpty(existingProduct.Image) && existingProduct.Image != "noimage.jpg")
                    {
                        string oldfileImage = Path.Combine(uploadDir, existingProduct.Image);
                        if (System.IO.File.Exists(oldfileImage))
                        {
                            System.IO.File.Delete(oldfileImage);
                        }
                    }

                    FileStream fs = new FileStream(filePath, FileMode.Create);
                    await product.ImageUpload.CopyToAsync(fs);
                    fs.Close();
                    existingProduct.Image = imageName;
                }

                existingProduct.Name = product.Name;
                existingProduct.Slug = product.Slug;
                existingProduct.Description = product.Description;
                existingProduct.Price = product.Price;
                existingProduct.CapitalPrice = product.CapitalPrice;
                existingProduct.CategoryId = product.CategoryId;
                existingProduct.BrandId = product.BrandId;

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
            ProductModel product = await _dataContext.Products.FindAsync(Id);

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
                {
                    System.IO.File.Delete(oldfileImage);
                }
            }

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
