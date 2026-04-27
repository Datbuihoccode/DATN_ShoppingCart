using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShoppingCard.Migrations
{
    /// <inheritdoc />
    public partial class LinkPaymentInfoToOrder : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "PaymentId",
                table: "VnpayInfos",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "OrderId",
                table: "MomoInfos",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_VnpayInfos_PaymentId",
                table: "VnpayInfos",
                column: "PaymentId",
                unique: true,
                filter: "[PaymentId] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_MomoInfos_OrderId",
                table: "MomoInfos",
                column: "OrderId",
                unique: true,
                filter: "[OrderId] IS NOT NULL");

            migrationBuilder.AddForeignKey(
                name: "FK_MomoInfos_Orders_OrderId",
                table: "MomoInfos",
                column: "OrderId",
                principalTable: "Orders",
                principalColumn: "OrderCode");

            migrationBuilder.AddForeignKey(
                name: "FK_VnpayInfos_Orders_PaymentId",
                table: "VnpayInfos",
                column: "PaymentId",
                principalTable: "Orders",
                principalColumn: "OrderCode");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_MomoInfos_Orders_OrderId",
                table: "MomoInfos");

            migrationBuilder.DropForeignKey(
                name: "FK_VnpayInfos_Orders_PaymentId",
                table: "VnpayInfos");

            migrationBuilder.DropIndex(
                name: "IX_VnpayInfos_PaymentId",
                table: "VnpayInfos");

            migrationBuilder.DropIndex(
                name: "IX_MomoInfos_OrderId",
                table: "MomoInfos");

            migrationBuilder.AlterColumn<string>(
                name: "PaymentId",
                table: "VnpayInfos",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "OrderId",
                table: "MomoInfos",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);
        }
    }
}
