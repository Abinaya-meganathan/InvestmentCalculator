using InvestmentCalculator.Models;
using Microsoft.AspNetCore.Mvc;

namespace InvestmentCalculator.Controllers
{
    public class CalculatorController : Controller
    {
        public IActionResult Index()
        {
            return View(new InvestmentModel());
        }

        [HttpPost]
        public IActionResult Index(InvestmentModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            double annualRate = model.InterestRate / 100;
            int months = model.Years * 12;

            if (model.InvestmentType == "LumpSum")
            {
                model.TotalInvested = model.Amount;

                model.FinalAmount =
                    model.Amount *
                    (decimal)Math.Pow(1 + annualRate, model.Years);
            }
            else // SIP
            {
                double monthlyRate = annualRate / 12;

                model.TotalInvested = model.Amount * months;

                model.FinalAmount =
                    model.Amount *
                    (decimal)(
                        (Math.Pow(1 + monthlyRate, months) - 1) *
                        (1 + monthlyRate) / monthlyRate
                    );
            }

            model.Profit = model.FinalAmount - model.TotalInvested;

            return View(model);
        }
    
    }
}
