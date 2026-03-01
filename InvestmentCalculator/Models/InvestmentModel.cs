using System.ComponentModel.DataAnnotations;

namespace InvestmentCalculator.Models
{
    public class InvestmentModel
    {
        public string InvestmentType { get; set; } // SIP or LumpSum

        [Required]
        public decimal Amount { get; set; }

        [Required]
        public double InterestRate { get; set; }

        [Required]
        public int Years { get; set; }

        public decimal TotalInvested { get; set; }
        public decimal FinalAmount { get; set; }
        public decimal Profit { get; set; }
    }
}
