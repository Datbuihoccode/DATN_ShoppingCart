using Microsoft.AspNetCore.Authorization;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Application.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class ProductController : Controller
    {
        private readonly IProductService _productService;
        private readonly ICategoryRepository _categoryRepository;
        private readonly IBrandRepository _brandRepository;

        public ProductController(IProductService productService, ICategoryRepository categoryRepository, IBrandRepository brandRepository)
        {
            _productService = productService;
            _categoryRepository = categoryRepository;
            _brandRepository = brandRepository;
        }

        [HttpGet]
        public async Task<IActionResult> Index(int pg = 1)
        {
            ViewBag.Brands = await _brandRepository.GetAllAsync();
            ViewBag.Categories = await _categoryRepository.GetAllAsync();

            var data = await _productService.GetProductsAsync();
            return View(data);
        }

        [HttpGet]
        public async Task<IActionResult> Create()
        {
            ViewBag.Categories = await _categoryRepository.GetAllAsync();
            ViewBag.Brands = new SelectList(await _brandRepository.GetAllAsync(), "Id", "Name");
            return View();
        }

        // -- Create product --
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CreateProductDto productDto)
        {
            if (productDto.CategoryIds == null || productDto.CategoryIds.Count == 0)
            {
                ModelState.AddModelError("CategoryIds", "Yêu cầu chọn ít nhất 1 danh mục.");
            }

            if (productDto.ImageUpload == null)
            {
                ModelState.AddModelError("ImageUpload", "Yêu cầu chọn hình ảnh.");
            }

            if (ModelState.IsValid)
            {
                try 
                {
                    await _productService.CreateProductAsync(productDto);
                    TempData["success"] = "Thêm sản phẩm thành công.";
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }

            ViewBag.Categories = await _categoryRepository.GetAllAsync();
            ViewBag.Brands = new SelectList(await _brandRepository.GetAllAsync(), "Id", "Name", productDto.BrandId);
            TempData["error"] = "Model có 1 vài thứ đang bị lỗi.";
            return View(productDto);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(long Id)
        {
            var p = await _productService.GetProductByIdAsync(Id);

            if (p == null)
            {
                TempData["error"] = "Không tìm thấy sản phẩm.";
                return RedirectToAction("Index");
            }

            var productDto = new CreateProductDto
            {
                Name = p.Name,
                Slug = p.Slug,
                Description = p.Description,
                Price = p.Price,
                BrandId = p.BrandId,
                Condition = p.Condition,
                WeightGram = p.WeightGram,
                CategoryIds = p.CategoryIds,
                // We keep the current image name in a ViewBag or add a property to CreateProductDto
            };
            ViewBag.CurrentImage = p.Image;

            ViewBag.Categories = await _categoryRepository.GetAllAsync();
            ViewBag.Brands = new SelectList(await _brandRepository.GetAllAsync(), "Id", "Name", productDto.BrandId);
            return View(productDto);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long Id, CreateProductDto productDto)
        {
            if (productDto.CategoryIds == null || productDto.CategoryIds.Count == 0)
            {
                ModelState.AddModelError("CategoryIds", "Yêu cầu chọn ít nhất 1 danh mục.");
            }

            if (ModelState.IsValid)
            {
                try 
                {
                    await _productService.UpdateProductAsync(Id, productDto);
                    TempData["success"] = "Cập nhật sản phẩm thành công.";
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }

            ViewBag.Categories = await _categoryRepository.GetAllAsync();
            ViewBag.Brands = new SelectList(await _brandRepository.GetAllAsync(), "Id", "Name", productDto.BrandId);
            TempData["error"] = "Có lỗi xảy ra, vui lòng kiểm tra lại.";
            return View(productDto);
        }

        public async Task<IActionResult> Delete(long Id)
        {
            await _productService.DeleteProductAsync(Id);
            TempData["success"] = "Đã xóa sản phẩm.";
            return RedirectToAction("Index");
        }

        //-- Add Quantity --
        [Route("AddQuantity")]
        [HttpGet]
        public async Task<IActionResult> AddQuantity(long Id)
        {
            var productbyquantity = await _productService.GetProductQuantitiesAsync(Id);

            ViewBag.ProductByQuantity = productbyquantity;
            ViewBag.ProductId = Id;
            return View();
        }

        [Route("StoreProductQuantity")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> StoreProductQuantity(long productId, int quantity)
        {
            try
            {
                await _productService.AddProductQuantityAsync(productId, quantity);
                TempData["success"] = "Thêm số lượng sản phẩm thành công.";
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
            }
            return RedirectToAction("Index", "Product");
        }
    }
}
