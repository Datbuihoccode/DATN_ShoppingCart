namespace ShoppingCard.Models
{
    public class Paginate
    {
        public int ToltalItems { get; set; } // tong so item
        public int PageSize { get; set; } // so item tren moi trang
        public int CurrentPage { get; set; } // trang hien tai  
        public int TotalPages { get; private set; } // tong so trang
        public int StartPage { get; private set; } // trang bat dau
        public int EndPage { get; private set; } // trang ket thuc

        public Paginate()
        {
        }
        public Paginate(int toltalItems,int page, int pageSize = 10)// mac dinh trang hien tai la 1, co 10 item tren moi trang
        {
            //lam tron tong item/10 item tren moi trang. VD 33/10 = 3.3 => lam tron len thanh 4 trang
            int totalPages = (int)Math.Ceiling((decimal)toltalItems / (decimal)pageSize);
            int currentPage = page;// trang hien tai=1

            int startPage = currentPage - 5;// trang bat dau tru 5 button
            int endPage = currentPage + 4; // trang ket thuc cong 4 button

            if (startPage <= 0)
            {
                endPage -= (startPage - 1);// neu trang bat dau nho hon hoac bang 0 thi cong them cho trang ket thuc
                startPage = 1;
            }
            if (endPage > totalPages) // neu trang ket thuc lon hon tong so trang
            {
                endPage = totalPages; // gan trang ket thuc = tong so trang
                if (endPage > 10) // neu tong so trang lon hon 10
                {
                    startPage = endPage - 9; // gan trang bat dau = tong so trang -9
                }
            }

            ToltalItems = toltalItems;
            CurrentPage = currentPage;
            PageSize = pageSize;
            TotalPages = totalPages;
            StartPage = startPage;
            EndPage = endPage;
        }
    }
}
