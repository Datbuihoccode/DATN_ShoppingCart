using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Infrastructure.Data;
using System.Threading.Tasks;
using System.Linq;
using System;
using System.IO;
using Microsoft.AspNetCore.Hosting;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/Slider")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class SliderController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public SliderController(DataContext context, IWebHostEnvironment webHostEnvironment)
        {
            _dataContext = context;
            _webHostEnvironment = webHostEnvironment;
        }

        [Route("Index")]
        public async Task<IActionResult> Index()
        {
            return View(await _dataContext.Sliders.OrderByDescending(p => p.Id).ToListAsync());
        }

        [Route("Create")]
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [Route("Create")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(SliderDto sliderDto)
        {
            if (!ModelState.IsValid)
            {
                TempData["error"] = "Model has validation errors.";
                return View(sliderDto);
            }

            var slider = new Slider
            {
                Name = sliderDto.Name,
                Description = sliderDto.Description,
                Status = sliderDto.Status
            };

            if (sliderDto.ImageUpload != null)
            {
                string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/sliders");
                Directory.CreateDirectory(uploadDir);

                string imageName = Guid.NewGuid() + "_" + sliderDto.ImageUpload.FileName;
                string filePath = Path.Combine(uploadDir, imageName);

                await using FileStream fs = new FileStream(filePath, FileMode.Create);
                await sliderDto.ImageUpload.CopyToAsync(fs);
                slider.Image = imageName;
            }

            _dataContext.Add(slider);
            await _dataContext.SaveChangesAsync();
            TempData["success"] = "Slider created successfully.";
            return RedirectToAction(nameof(Index));
        }

        [Route("Edit")]
        [HttpGet]
        public async Task<IActionResult> Edit(int Id)
        {
            if (Id <= 0)
            {
                TempData["error"] = "Invalid slider id.";
                return RedirectToAction(nameof(Index));
            }

            Slider slider = await _dataContext.Sliders.FindAsync(Id);
            if (slider == null)
            {
                TempData["error"] = "Slider not found.";
                return RedirectToAction(nameof(Index));
            }

            var sliderDto = new SliderDto
            {
                Id = slider.Id,
                Name = slider.Name,
                Description = slider.Description,
                Status = slider.Status,
                Image = slider.Image
            };

            return View(sliderDto);
        }

        [Route("Edit")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(SliderDto sliderDto)
        {
            if (sliderDto.Id <= 0)
            {
                TempData["error"] = "Invalid slider data.";
                return RedirectToAction(nameof(Index));
            }

            Slider sliderExisted = await _dataContext.Sliders.FindAsync(sliderDto.Id);
            if (sliderExisted == null)
            {
                TempData["error"] = "Slider not found.";
                return RedirectToAction(nameof(Index));
            }

            if (!ModelState.IsValid)
            {
                TempData["error"] = "Model has validation errors.";
                return View(sliderDto);
            }

            if (sliderDto.ImageUpload != null)
            {
                string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/sliders");
                Directory.CreateDirectory(uploadDir);

                if (!string.IsNullOrEmpty(sliderExisted.Image))
                {
                    string oldFileImage = Path.Combine(uploadDir, sliderExisted.Image);
                    if (System.IO.File.Exists(oldFileImage))
                    {
                        System.IO.File.Delete(oldFileImage);
                    }
                }

                string imageName = Guid.NewGuid() + "_" + sliderDto.ImageUpload.FileName;
                string filePath = Path.Combine(uploadDir, imageName);

                await using FileStream fs = new FileStream(filePath, FileMode.Create);
                await sliderDto.ImageUpload.CopyToAsync(fs);
                sliderExisted.Image = imageName;
            }

            sliderExisted.Name = sliderDto.Name;
            sliderExisted.Description = sliderDto.Description;
            sliderExisted.Status = sliderDto.Status;

            _dataContext.Update(sliderExisted);
            await _dataContext.SaveChangesAsync();
            TempData["success"] = "Slider updated successfully.";
            return RedirectToAction(nameof(Index));
        }

        [Route("Delete")]
        [HttpGet]
        public async Task<IActionResult> Delete(int Id)
        {
            Slider slider = await _dataContext.Sliders.FindAsync(Id);
            if (slider == null)
            {
                TempData["error"] = "Slider not found.";
                return RedirectToAction(nameof(Index));
            }

            if (!string.IsNullOrEmpty(slider.Image))
            {
                string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/sliders");
                string oldFileImage = Path.Combine(uploadDir, slider.Image);

                if (System.IO.File.Exists(oldFileImage))
                {
                    System.IO.File.Delete(oldFileImage);
                }
            }

            _dataContext.Sliders.Remove(slider);
            await _dataContext.SaveChangesAsync();
            TempData["success"] = "Slider deleted.";
            return RedirectToAction(nameof(Index));
        }
    }
}
