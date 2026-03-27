using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/[controller]")]
    [Authorize(Roles = "Admin")]
    public class ContactController : Controller
    {
        private readonly DataContext _context;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public ContactController(DataContext context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
        }

        [Route("Index")]
        public IActionResult Index()
        {
            var contact = _context.Contacts.ToList();
            return View(contact);
        }

        [Route("Edit")]
        public async Task<IActionResult> Edit()
        {
            ContactModel contact = await _context.Contacts.FirstOrDefaultAsync();
            return View(contact);
        }
        [Route("Edit")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ContactModel contact)
        {
            var existingContact = await _context.Contacts.FirstOrDefaultAsync();//tim san pham trong db bang id

            //Bỏ qua lỗi validation của trường Image
            ModelState.Remove("LogoImg");

            if (ModelState.IsValid)
            {
                if (contact.ImageUpload != null)
                {
                    //upload new image
                    string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media/logo");
                    string imageName = Guid.NewGuid().ToString() + "_" + contact.ImageUpload.FileName;
                    string filePath = Path.Combine(uploadDir, imageName);
                    
                    FileStream fs = new FileStream(filePath, FileMode.Create);
                    await contact.ImageUpload.CopyToAsync(fs);
                    fs.Close();
                    existingContact.LogoImg = imageName;

                }
                //update san pham
                existingContact.Name = contact.Name;
                existingContact.Description = contact.Description;
                existingContact.Phone = contact.Phone;
                existingContact.Email = contact.Email;
                existingContact.Map = contact.Map;

                _context.Contacts.Update(existingContact);

                await _context.SaveChangesAsync();
                TempData["success"] = "Cập nhật thông tin thành công.";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["error"] = "Model có 1 vài thứ đang bị lỗi.";
                List<string> errors = new List<string>();

                foreach (var value in ModelState.Values)
                {
                    foreach (var error in value.Errors)
                    {
                        errors.Add(error.ErrorMessage);
                    }
                }
                string errorMessages = string.Join("\n", errors);
                return BadRequest(errorMessages);
            }

            return View(contact);
        }

    }
}
